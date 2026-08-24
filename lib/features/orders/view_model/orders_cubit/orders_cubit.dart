import 'package:mousa_store/core/utils/safe_cubit.dart';
import 'package:mousa_store/features/orders/model/order_model.dart';
import 'package:mousa_store/features/orders/repos/orders_repo.dart';
import 'package:mousa_store/features/orders/view_model/orders_cubit/orders_state.dart';

class OrdersCubit extends SafeCubit<OrdersState> {
  OrdersCubit(this._ordersRepo) : super(const OrdersState());
  final OrdersRepo _ordersRepo;

  List<OrderModel> _allOrders = [];

  Future<void> getOrders() async {
    emit(state.copyWith(status: OrdersStatus.loading));
    try {
      _allOrders = await _ordersRepo.getOrders();
      emit(state.copyWith(status: OrdersStatus.success, orders: _allOrders));
    } on Object catch (e) {
      emit(
        state.copyWith(
          status: OrdersStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  void updateSearchQuery(String query) {
    if (query.isEmpty) {
      emit(state.copyWith(orders: _allOrders));
    } else {
      final filteredOrders = _allOrders
          .where(
            (order) =>
                order.orderNumber.toLowerCase().contains(query.toLowerCase()),
          )
          .toList();
      emit(state.copyWith(orders: filteredOrders));
    }
  }
}
