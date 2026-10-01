import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mousa_store/features/product/data/models/product_details_response.dart';

part 'product_details_state.freezed.dart';

@freezed
sealed class ProductDetailsState with _$ProductDetailsState {
  const ProductDetailsState._();

  const factory ProductDetailsState({
    required ProductDetail product,
    @Default(<String, String>{}) Map<String, String> selectedAttributes,
    @Default(1) int selectedQuantity,
    ProductVariant? selectedVariant,
  }) = _ProductDetailsState;

  factory ProductDetailsState.initial(ProductDetail product) {
    final attributes = <String, String>{};
    ProductVariant? selectedVariant;
    var selectedQuantity = 1;

    if (product.variants != null && product.variants!.isNotEmpty) {
      final initialVariant =
          product.variants!.where((v) => v.stock > 0).firstOrNull ??
          product.variants!.first;

      selectedVariant = initialVariant;
      if (initialVariant.attributes != null) {
        attributes.addAll(initialVariant.attributes!);
      }
      selectedQuantity = initialVariant.minQuantity;
    } else if (product.properties?.values.isNotEmpty ?? false) {
      product.properties!.values.forEach((key, values) {
        if (values.isNotEmpty) {
          attributes[key] = values.first;
        }
      });
      selectedQuantity = product.minQuantity;
    }

    return ProductDetailsState(
      product: product,
      selectedAttributes: attributes,
      selectedQuantity: selectedQuantity,
      selectedVariant: selectedVariant,
    );
  }

  /// Checks if an attribute value is "available" given current selections.
  List<String> getAvailableValues(String attrKey) {
    if (product.variants == null || product.variants!.isEmpty) {
      return product.properties?.values[attrKey] ?? [];
    }

    final normalizedAttrKey = attrKey.trim().toLowerCase();
    final isColor =
        normalizedAttrKey == 'color' || normalizedAttrKey == 'اللون';
    final selectedColor = selectedAttributes.entries
        .where((e) {
          final k = e.key.trim().toLowerCase();
          return k == 'color' || k == 'اللون';
        })
        .map((e) => e.value)
        .firstOrNull;

    if (isColor) {
      return product.variants!
          .where((v) => v.stock > 0)
          .map((v) => v.attributes?[attrKey])
          .whereType<String>()
          .toSet()
          .toList();
    } else if (selectedColor != null) {
      return product.variants!
          .where(
            (v) =>
                v.stock > 0 &&
                (v.attributes?.entries.any((e) {
                      final k = e.key.trim().toLowerCase();
                      return (k == 'color' || k == 'اللون') &&
                          e.value == selectedColor;
                    }) ??
                    false),
          )
          .map((v) => v.attributes?[attrKey])
          .whereType<String>()
          .toSet()
          .toList();
    }

    return product.variants!
        .where((v) => v.stock > 0)
        .map((v) => v.attributes?[attrKey])
        .whereType<String>()
        .toSet()
        .toList();
  }
}
