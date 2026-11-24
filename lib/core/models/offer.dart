import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mousa_store/core/utils/json_parsers.dart';

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
    id: JsonParsers.toInt(json['id']),
    productId: JsonParsers.toInt(json['product_id']),
    start: json['start'] as String?,
    end: json['end'] as String?,
    createdAt: json['created_at'] as String?,
    updatedAt: json['updated_at'] as String?,
    discountPrice: JsonParsers.toDouble(json['disscount_price']),
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
