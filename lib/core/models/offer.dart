import 'package:freezed_annotation/freezed_annotation.dart';

part 'offer.freezed.dart';

@Freezed(toJson: false, fromJson: false)
abstract class Offer with _$Offer {
  const Offer._();

  const factory Offer({
    required int id,
    required int productId,
    String? start,
    String? end,
    String? createdAt,
    String? updatedAt,
    @Default(0.0) double discountPrice,
  }) = _Offer;

  factory Offer.fromJson(Map<String, dynamic> json) => Offer(
        id: json['id'] is int ? json['id'] as int : 0,
        productId: json['product_id'] is int ? json['product_id'] as int : 0,
        start: json['start'] as String?,
        end: json['end'] as String?,
        createdAt: json['created_at'] as String?,
        updatedAt: json['updated_at'] as String?,
        discountPrice: (json['disscount_price'] as num?)?.toDouble() ?? 0.0,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'product_id': productId,
        'start': start,
        'end': end,
        'created_at': createdAt,
        'updated_at': updatedAt,
        'disscount_price': discountPrice,
      };
}
