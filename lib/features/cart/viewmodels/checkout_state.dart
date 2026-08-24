part of 'checkout_cubit.dart';

final class CheckoutState extends Equatable {
  const CheckoutState({
    this.checkoutStatus = RequestStatus.initial,
    this.shippingFeeStatus = RequestStatus.initial,
    this.message,
    this.shippingFee,
    this.errorMessage,
  });

  final RequestStatus checkoutStatus;
  final RequestStatus shippingFeeStatus;
  final String? message;
  final String? shippingFee;
  final String? errorMessage;

  CheckoutState copyWith({
    RequestStatus? checkoutStatus,
    RequestStatus? shippingFeeStatus,
    String? message,
    String? shippingFee,
    String? errorMessage,
  }) => CheckoutState(
    checkoutStatus: checkoutStatus ?? this.checkoutStatus,
    shippingFeeStatus: shippingFeeStatus ?? this.shippingFeeStatus,
    message: message ?? this.message,
    shippingFee: shippingFee ?? this.shippingFee,
    errorMessage: errorMessage ?? this.errorMessage,
  );

  @override
  List<Object?> get props => [
    checkoutStatus,
    shippingFeeStatus,
    message,
    shippingFee,
    errorMessage,
  ];
}
