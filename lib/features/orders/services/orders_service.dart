import 'package:mousa_store/core/service/dio_helper.dart';

class OrdersService {
  Future<Map<String, dynamic>> getOrders() async {
    final response = await DioHelper.getData(url: 'orders');
    return response.data as Map<String, dynamic>;
  }

  Future<Map<String, dynamic>> getOrderDetails(int orderId) async {
    final response = await DioHelper.getData(
      url: 'order',
      query: {'order_id': orderId},
    );
    return response.data as Map<String, dynamic>;
  }
}
