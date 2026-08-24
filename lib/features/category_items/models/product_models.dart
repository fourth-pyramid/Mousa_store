import 'package:flutter/material.dart';

class Product {
  Product({
    required this.name,
    required this.price,
    required this.brandIndex,
    required this.colorIndex,
    required this.discount,
    required this.popularity,
    required this.createdAt,
  });
  final String name;
  final double price;
  final int brandIndex;
  final int colorIndex;
  final double discount;
  final int popularity;
  final DateTime createdAt;

  @override
  String toString() =>
      'Product(name: $name, price: $price, brandIndex: $brandIndex, colorIndex: $colorIndex, discount: $discount, popularity: $popularity, createdAt: $createdAt)';
}

enum ProductSort {
  mostPopular,
  nameAZ,
  nameZA,
  priceLowHigh,
  priceHighLow,
  latest,
  featuredDiscounts,
}

class ProductFilter {
  ProductFilter({this.brandId, this.priceRange, this.attributeIds});
  final int? brandId;
  final RangeValues? priceRange;
  final List<int>? attributeIds;

  bool get isEmpty =>
      brandId == null &&
      priceRange == null &&
      (attributeIds == null || attributeIds!.isEmpty);

  @override
  String toString() =>
      'ProductFilter(brandId: $brandId, priceRange: $priceRange, attributeIds: $attributeIds)';
}
