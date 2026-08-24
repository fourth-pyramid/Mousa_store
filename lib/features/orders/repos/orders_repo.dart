import 'package:mousa_store/features/orders/model/order_details_model.dart';
import 'package:mousa_store/features/orders/model/order_model.dart';
import 'package:mousa_store/features/orders/services/orders_service.dart';

class OrdersRepo {
  OrdersRepo(this._ordersService);
  final OrdersService _ordersService;

  Future<List<OrderModel>> getOrders() async {
    final response = await _ordersService.getOrders();
    final ordersResponse = OrdersResponse.fromJson(response);
    return ordersResponse.data;
  }

  Future<OrderDetailsData> getOrderDetails(int orderId) async {
    final response = await _ordersService.getOrderDetails(orderId);
    final orderDetailsResponse = OrderDetailsResponse.fromJson(response);
    return orderDetailsResponse.data;
  }
}
