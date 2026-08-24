class Pivot {
  Pivot({this.productId, this.categoryId});

  factory Pivot.fromJson(Map<String, dynamic> json) => Pivot(
    productId: json['product_id'] as int?,
    categoryId: json['category_id'] as int?,
  );
  int? productId;
  int? categoryId;

  Map<String, dynamic> toJson() => {
    'product_id': productId,
    'category_id': categoryId,
  };
}
