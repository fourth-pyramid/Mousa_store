class OrderDetailsResponse {
  OrderDetailsResponse({required this.success, required this.data});

  factory OrderDetailsResponse.fromJson(Map<String, dynamic> json) =>
      OrderDetailsResponse(
        success: (json['success'] as bool?) ?? false,
        data: OrderDetailsData.fromJson(json['data'] as Map<String, dynamic>),
      );
  final bool success;
  final OrderDetailsData data;
}

class OrderDetailsData {
  OrderDetailsData({required this.order, required this.product});

  factory OrderDetailsData.fromJson(Map<String, dynamic> json) =>
      OrderDetailsData(
        order: OrderDetail.fromJson(json['order'] as Map<String, dynamic>),
        product: (json['product'] as List<dynamic>)
            .map((item) => OrderProduct.fromJson(item as Map<String, dynamic>))
            .toList(),
      );
  final OrderDetail order;
  final List<OrderProduct> product;
}

class OrderDetail {
  OrderDetail({
    required this.shipping,
    required this.orderNumber,
    required this.userName,
    required this.userPhone,
    required this.userAddress,
    required this.status,
    required this.totalPrice,
    required this.createdAt,
  });

  factory OrderDetail.fromJson(Map<String, dynamic> json) => OrderDetail(
    orderNumber: json['order_number']?.toString() ?? '',
    userName: json['user_name']?.toString() ?? '',
    userPhone: json['user_phone']?.toString() ?? '',
    userAddress: json['user_address']?.toString() ?? '',
    status: json['status']?.toString() ?? '',
    totalPrice: json['total_price']?.toString() ?? '',
    createdAt: DateTime.parse(json['created_at'] as String),
    shipping: json['shipping']?.toString() ?? '',
  );
  final String orderNumber;
  final String userName;
  final String userPhone;
  final String userAddress;
  final String status;
  final String totalPrice;
  final DateTime createdAt;
  final String shipping;
}

class OrderProduct {
  OrderProduct({
    required this.productName,
    required this.quantity,
    required this.price,
    required this.total,
    required this.image,
    this.attributes,
  });

  factory OrderProduct.fromJson(Map<String, dynamic> json) {
    Map<String, dynamic>? attributes;
    if (json['attributes'] is Map) {
      final rawMap = Map<dynamic, dynamic>.from(json['attributes'] as Map);
      attributes = Map<String, dynamic>.fromEntries(
        rawMap.entries
            .where(
              (entry) =>
                  entry.key.toString().trim().isNotEmpty && entry.value != null,
            )
            .map((e) => MapEntry(e.key.toString(), e.value)),
      );

      if (attributes.isEmpty) {
        attributes = null;
      }
    }

    return OrderProduct(
      productName: json['product_name']?.toString() ?? '',
      quantity: (json['quantity'] as num?)?.toInt() ?? 0,
      price: json['price']?.toString() ?? '',
      total: (json['total'] as num?)?.toDouble() ?? 0.0,
      image: json['image']?.toString() ?? '',
      attributes: attributes,
    );
  }

  final String productName;
  final int quantity;
  final String price;
  final double total;
  final String image;
  final Map<String, dynamic>? attributes;
}
