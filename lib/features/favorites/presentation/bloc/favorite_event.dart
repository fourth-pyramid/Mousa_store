import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mousa_store/features/product/data/models/product.dart';

part 'favorite_event.freezed.dart';

@freezed
sealed class FavoriteEvent with _$FavoriteEvent {
  const factory FavoriteEvent.fetchRequested() = FavoritesFetchRequested;

  const factory FavoriteEvent.toggled({
    required int productId,
    Product? product,
  }) = FavoriteToggled;

  const factory FavoriteEvent.resetRequested() = FavoriteResetRequested;
}
