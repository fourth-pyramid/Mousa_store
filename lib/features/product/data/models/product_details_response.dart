class ProductDetailsResponse {
  ProductDetailsResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory ProductDetailsResponse.fromJson(Map<String, dynamic> json) =>
      ProductDetailsResponse(
        success: json['success'] as bool,
        message: json['message'] as String,
        data: ProductDetail.fromJson(json['data'] as Map<String, dynamic>),
      );

  final bool success;
  final String message;
  final ProductDetail data;

  Map<String, dynamic> toJson() => {
    'success': success,
    'message': message,
    'data': data.toJson(),
  };
}

class ProductDetail {
  ProductDetail({
    required this.id,
    required this.minQuantity,
    required this.stock,
    required this.name,
    required this.desc,
    this.properties,
    this.brand,
    this.variants,
    this.reviews,
  });

  factory ProductDetail.fromJson(Map<String, dynamic> json) {
    final variantsJson = json['variants'] as List<dynamic>?;
    final productVariants = variantsJson
        ?.map((e) => ProductVariant.fromJson(e as Map<String, dynamic>))
        .toList();

    // Extract properties from variants if not present at top level
    ProductAttributes? properties;
    if (json['properties'] != null) {
      properties = ProductAttributes.fromJson(
        json['properties'] as Map<String, dynamic>,
      );
    } else if (productVariants != null && productVariants.isNotEmpty) {
      // Collect all unique attributes from variants
      final attributeValues = <String, Set<String>>{};
      for (final variant in productVariants) {
        variant.attributes?.forEach((key, value) {
          final normalizedKey = _normalizeKey(key);
          attributeValues.putIfAbsent(normalizedKey, () => {}).add(value);
        });
      }

      final propertiesMap = attributeValues.map(
        (key, value) => MapEntry(key, value.toList()),
      );
      if (propertiesMap.isNotEmpty) {
        properties = ProductAttributes.fromJson(propertiesMap);
      }
    }

    final reviewsJson = json['reviews'] as List<dynamic>?;
    final reviews = reviewsJson
        ?.map((e) => ProductReview.fromJson(e as Map<String, dynamic>))
        .toList();

    return ProductDetail(
      id: json['id'] is int
          ? json['id'] as int
          : int.tryParse(json['id']?.toString() ?? '0') ?? 0,
      minQuantity: json['min_quantity'] as int? ?? 1,
      stock: json['stock'] as int? ?? 0,
      name: json['name'] as String? ?? json['title'] as String? ?? '',
      desc: (json['description'] as String?) ?? (json['desc'] as String?) ?? '',
      properties: properties,
      brand: json['brand'] != null
          ? Brand.fromJson(json['brand'] as Map<String, dynamic>)
          : null,
      variants: productVariants,
      reviews: reviews,
    );
  }

  double get averageRating {
    if (reviews == null || reviews!.isEmpty) return 0.0;
    final total = reviews!.fold<double>(0, (sum, item) => sum + item.rate);
    return total / reviews!.length;
  }

  int get reviewsCount => reviews?.length ?? 0;

  Map<int, int> get ratingDistribution {
    final distribution = {5: 0, 4: 0, 3: 0, 2: 0, 1: 0};
    if (reviews == null) return distribution;
    for (final review in reviews!) {
      final rate = review.rate.round();
      if (rate >= 1 && rate <= 5) {
        distribution[rate] = (distribution[rate] ?? 0) + 1;
      }
    }
    return distribution;
  }

  String get displayPrice {
    if (variants != null && variants!.isNotEmpty) return variants!.first.price;
    return '0';
  }

  String get displayImage {
    if (variants != null && variants!.isNotEmpty) {
      return variants!.first.imagePath;
    }
    return '';
  }

  List<String> get imagesPath {
    if (variants != null && variants!.isNotEmpty) {
      return variants!.first.imagesPath;
    }
    return [];
  }

  int get displayStock =>
      (variants?.isNotEmpty ?? false) ? variants!.first.stock : stock;

  final int id;
  final int minQuantity;
  final int stock;
  final String name;
  final String desc;
  final ProductAttributes? properties;
  final Brand? brand;
  final List<ProductVariant>? variants;
  final List<ProductReview>? reviews;

  Map<String, dynamic> toJson() => {
    'id': id,
    'min_quantity': minQuantity,
    'stock': stock,
    'name': name,
    'desc': desc,
    'properties': properties?.toJson(),
    'brand': brand?.toJson(),
    'variants': variants?.map((e) => e.toJson()).toList(),
    'reviews': reviews?.map((e) => e.toJson()).toList(),
  };

  static String _normalizeKey(String key) {
    if (key.isEmpty) return key;
    final trimmed = key.trim();
    if (trimmed.isEmpty) return trimmed;
    return trimmed[0].toUpperCase() + trimmed.substring(1).toLowerCase();
  }
}

class ProductAttributes {
  ProductAttributes({required this.values});

  factory ProductAttributes.fromJson(Map<String, dynamic> json) {
    final values = <String, List<String>>{};
    json.forEach((key, value) {
      final normalizedKey = ProductDetail._normalizeKey(key);
      if (value is List) {
        values[normalizedKey] = List<String>.from(value);
      }
    });
    return ProductAttributes(values: values);
  }

  final Map<String, List<String>> values;

  Map<String, dynamic> toJson() => values;
}

class Brand {
  Brand({required this.name, required this.imagePath});

