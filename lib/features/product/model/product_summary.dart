/// Data class to standardize product information across different product types
class ProductSummary {
  const ProductSummary({
    required this.id,
    required this.name,
    required this.price,
    required this.description,
    required this.imagePath,
    required this.offers,
  });

  final int id;
  final String name;
  final String price;
  final String description;
  final String imagePath;
  final List<BaseOffer> offers;
}

/// Generic offer interface that different offer types should implement
class BaseOffer {
  const BaseOffer({required this.discountPrice});
  final int discountPrice;
}
