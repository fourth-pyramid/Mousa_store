import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mousa_store/features/orders/domain/usecases/orders_use_cases.dart';
import 'package:mousa_store/features/orders/presentation/bloc/order_details_event.dart';
import 'package:mousa_store/features/orders/presentation/bloc/order_details_state.dart';

class OrderDetailsBloc extends Bloc<OrderDetailsEvent, OrderDetailsState> {
  OrderDetailsBloc({required GetOrderDetailsUseCase getOrderDetailsUseCase})
      : _getOrderDetailsUseCase = getOrderDetailsUseCase,
        super(const OrderDetailsState()) {
    on<OrderDetailsFetchRequested>(_onOrderDetailsFetchRequested);
  }

  final GetOrderDetailsUseCase _getOrderDetailsUseCase;

  Future<void> _onOrderDetailsFetchRequested(
    OrderDetailsFetchRequested event,
    Emitter<OrderDetailsState> emit,
  ) async {
    emit(state.copyWith(status: OrderDetailsStatus.loading));
    try {
      final orderDetails = await _getOrderDetailsUseCase(event.orderId);
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

  // Compatibility helper
  Future<void> getOrderDetails(int orderId) async {
    add(OrderDetailsFetchRequested(orderId));
  }
}
