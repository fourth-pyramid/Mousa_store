import 'package:flutter/material.dart';

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
