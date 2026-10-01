import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mousa_store/core/models/offer.dart';
import 'package:mousa_store/features/brands/domain/entities/brand.dart';
import 'package:mousa_store/features/categories/domain/entities/category.dart';
import 'package:mousa_store/features/product/data/models/product.dart';

part 'cart_response.freezed.dart';

@Freezed(toJson: false, fromJson: false)
abstract class CartResponse with _$CartResponse {
  const factory CartResponse({
    required bool success,
    String? message,
    Cart? cart,
  }) = _CartResponse;

  factory CartResponse.fromJson(Map<String, dynamic> json) {
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
}

@Freezed(toJson: false, fromJson: false)
abstract class Cart with _$Cart {
  const factory Cart({
    required int id,
    required int userId,
    required double total,
    required List<CartItem> items,
    String? status,
    String? type,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _Cart;

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
        items: (json['items'] as List<dynamic>?)
                ?.whereType<Map<String, dynamic>>()
                .map(CartItem.fromJson)
                .toList() ??
            const [],
      );
}

@Freezed(toJson: false, fromJson: false)
abstract class CartItem with _$CartItem {
  const CartItem._();

  const factory CartItem({
    required int id,
    required String name,
    required String desc,
    required String price,
    required String imagePath,
    required List<String> imagesPath,
    required int quantity,
    int? productId,
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
  }) = _CartItem;

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

  Map<String, dynamic> toJson() => {
        'id': id,
        'product_id': productId,
        'name': name,
        'desc': desc,
        'price': price,
        'image_path': imagePath,
        'images_path': imagesPath,
        'quantity': quantity,
        'line_total': lineTotal,
        'min_quantity': minQuantity,
        'stock': stock,
        'created_at': createdAt?.toIso8601String(),
        'updated_at': updatedAt?.toIso8601String(),
        'brand_id': brandId,
        'brand': brand?.toJson(),
        'categories': categories?.map((e) => e.toJson()).toList(),
        'offers': offers?.map((e) => e.toJson()).toList(),
        'properties': properties?.toJson(),
        'attributes': itemAttributes,
      };
}
