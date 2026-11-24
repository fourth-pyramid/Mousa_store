import 'package:mousa_store/core/utils/json_parsers.dart';

class Offer {
  Offer({
    this.id,
    this.start,
    this.end,
    this.productId,
    this.createdAt,
    this.updatedAt,
    this.title,
    this.desc,
    this.disscountPrice,
  });

  factory Offer.fromJson(Map<String, dynamic> json) => Offer(
    id: JsonParsers.toIntOrNull(json['id']),
    start: json['start'] as String?,
    end: json['end'] as String?,
    productId: JsonParsers.toIntOrNull(json['product_id']),
    createdAt: json['created_at'] == null
        ? null
        : DateTime.parse(json['created_at'] as String),
    updatedAt: json['updated_at'] == null
        ? null
        : DateTime.parse(json['updated_at'] as String),
    title: json['title'] as String?,
    desc: json['desc'] as String?,
    disscountPrice: JsonParsers.toIntOrNull(json['disscount_price']),
  );
  int? id;
  String? start;
  String? end;
  int? productId;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? title;
  String? desc;
  int? disscountPrice;

  Map<String, dynamic> toJson() => {
    'id': id,
    'start': start,
    'end': end,
    'product_id': productId,
    'created_at': createdAt?.toIso8601String(),
    'updated_at': updatedAt?.toIso8601String(),
    'title': title,
    'desc': desc,
    'disscount_price': disscountPrice,
  };
}
