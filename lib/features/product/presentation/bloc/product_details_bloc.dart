import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mousa_store/features/product/data/models/product_details_response.dart';
import 'package:mousa_store/features/product/presentation/bloc/product_details_event.dart';
import 'package:mousa_store/features/product/presentation/bloc/product_details_state.dart';

export 'package:mousa_store/features/product/presentation/bloc/product_details_event.dart';
export 'package:mousa_store/features/product/presentation/bloc/product_details_state.dart';

class ProductDetailsBloc
    extends Bloc<ProductDetailsEvent, ProductDetailsState> {
  ProductDetailsBloc({required ProductDetail product})
      : super(ProductDetailsState.initial(product)) {
    on<ProductDetailsStarted>(_onStarted);
    on<ProductDetailsAttributeChanged>(_onAttributeChanged);
    on<ProductDetailsQuantityChanged>(_onQuantityChanged);
    on<ProductDetailsProductUpdated>(_onProductUpdated);
  }

  void _onStarted(
    ProductDetailsStarted event,
    Emitter<ProductDetailsState> emit,
  ) {
    emit(ProductDetailsState.initial(event.product));
  }

  void _onAttributeChanged(
    ProductDetailsAttributeChanged event,
    Emitter<ProductDetailsState> emit,
  ) {
    final product = state.product;
    final normalizedKey = event.key.trim().toLowerCase();
    final isColor = normalizedKey == 'color' || normalizedKey == 'اللون';

    final updatedAttributes = Map<String, String>.from(state.selectedAttributes)
      ..[event.key] = event.value;

    var selectedVariant = state.selectedVariant;

    if (product.variants != null && product.variants!.isNotEmpty) {
      var matchingVariant = product.variants!
          .where((v) => v.stock > 0)
          .where(
            (v) => updatedAttributes.entries.every(
              (entry) => v.attributes?[entry.key] == entry.value,
            ),
          )
          .firstOrNull;

      if (matchingVariant == null && isColor) {
        matchingVariant = product.variants!
            .where((v) => v.attributes?[event.key] == event.value && v.stock > 0)
            .firstOrNull;
      }

      matchingVariant ??= product.variants!
          .where((v) => v.attributes?[event.key] == event.value && v.stock > 0)
          .firstOrNull;

      matchingVariant ??= product.variants!
          .where(
            (v) => updatedAttributes.entries.every(
              (entry) => v.attributes?[entry.key] == entry.value,
            ),
          )
          .firstOrNull;

      matchingVariant ??= product.variants!
          .where((v) => v.attributes?[event.key] == event.value)
          .firstOrNull;

      if (matchingVariant != null) {
        selectedVariant = matchingVariant;
        if (matchingVariant.attributes != null) {
          updatedAttributes
            ..clear()
            ..addAll(matchingVariant.attributes!);
        }
      }
    }

    final minQty = selectedVariant?.minQuantity ?? product.minQuantity;
    final maxQty = selectedVariant?.stock ?? product.stock;
    var newQty = state.selectedQuantity;
    if (newQty < minQty) newQty = minQty;
    if (newQty > maxQty) newQty = maxQty > 0 ? maxQty : 0;

    emit(
      state.copyWith(
        selectedAttributes: updatedAttributes,
        selectedVariant: selectedVariant,
        selectedQuantity: newQty,
      ),
    );
  }

  void _onQuantityChanged(
    ProductDetailsQuantityChanged event,
    Emitter<ProductDetailsState> emit,
  ) {
    final minQty =
        state.selectedVariant?.minQuantity ?? state.product.minQuantity;
    final maxQty = state.selectedVariant?.stock ?? state.product.stock;

    int newQty;
    if (event.quantity < minQty) {
      newQty = minQty;
    } else if (event.quantity > maxQty) {
      newQty = maxQty > 0 ? maxQty : 0;
    } else {
      newQty = event.quantity;
    }

    emit(state.copyWith(selectedQuantity: newQty));
  }

  void _onProductUpdated(
    ProductDetailsProductUpdated event,
    Emitter<ProductDetailsState> emit,
  ) {
    emit(ProductDetailsState.initial(event.product));
  }
}
