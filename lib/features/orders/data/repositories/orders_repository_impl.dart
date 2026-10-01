import 'package:mousa_store/features/orders/data/datasources/orders_remote_data_source.dart';
import 'package:mousa_store/features/orders/data/models/order_details_model.dart';
import 'package:mousa_store/features/orders/data/models/order_model.dart';
import 'package:mousa_store/features/orders/domain/repositories/orders_repository.dart';

class OrdersRepositoryImpl implements OrdersRepository {
  const OrdersRepositoryImpl(this._remoteDataSource);

  final OrdersRemoteDataSource _remoteDataSource;

  @override
  Future<List<OrderModel>> getOrders() async {
    final response = await _remoteDataSource.getOrders();
    final ordersResponse = OrdersResponse.fromJson(response);
    return ordersResponse.data;
  }

  @override
  Future<OrderDetailsData> getOrderDetails(int orderId) async {
    final response = await _remoteDataSource.getOrderDetails(orderId);
    final orderDetailsResponse = OrderDetailsResponse.fromJson(response);
    return orderDetailsResponse.data;
  }
}
