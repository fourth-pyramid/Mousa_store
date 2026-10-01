import 'package:mousa_store/features/orders/data/models/order_details_model.dart';
import 'package:mousa_store/features/orders/data/models/order_model.dart';
import 'package:mousa_store/features/orders/domain/repositories/orders_repository.dart';

class GetOrdersUseCase {
  const GetOrdersUseCase(this._repository);

  final OrdersRepository _repository;

  Future<List<OrderModel>> call() => _repository.getOrders();
}

class GetOrderDetailsUseCase {
  const GetOrderDetailsUseCase(this._repository);

  final OrdersRepository _repository;

  Future<OrderDetailsData> call(int orderId) =>
      _repository.getOrderDetails(orderId);
}
