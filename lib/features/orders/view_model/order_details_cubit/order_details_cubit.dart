import 'package:mousa_store/core/utils/safe_cubit.dart';
import 'package:mousa_store/features/orders/repos/orders_repo.dart';
import 'package:mousa_store/features/orders/view_model/order_details_cubit/order_details_state.dart';

class OrderDetailsCubit extends SafeCubit<OrderDetailsState> {
  OrderDetailsCubit(this._ordersRepo) : super(const OrderDetailsState());

  final OrdersRepo _ordersRepo;

  Future<void> getOrderDetails(int orderId) async {
    emit(state.copyWith(status: OrderDetailsStatus.loading));
    try {
      final orderDetails = await _ordersRepo.getOrderDetails(orderId);
      emit(
        state.copyWith(
          status: OrderDetailsStatus.success,
          orderDetails: orderDetails,
        ),
      );
    } on Object catch (e) {
      emit(
        state.copyWith(
          status: OrderDetailsStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }
}