  factory Brand.fromJson(Map<String, dynamic> json) => Brand(
    name: json['name'] as String? ?? '',
    imagePath: json['image_path'] as String? ?? '',
  );

  final String name;
  final String imagePath;

  Map<String, dynamic> toJson() => {'name': name, 'image_path': imagePath};
}

class ProductCategory {
  ProductCategory({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.sortOrder,
    required this.name,
    required this.imagePath,
  });

  factory ProductCategory.fromJson(Map<String, dynamic> json) =>
      ProductCategory(
        id: json['id'] as int,
        createdAt: json['created_at'] as String,
        updatedAt: json['updated_at'] as String,
        sortOrder: json['sort_order'] as int,
        name: json['name'] as String,
        imagePath: json['image_path'] as String,
      );

  final int id;
  final String createdAt;
  final String updatedAt;
  final int sortOrder;
  final String name;
  final String imagePath;

  Map<String, dynamic> toJson() => {
    'id': id,
    'created_at': createdAt,
    'updated_at': updatedAt,
    'sort_order': sortOrder,
    'name': name,
    'image_path': imagePath,
  };
}

class ProductOffer {
  ProductOffer({
    required this.id,
    required this.disscountPrice,
    this.start,
    this.end,
    this.productId,
    this.createdAt,
    this.updatedAt,
  });

  factory ProductOffer.fromJson(Map<String, dynamic> json) => ProductOffer(
    id: json['id'] as int,
    disscountPrice: (json['disscount_price'] as num?)?.toDouble() ?? 0.0,
    start: json['start'] as String?,
    end: json['end'] as String?,
    productId: json['product_id'] as int?,
    createdAt: json['created_at'] as String?,
    updatedAt: json['updated_at'] as String?,
  );

  final int id;
  final double disscountPrice;
  final String? start;
  final String? end;
  final int? productId;
  final String? createdAt;
  final String? updatedAt;

  Map<String, dynamic> toJson() => {
    'id': id,
    'disscount_price': disscountPrice,
    'start': start,
    'end': end,
    'product_id': productId,
    'created_at': createdAt,
    'updated_at': updatedAt,
  };
}

class ProductReview {
  ProductReview({
    required this.id,
    required this.comment,
    required this.rate,
    this.user,
    this.createdAt,
  });

  factory ProductReview.fromJson(Map<String, dynamic> json) {
    final user = json['user'] != null && json['user'] is Map<String, dynamic>
        ? ReviewAuthor.fromJson(json['user'] as Map<String, dynamic>)
        : (json['first_name'] != null || json['last_name'] != null)
        ? ReviewAuthor(
            id: 0,
            firstName: json['first_name'] as String? ?? '',
            lastName: json['last_name'] as String? ?? '',
            email: '',
          )
        : null;

    return ProductReview(
      id: json['id'] as int,
      comment: json['comment'] as String? ?? '',
      rate: double.tryParse(json['rate']?.toString() ?? '0') ?? 0.0,
      user: user,
      createdAt: json['created_at'] as String?,
    );
  }

  final int id;
  final String comment;
  final double rate;
  final ReviewAuthor? user;
  final String? createdAt;

  Map<String, dynamic> toJson() => {
    'id': id,
    'comment': comment,
    'rate': rate,
    'user': user?.toJson(),
    'created_at': createdAt,
  };
}

class ReviewAuthor {
  ReviewAuthor({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
  });

  factory ReviewAuthor.fromJson(Map<String, dynamic> json) => ReviewAuthor(
    id: json['id'] as int,
    firstName: json['first_name'] as String? ?? '',
    lastName: json['last_name'] as String? ?? '',
    email: json['email'] as String? ?? '',
  );

  final int id;
  final String firstName;
  final String lastName;
  final String email;

  Map<String, dynamic> toJson() => {
    'id': id,
    'first_name': firstName,
    'last_name': lastName,
    'email': email,
  };
}

class ProductVariant {
  ProductVariant({
    required this.id,
    required this.price,
    required this.minQuantity,
    required this.stock,
    required this.imagePath,
    required this.imagesPath,
    this.attributes,
    this.offers,
  });

  factory ProductVariant.fromJson(Map<String, dynamic> json) => ProductVariant(
    id: json['id'] is int ? json['id'] as int : 0,
    price: json['price']?.toString() ?? '0',
    minQuantity: json['min_quantity'] is int ? json['min_quantity'] as int : 1,
    stock: json['stock'] is int ? json['stock'] as int : 0,
    imagePath: json['image_path'] as String? ?? '',
    imagesPath: List<String>.from(
      (json['images_path'] ?? const <dynamic>[]) as List<dynamic>,
    ),
    attributes: json['attributes'] is Map<String, dynamic>
        ? (json['attributes'] as Map<String, dynamic>).map(
            (k, v) => MapEntry(ProductDetail._normalizeKey(k), v.toString()),
          )
        : null,
    offers: (json['offers'] as List<dynamic>? ?? [])
        .map((e) => ProductOffer.fromJson(e as Map<String, dynamic>))
        .toList(),
  );

  final int id;
  final String price;
  final int minQuantity;
  final int stock;
  final String imagePath;
  final List<String> imagesPath;
  final Map<String, String>? attributes;
  final List<ProductOffer>? offers;

  Map<String, dynamic> toJson() => {
    'id': id,
    'price': price,
    'min_quantity': minQuantity,
    'stock': stock,
    'image_path': imagePath,
    'images_path': imagesPath,
    'attributes': attributes,
    'offers': offers?.map((e) => e.toJson()).toList(),
  };
}
