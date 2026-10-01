import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mousa_store/features/orders/data/models/order_model.dart';
import 'package:mousa_store/features/orders/domain/usecases/orders_use_cases.dart';
import 'package:mousa_store/features/orders/presentation/bloc/orders_event.dart';
import 'package:mousa_store/features/orders/presentation/bloc/orders_state.dart';

class OrdersBloc extends Bloc<OrdersEvent, OrdersState> {
  OrdersBloc({required GetOrdersUseCase getOrdersUseCase})
      : _getOrdersUseCase = getOrdersUseCase,
        super(const OrdersState()) {
    on<OrdersFetchRequested>(_onOrdersFetchRequested);
    on<OrdersSearchQueryChanged>(_onOrdersSearchQueryChanged);
  }

  final GetOrdersUseCase _getOrdersUseCase;
  List<OrderModel> _allOrders = [];

  Future<void> _onOrdersFetchRequested(
    OrdersFetchRequested event,
    Emitter<OrdersState> emit,
  ) async {
    emit(state.copyWith(status: OrdersStatus.loading));
    try {
      _allOrders = await _getOrdersUseCase();
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

  void _onOrdersSearchQueryChanged(
    OrdersSearchQueryChanged event,
    Emitter<OrdersState> emit,
  ) {
    if (event.query.isEmpty) {
      emit(state.copyWith(orders: _allOrders));
    } else {
      final filteredOrders = _allOrders
          .where(
            (order) => order.orderNumber
                .toLowerCase()
                .contains(event.query.toLowerCase()),
          )
          .toList();
      emit(state.copyWith(orders: filteredOrders));
    }
  }

  // Compatibility helpers
  Future<void> getOrders() async {
    add(const OrdersFetchRequested());
  }

  void updateSearchQuery(String query) {
    add(OrdersSearchQueryChanged(query));
  }
}
