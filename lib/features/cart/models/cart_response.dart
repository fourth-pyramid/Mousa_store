import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart' hide Category;
import 'package:mousa_store/core/models/offer.dart';
import 'package:mousa_store/features/brands/models/brand.dart';
import 'package:mousa_store/features/categories/models/category.dart';
import 'package:mousa_store/features/product/model/product.dart';

@immutable
class CartResponse extends Equatable {
  const CartResponse({required this.success, this.message, this.cart});

  factory CartResponse.fromJson(Map<String, dynamic> json) {
    // Handle empty cart response where data is an empty array
    if (json['data'] != null &&
        json['data'] is List &&
        (json['data'] as List).isEmpty) {
      return CartResponse(
        success: json['success'] as bool? ?? false,
        message: json['message'] as String?,
      );
    }

    return CartResponse(
      success: json['success'] as bool? ?? false,
      message: json['message'] as String?,
      cart: json['cart'] != null
          ? Cart.fromJson(json['cart'] as Map<String, dynamic>)
          : null,
    );
  }

  final bool success;
  final String? message;
  final Cart? cart;

  @override
  List<Object?> get props => [success, message, cart];
}

@immutable
class Cart extends Equatable {
  const Cart({
    required this.id,
    required this.userId,
    required this.total,
    required this.items,
    this.status,
    this.type,
    this.createdAt,
    this.updatedAt,
  });

  factory Cart.fromJson(Map<String, dynamic> json) => Cart(
    id: json['id'] as int? ?? 0,
    userId: json['user_id'] as int? ?? 0,
    status: json['status'] as String?,
    total: (json['total'] as num?)?.toDouble() ?? 0.0,
    type: json['type'] as String?,
    createdAt: json['created_at'] != null
        ? DateTime.tryParse(json['created_at'] as String)
        : null,
    updatedAt: json['updated_at'] != null
        ? DateTime.tryParse(json['updated_at'] as String)
        : null,
    items:
        (json['items'] as List<dynamic>?)
            ?.whereType<Map<String, dynamic>>()
            .map(CartItem.fromJson)
            .toList() ??
        const [],
  );

  final int id;
  final int userId;
  final String? status;
  final double total;
  final String? type;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final List<CartItem> items;

  Cart copyWith({
    int? id,
    int? userId,
    String? status,
    double? total,
    String? type,
    DateTime? createdAt,
    DateTime? updatedAt,
    List<CartItem>? items,
  }) => Cart(
    id: id ?? this.id,
    userId: userId ?? this.userId,
    status: status ?? this.status,
    total: total ?? this.total,
    type: type ?? this.type,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    items: items ?? this.items,
  );

  @override
  List<Object?> get props => [
    id,
    userId,
    status,
    total,
    type,
    createdAt,
    updatedAt,
    items,
  ];
}

@immutable
class CartItem extends Product {
  const CartItem({
    required super.id,
    required super.name,
    required super.desc,
    required super.price,
    required super.imagePath,
    required super.imagesPath,
    required this.quantity,
    this.productId,
    this.lineTotal,
    super.minQuantity,
    super.stock,
    super.createdAt,
    super.updatedAt,
    super.brandId,
    super.brand,
    super.categories,
    super.offers,
    super.properties,
    this.itemAttributes,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) {
    final product = Product.fromJson(json);
    return CartItem(
      id: product.id,
      productId: json['product_id'] as int?,
      name: product.name,
      desc: product.desc,
      price: product.price,
      imagePath: product.imagePath,
      imagesPath: product.imagesPath,
      quantity: json['quantity'] as int? ?? 1,
      lineTotal: (json['line_total'] as num?)?.toDouble(),
      minQuantity: product.minQuantity,
      stock: product.stock,
      createdAt: product.createdAt,
      updatedAt: product.updatedAt,
      brandId: product.brandId,
      brand: product.brand,
      categories: product.categories,
      offers: product.offers,
      properties: product.properties,
      itemAttributes: json['attributes'] is Map<String, dynamic>
          ? Map<String, String>.from(
              (json['attributes'] as Map<String, dynamic>).map(
                (k, v) => MapEntry(k, v.toString()),
              ),
            )
          : null,
    );
  }

  final int? productId;
  final int quantity;
  final double? lineTotal;
  final Map<String, String>? itemAttributes;

  CartItem copyWith({
    int? id,
    int? productId,
    String? name,
    String? desc,
    String? price,
    String? imagePath,
    List<String>? imagesPath,
    int? quantity,
    double? lineTotal,
    int? minQuantity,
    int? stock,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? brandId,
    Brand? brand,
    List<Category>? categories,
    List<Offer>? offers,
    Properties? properties,
    Map<String, String>? itemAttributes,
  }) => CartItem(
    id: id ?? this.id,
    productId: productId ?? this.productId,
    name: name ?? this.name,
    desc: desc ?? this.desc,
    price: price ?? this.price,
    imagePath: imagePath ?? this.imagePath,
    imagesPath: imagesPath ?? this.imagesPath,
    quantity: quantity ?? this.quantity,
    lineTotal: lineTotal ?? this.lineTotal,
    minQuantity: minQuantity ?? this.minQuantity,
    stock: stock ?? this.stock,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    brandId: brandId ?? this.brandId,
    brand: brand ?? this.brand,
    categories: categories ?? this.categories,
    offers: offers ?? this.offers,
    properties: properties ?? this.properties,
    itemAttributes: itemAttributes ?? this.itemAttributes,
  );

  @override
  List<Object?> get props => [
    ...super.props,
    productId,
    quantity,
    lineTotal,
    itemAttributes,
  ];
}
