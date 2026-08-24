enum NotificationType {
  orderConfirmed,
  specialOffer,
  orderShipped,
  reward,
  paymentSuccess,
  limitedStock,
  // API Types
  lowStock,
  broadcast,
  cartOffer,
  orderStatus,
  lowStockFavorite,
  favoriteOffer,
}

class NotificationModel {
  const NotificationModel({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.time,
    required this.type,
    this.data,
    this.readAt,
    this.isHighlighted = false,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    NotificationType getNotificationType(String? type) {
      switch (type) {
        case 'low_stock':
          return NotificationType.lowStock;
        case 'low_stock_favorite':
          return NotificationType.lowStockFavorite;
        case 'broadcast':
          return NotificationType.broadcast;
        case 'cart_offer':
          return NotificationType.cartOffer;
        case 'favorite_offer':
          return NotificationType.favoriteOffer;
        case 'offer':
          return NotificationType.specialOffer;
        case 'order_status':
          return NotificationType.orderStatus;
        default:
          return NotificationType.broadcast;
      }
    }

    // Handle nested 'data' field which might come as a JSON string or Map
    Map<String, dynamic>? extraData;
    if (json['data'] != null) {
      if (json['data'] is Map) {
        extraData = Map<String, dynamic>.from(json['data'] as Map);
      }
    }

    return NotificationModel(
      id: (json['id'] as num?)?.toInt() ?? 0,
      title: json['title'] as String? ?? '',
      subtitle: json['body'] as String? ?? '',
      time: json['created_at'] != null
          ? (DateTime.tryParse(json['created_at'].toString()) ?? DateTime.now())
          : DateTime.now(),
      type: getNotificationType(json['type'] as String?),
      data: extraData,
      readAt: json['read_at'] != null ? DateTime.tryParse(json['read_at'].toString()) : null,
    ); // ponytail: safe field extraction
  }

  final int id;
  final String title;
  final String subtitle;
  final DateTime time;
  final NotificationType type;
  final Map<String, dynamic>? data;
  final DateTime? readAt;
  final bool isHighlighted;

  bool get isRead => readAt != null;
}
