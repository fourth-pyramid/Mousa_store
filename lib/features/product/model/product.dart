import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart' hide Category;
import 'package:mousa_store/core/models/offer.dart';
import 'package:mousa_store/features/brands/models/brand.dart';
import 'package:mousa_store/features/categories/models/category.dart';

@immutable
class Product extends Equatable {
  const Product({
    required this.id,
    required this.name,
    required this.desc,
    required this.price,
    required this.imagePath,
    required this.imagesPath,
    this.minQuantity,
    this.stock,
    this.createdAt,
    this.updatedAt,
    this.brandId,
    this.brand,
    this.categories,
    this.offers,
    this.properties,
    this.variants,
  });
  // ... (keep factory same but ensure types are correct)
  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json['id'] is int
        ? json['id'] as int
        : int.tryParse(json['id']?.toString() ?? '0') ?? 0,
    minQuantity: json['min_quantity'] as int?,
    stock: json['stock'] as int?,
    createdAt: json['created_at'] == null
        ? null
        : DateTime.tryParse(json['created_at'] as String),
    updatedAt: json['updated_at'] == null
        ? null
        : DateTime.tryParse(json['updated_at'] as String),
    brandId: json['brand_id'] as int?,
    name: json['name'] as String? ?? json['title'] as String? ?? '',
    desc: (json['description'] as String?) ?? (json['desc'] as String?) ?? '',
    price: json['price']?.toString() ?? '0',
    imagePath: json['image_path'] as String? ?? '',
    imagesPath:
        (json['images_path'] as List<dynamic>?)
            ?.map((e) => e.toString())
            .toList() ??
        const [],
    brand: json['brand'] is Map<String, dynamic>
        ? Brand.fromJson(json['brand'] as Map<String, dynamic>)
        : null,
    categories: (json['categories'] as List<dynamic>?)
        ?.map((e) => Category.fromJson(e as Map<String, dynamic>))
        .toList(),
    properties: json['properties'] is Map<String, dynamic>
        ? Properties.fromJson(json['properties'] as Map<String, dynamic>)
        : null,
    offers: (json['offers'] as List<dynamic>?)
        ?.map((e) => Offer.fromJson(e as Map<String, dynamic>))
        .toList(),
    variants: (json['variants'] as List<dynamic>?)
        ?.map((e) => Variant.fromJson(e as Map<String, dynamic>))
        .toList(),
  );

  final int id;
  final int? minQuantity;
  final int? stock;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? brandId;
  final String name;
  final String desc;
  final String price;
  final String imagePath;
  final List<String> imagesPath;
  final Brand? brand;
  final List<Category>? categories;
  final List<Offer>? offers;
  final Properties? properties;
  final List<Variant>? variants;

  String get displayPrice => price != '0'
      ? price
      : (variants?.isNotEmpty ?? false ? variants!.first.price : '0');
  String get displayImage => imagePath.isNotEmpty
      ? imagePath
      : (variants?.isNotEmpty ?? false ? variants!.first.imagePath : '');

  int get displayStock =>
      (variants?.isNotEmpty ?? false) ? variants!.first.stock : (stock ?? 0);

  Map<String, dynamic> toJson() => {
    'id': id,
    'min_quantity': minQuantity,
    'stock': stock,
    'created_at': createdAt?.toIso8601String(),
    'updated_at': updatedAt?.toIso8601String(),
    'brand_id': brandId,
    'name': name,
    'desc': desc,
    'price': price,
    'image_path': imagePath,
    'images_path': imagesPath,
    'brand': brand?.toJson(),
    'categories': categories?.map((e) => e.toJson()).toList(),
    'offers': offers?.map((e) => e.toJson()).toList(),
    'properties': properties?.toJson(),
    'variants': variants?.map((e) => e.toJson()).toList(),
  };

  @override
  List<Object?> get props => [
    id,
    minQuantity,
    stock,
    createdAt,
    updatedAt,
    brandId,
    name,
    desc,
    price,
    imagePath,
    imagesPath,
    brand,
    categories,
    offers,
    properties,
    variants,
  ];
}

@immutable
class Variant extends Equatable {
  const Variant({
    required this.id,
    required this.price,
    required this.stock,
    required this.imagePath,
    required this.imagesPath,
    this.attributes,
    this.offers,
  });

  factory Variant.fromJson(Map<String, dynamic> json) => Variant(
    id: json['id'] is int ? json['id'] as int : 0,
    price: json['price']?.toString() ?? '0',
    stock: json['stock'] is int ? json['stock'] as int : 0,
    imagePath: json['image_path'] as String? ?? '',
    imagesPath:
        (json['images_path'] as List<dynamic>?)
            ?.map((e) => e.toString())
            .toList() ??
        const [],
    attributes: json['attributes'] is Map<String, dynamic>
        ? (json['attributes'] as Map<String, dynamic>).map(
            (k, v) => MapEntry(k, v.toString()),
          )
        : null,
    offers: (json['offers'] as List<dynamic>?)
        ?.map((e) => Offer.fromJson(e as Map<String, dynamic>))
        .toList(),
  );

  final int id;
  final String price;
  final int stock;
  final String imagePath;
  final List<String> imagesPath;
  final Map<String, String>? attributes;
  final List<Offer>? offers;

  Map<String, dynamic> toJson() => {
    'id': id,
    'price': price,
    'stock': stock,
    'image_path': imagePath,
    'images_path': imagesPath,
    'attributes': attributes,
    'offers': offers?.map((e) => e.toJson()).toList(),
  };

  @override
  List<Object?> get props => [
    id,
    price,
    stock,
    imagePath,
    imagesPath,
    attributes,
    offers,
  ];
}

@immutable
class Properties extends Equatable {
  const Properties({required this.color});

  factory Properties.fromJson(Map<String, dynamic> json) => Properties(
    color:
        (json['color'] as List<dynamic>?)?.map((e) => e.toString()).toList() ??
        const [],
  );
  final List<String> color;

  Map<String, dynamic> toJson() => {'color': color};

  @override
  List<Object?> get props => [color];
}
