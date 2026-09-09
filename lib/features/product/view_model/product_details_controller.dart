import 'package:flutter/material.dart';
import 'package:mousa_store/features/product/model/product_details_response.dart';

class ProductDetailsController extends ChangeNotifier {
  ProductDetailsController(this.product) {
    _initializeState();
  }

  ProductDetail product;

  final Map<String, String> _selectedAttributes = {};
  int _selectedQuantity = 1;
  ProductVariant? _selectedVariant;

  Map<String, String> get selectedAttributes => _selectedAttributes;
  int get selectedQuantity => _selectedQuantity;
  ProductVariant? get selectedVariant => _selectedVariant;

  void _initializeState() {
    if (product.variants != null && product.variants!.isNotEmpty) {
      // Find first variant with stock, or just the first one
      final initialVariant =
          product.variants!.where((v) => v.stock > 0).firstOrNull ??
          product.variants!.first;

      _selectedVariant = initialVariant;
      if (initialVariant.attributes != null) {
        _selectedAttributes.addAll(initialVariant.attributes!);
      }
      _selectedQuantity = initialVariant.minQuantity;
    } else if (product.properties?.values.isNotEmpty ?? false) {
      product.properties!.values.forEach((key, values) {
        if (values.isNotEmpty) {
          _selectedAttributes[key] = values.first;
        }
      });
      _selectedQuantity = product.minQuantity;
    }
  }

  void updateAttribute(String key, String value) {
    final normalizedKey = key.trim().toLowerCase();
    final isColor = normalizedKey == 'color' || normalizedKey == 'اللون';
    _selectedAttributes[key] = value;

    if (product.variants != null && product.variants!.isNotEmpty) {
      // 1. Try to find an exact match for all currently selected attributes that has stock
      var matchingVariant = product.variants!
          .where((v) => v.stock > 0)
          .where(
            (v) => _selectedAttributes.entries.every(
              (entry) => v.attributes?[entry.key] == entry.value,
            ),
          )
          .firstOrNull;

      // 2. If no exact match with stock, and we just changed color,
      // find ANY variant with that color that has stock
      if (matchingVariant == null && isColor) {
        matchingVariant = product.variants!
            .where((v) => v.attributes?[key] == value && v.stock > 0)
            .firstOrNull;
      }

      // 3. If still null, find any variant that matches our CURRENT changed attribute and has stock
      matchingVariant ??= product.variants!
          .where((v) => v.attributes?[key] == value && v.stock > 0)
          .firstOrNull;

      // 4. Fallback: Find matching variant even if out of stock
      matchingVariant ??= product.variants!
          .where(
            (v) => _selectedAttributes.entries.every(
              (entry) => v.attributes?[entry.key] == entry.value,
            ),
          )
          .firstOrNull;

      // 5. Fallback: find any variant that matches our changed attribute
      matchingVariant ??= product.variants!
          .where((v) => v.attributes?[key] == value)
          .firstOrNull;

      if (matchingVariant != null) {
        _selectedVariant = matchingVariant;
        // Update selection map to match the variant's REAL attributes
        if (matchingVariant.attributes != null) {
          _selectedAttributes
            ..clear()
            ..addAll(matchingVariant.attributes!);
        }
      }

      _capQuantity();
    }
    notifyListeners();
  }

  void updateQuantity(int quantity) {
    final minQty = _selectedVariant?.minQuantity ?? product.minQuantity;
    final maxQty = _selectedVariant?.stock ?? product.stock;

    if (quantity < minQty) {
      _selectedQuantity = minQty;
    } else if (quantity > maxQty) {
      _selectedQuantity = maxQty > 0 ? maxQty : 0;
    } else {
      _selectedQuantity = quantity;
    }
    notifyListeners();
  }

  void _capQuantity() {
    final minQty = _selectedVariant?.minQuantity ?? product.minQuantity;
    final maxQty = _selectedVariant?.stock ?? product.stock;

    if (_selectedQuantity < minQty) {
      _selectedQuantity = minQty;
    }
    if (_selectedQuantity > maxQty) {
      _selectedQuantity = maxQty > 0 ? maxQty : 0;
    }
  }

  /// Checks if an attribute value is "available" given current selections.
  /// If [attrKey] is 'Color', all colors that exist in variants with stock are available.
  /// If [attrKey] is something else (e.g. Storage), it checks if there is a variant
  /// with the SELECTED COLOR that has this value and has stock.
  List<String> getAvailableValues(String attrKey) {
    if (product.variants == null || product.variants!.isEmpty) {
      return product.properties?.values[attrKey] ?? [];
    }

    final normalizedAttrKey = attrKey.trim().toLowerCase();
    final isColor =
        normalizedAttrKey == 'color' || normalizedAttrKey == 'اللون';
    final selectedColor = _selectedAttributes.entries
        .where((e) {
          final k = e.key.trim().toLowerCase();
          return k == 'color' || k == 'اللون';
        })
        .map((e) => e.value)
        .firstOrNull;

    if (isColor) {
      // For color, any color that exists in a variant with stock is available
      return product.variants!
          .where((v) => v.stock > 0)
          .map((v) => v.attributes?[attrKey])
          .whereType<String>()
          .toSet()
          .toList();
    } else if (selectedColor != null) {
      // For other attributes, only show values available for the CURRENT selected color with stock
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

    // Default fallback
    return product.variants!
        .where((v) => v.stock > 0)
        .map((v) => v.attributes?[attrKey])
        .whereType<String>()
        .toSet()
        .toList();
  }

  void updateProduct(ProductDetail newProduct) {
    product = newProduct;
    notifyListeners();
  }
}
