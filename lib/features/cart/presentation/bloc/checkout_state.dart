import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mousa_store/core/enums/request_status.dart';

part 'checkout_state.freezed.dart';

@freezed
abstract class CheckoutState with _$CheckoutState {
  const factory CheckoutState({
    @Default(RequestStatus.initial) RequestStatus checkoutStatus,
    @Default(RequestStatus.initial) RequestStatus shippingFeeStatus,
    String? message,
    String? shippingFee,
    String? errorMessage,
  }) = _CheckoutState;
}
