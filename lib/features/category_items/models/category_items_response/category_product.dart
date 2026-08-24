import 'package:equatable/equatable.dart';
import 'package:mousa_store/core/models/offer.dart';
import 'package:mousa_store/features/category_items/models/category_items_response/brand.dart';
import 'package:mousa_store/features/category_items/models/category_items_response/item_category.dart';
import 'package:mousa_store/features/product/model/product.dart';

class CategoryProduct extends Equatable {
  const CategoryProduct({
    this.id,
    this.minQuantity,
    this.stock,
    this.createdAt,
    this.updatedAt,
    this.brandId,
    this.name,
    this.desc,
    this.price,
    this.imagePath,
    this.imagesPath,
    this.brand,
    this.categories,
    this.offers,
    this.variants,
    this.attributes,
  });

  factory CategoryProduct.fromJson(Map<String, dynamic> json) {
    final brandData = json['brand'] is Map<String, dynamic>
        ? Brand.fromJson(json['brand'] as Map<String, dynamic>)
        : null;

    return CategoryProduct(
      id: json['id'] is int
          ? json['id'] as int
          : int.tryParse(json['id']?.toString() ?? '0'),
      minQuantity: int.tryParse(json['min_quantity']?.toString() ?? '1'),
      stock: int.tryParse(json['stock']?.toString() ?? '0'),
      createdAt: json['created_at'] == null
          ? null
          : DateTime.tryParse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.tryParse(json['updated_at'] as String),
      brandId: json['brand_id'] is int
          ? json['brand_id'] as int
          : int.tryParse(json['brand_id']?.toString() ?? '0'),
      name: json['name'] as String? ?? json['title'] as String? ?? '',
      desc: json['description'] as String? ?? json['desc'] as String? ?? '',
      price: json['price']?.toString(),
      imagePath: json['image_path'] as String? ?? '',
      imagesPath:
          (json['images_path'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
      brand: brandData,
      categories:
          (json['categories'] as List<dynamic>?)
              ?.map((e) => ItemCategory.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      offers:
          (json['offers'] as List<dynamic>?)
              ?.map((e) => Offer.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      variants:
          (json['variants'] as List<dynamic>?)
              ?.map((e) => Variant.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      attributes: json['attributes'] as Map<String, dynamic>?,
    );
  }

  final int? id;
  final int? minQuantity;
  final int? stock;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? brandId;
  final String? name;
  final String? desc;
  final String? price;
  final String? imagePath;
  final List<String>? imagesPath;
  final Brand? brand;
  final List<ItemCategory>? categories;
  final List<Offer>? offers;
  final List<Variant>? variants;
  final Map<String, dynamic>? attributes;

  String get displayPrice => price != null && price != '0'
      ? price!
      : (variants?.isNotEmpty ?? false ? variants!.first.price : '0');

  String get displayImage => imagePath != null && imagePath!.isNotEmpty
      ? imagePath!
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
    'variants': variants?.map((e) => e.toJson()).toList(),
    'attributes': attributes,
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
    variants,
    attributes,
  ];
}
