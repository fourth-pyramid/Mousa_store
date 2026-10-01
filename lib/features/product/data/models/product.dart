import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mousa_store/core/models/offer.dart';
import 'package:mousa_store/features/brands/data/models/brand_model.dart';
import 'package:mousa_store/features/brands/domain/entities/brand.dart';
import 'package:mousa_store/features/categories/data/models/category_model.dart';
import 'package:mousa_store/features/categories/domain/entities/category.dart';

part 'product.freezed.dart';

@Freezed(toJson: false, fromJson: false)
abstract class Product with _$Product {
  const Product._();

  const factory Product({
    required int id,
    required String name,
    required String desc,
    required String price,
    required String imagePath,
    required List<String> imagesPath,
    int? minQuantity,
    int? stock,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? brandId,
    Brand? brand,
    List<Category>? categories,
    List<Offer>? offers,
    Properties? properties,
    List<Variant>? variants,
  }) = _Product;

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
        desc:
            (json['description'] as String?) ?? (json['desc'] as String?) ?? '',
        price: json['price']?.toString() ?? '0',
        imagePath: json['image_path'] as String? ?? '',
        imagesPath: (json['images_path'] as List<dynamic>?)
                ?.map((e) => e.toString())
                .toList() ??
            const [],
        brand: json['brand'] is Map<String, dynamic>
            ? BrandModel.fromJson(json['brand'] as Map<String, dynamic>)
            : null,
        categories: (json['categories'] as List<dynamic>?)
            ?.map((e) => CategoryModel.fromJson(e as Map<String, dynamic>))
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
}

@Freezed(toJson: false, fromJson: false)
abstract class Variant with _$Variant {
  const Variant._();

  const factory Variant({
    required int id,
    required String price,
    required int stock,
    required String imagePath,
    required List<String> imagesPath,
    Map<String, String>? attributes,
    List<Offer>? offers,
  }) = _Variant;

  factory Variant.fromJson(Map<String, dynamic> json) => Variant(
        id: json['id'] is int ? json['id'] as int : 0,
        price: json['price']?.toString() ?? '0',
        stock: json['stock'] is int ? json['stock'] as int : 0,
        imagePath: json['image_path'] as String? ?? '',
        imagesPath: (json['images_path'] as List<dynamic>?)
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

  Map<String, dynamic> toJson() => {
        'id': id,
        'price': price,
        'stock': stock,
        'image_path': imagePath,
        'images_path': imagesPath,
        'attributes': attributes,
        'offers': offers?.map((e) => e.toJson()).toList(),
      };
}

@Freezed(toJson: false, fromJson: false)
abstract class Properties with _$Properties {
  const Properties._();

  const factory Properties({
    required List<String> color,
  }) = _Properties;

  factory Properties.fromJson(Map<String, dynamic> json) => Properties(
        color: (json['color'] as List<dynamic>?)
                ?.map((e) => e.toString())
                .toList() ??
            const [],
      );

  Map<String, dynamic> toJson() => {'color': color};
}
