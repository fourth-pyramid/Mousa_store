import 'package:mousa_store/core/service/dio_helper.dart';

abstract class OrdersRemoteDataSource {
  Future<Map<String, dynamic>> getOrders();

  Future<Map<String, dynamic>> getOrderDetails(int orderId);
}

class OrdersRemoteDataSourceImpl implements OrdersRemoteDataSource {
  const OrdersRemoteDataSourceImpl();

  @override
  Future<Map<String, dynamic>> getOrders() async {
    try {
      final response = await DioHelper.getData(url: 'orders');
      return response.data as Map<String, dynamic>;
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<Map<String, dynamic>> getOrderDetails(int orderId) async {
    try {
      final response = await DioHelper.getData(
        url: 'order',
        query: {'order_id': orderId},
      );
      return response.data as Map<String, dynamic>;
    } catch (_) {
      rethrow;
    }
  }
}
