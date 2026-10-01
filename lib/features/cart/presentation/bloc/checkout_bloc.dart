import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mousa_store/core/enums/request_status.dart';
import 'package:mousa_store/features/cart/domain/usecases/checkout_use_cases.dart';
import 'package:mousa_store/features/cart/presentation/bloc/checkout_event.dart';
import 'package:mousa_store/features/cart/presentation/bloc/checkout_state.dart';

export 'checkout_event.dart';
export 'checkout_state.dart';

class CheckoutBloc extends Bloc<CheckoutEvent, CheckoutState> {
  CheckoutBloc({
    required this.checkoutUseCase,
    required this.getShippingFeeUseCase,
  }) : super(const CheckoutState()) {
    on<CheckoutSubmitted>(_onCheckoutSubmitted);
    on<ShippingFeeRequested>(_onShippingFeeRequested);
  }

  final CheckoutUseCase checkoutUseCase;
  final GetShippingFeeUseCase getShippingFeeUseCase;

  Future<void> checkout({
    required String userAddress,
    required String userName,
    required String userPhone,
    int? governorateId,
  }) async {
    add(
      CheckoutSubmitted(
        userAddress: userAddress,
        userName: userName,
        userPhone: userPhone,
        governorateId: governorateId,
      ),
    );
  }

  Future<void> getShippingFee({int? governorateId}) async {
    add(ShippingFeeRequested(governorateId: governorateId));
  }

  Future<void> _onCheckoutSubmitted(
    CheckoutSubmitted event,
    Emitter<CheckoutState> emit,
  ) async {
    emit(state.copyWith(checkoutStatus: RequestStatus.loading));
    try {
      final message = await checkoutUseCase(
        userAddress: event.userAddress,
        userName: event.userName,
        userPhone: event.userPhone,
        governorateId: event.governorateId,
      );
      emit(
        state.copyWith(checkoutStatus: RequestStatus.success, message: message),
      );
    } on Object catch (e) {
      emit(
        state.copyWith(
          checkoutStatus: RequestStatus.failure,
          errorMessage: e.toString().replaceAll('Exception: ', ''),
        ),
      );
    }
  }

  Future<void> _onShippingFeeRequested(
    ShippingFeeRequested event,
    Emitter<CheckoutState> emit,
  ) async {
    emit(state.copyWith(shippingFeeStatus: RequestStatus.loading));
    try {
      final result = await getShippingFeeUseCase(
        governorateId: event.governorateId,
      );
      emit(
        state.copyWith(
          shippingFeeStatus: RequestStatus.success,
          shippingFee: result,
        ),
      );
    } on Object catch (e) {
      emit(
        state.copyWith(
          shippingFeeStatus: RequestStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }
}
