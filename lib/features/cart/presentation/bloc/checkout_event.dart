import 'package:freezed_annotation/freezed_annotation.dart';

part 'checkout_event.freezed.dart';

@freezed
sealed class CheckoutEvent with _$CheckoutEvent {
  const factory CheckoutEvent.submitted({
    required String userAddress,
    required String userName,
    required String userPhone,
    int? governorateId,
  }) = CheckoutSubmitted;

  const factory CheckoutEvent.shippingFeeRequested({
    int? governorateId,
  }) = ShippingFeeRequested;
}
