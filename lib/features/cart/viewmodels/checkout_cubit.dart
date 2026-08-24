import 'package:equatable/equatable.dart';
import 'package:mousa_store/core/enums/request_status.dart';
import 'package:mousa_store/core/utils/safe_cubit.dart';
import 'package:mousa_store/features/cart/repositories/checkout_repo.dart';

part 'checkout_state.dart';

class CheckoutCubit extends SafeCubit<CheckoutState> {
  CheckoutCubit(this.checkoutRepo) : super(const CheckoutState());

  final CheckoutRepo checkoutRepo;

  Future<void> checkout({
    required String userAddress,
    required String userName,
    required String userPhone,
    int? governorateId,
  }) async {
    emit(state.copyWith(checkoutStatus: RequestStatus.loading));
    try {
      final message = await checkoutRepo.checkout(
        userAddress: userAddress,
        userName: userName,
        userPhone: userPhone,
        governorateId: governorateId,
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

  Future<void> getShippingFee({int? governorateId}) async {
    emit(state.copyWith(shippingFeeStatus: RequestStatus.loading));
    try {
      final result = await checkoutRepo.getShippingFee(
        governorateId: governorateId,
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
