import 'package:mousa_store/features/orders/data/models/order_details_model.dart';
import 'package:mousa_store/features/orders/data/models/order_model.dart';

abstract class OrdersRepository {
  Future<List<OrderModel>> getOrders();

  Future<OrderDetailsData> getOrderDetails(int orderId);
}
