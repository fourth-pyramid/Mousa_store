import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

@immutable
class Offer extends Equatable {
  const Offer({
    required this.id,
    required this.start,
    required this.end,
    required this.productId,
    required this.createdAt,
    required this.updatedAt,
    // required this.title,
    // required this.desc,
    required this.discountPrice,
  });

  factory Offer.fromJson(Map<String, dynamic> json) => Offer(
    id: json['id'] is int ? json['id'] as int : 0,
    start: json['start'] as String?,
    end: json['end'] as String?,
    productId: json['product_id'] is int ? json['product_id'] as int : 0,
    createdAt: json['created_at'] as String?,
    updatedAt: json['updated_at'] as String?,
    // title: json['title'] as String,
    // desc: json['desc'] as String,
    discountPrice: (json['disscount_price'] as num?)?.toDouble() ?? 0.0,
  );

  final int id;
  final String? start;
  final String? end;
  final int productId;
  final String? createdAt;
  final String? updatedAt;
  // final String title;
  // final String desc;
  final double discountPrice;

  Map<String, dynamic> toJson() => {
    'id': id,
    'start': start,
    'end': end,
    'product_id': productId,
    'created_at': createdAt,
    'updated_at': updatedAt,
    // 'title': title,
    // 'desc': desc,
    'disscount_price': discountPrice,
  };

  @override
  List<Object?> get props => [
    id,
    start,
    end,
    productId,
    createdAt,
    updatedAt,
    discountPrice,
  ];
}
