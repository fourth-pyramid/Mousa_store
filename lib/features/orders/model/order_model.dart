class OrdersResponse {
  OrdersResponse({required this.success, required this.data});

  factory OrdersResponse.fromJson(Map<String, dynamic> json) => OrdersResponse(
    success: (json['success'] as bool?) ?? false,
    data: List<OrderModel>.from(
      (json['data'] as List<dynamic>).map((x) => OrderModel.fromJson(x as Map<String, dynamic>)),
    ),
  );

  final bool success;
  final List<OrderModel> data;
}

class OrderModel {
  OrderModel({
    required this.type,
    required this.id,
    required this.orderNumber,
    required this.createdAt,
    required this.status,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
    id: (json['id'] as num?)?.toInt() ?? 0,
    orderNumber: (json['orderNumber'] ?? json['order_number'])?.toString() ?? '',
    createdAt: DateTime.parse((json['createdAt'] ?? json['created_at']) as String),
    status: json['status']?.toString() ?? '',
    type: json['sale_type']?.toString() ?? '',
  );

  final int id;
  final String orderNumber;
  final DateTime createdAt;
  final String status;
  final String type;
}
