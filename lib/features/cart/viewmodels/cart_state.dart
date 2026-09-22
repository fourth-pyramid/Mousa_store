part of 'cart_cubit.dart';

final class CartState extends Equatable {
  const CartState({
    this.status = RequestStatus.initial,
    this.actionStatus = RequestStatus.initial,
    this.cart,
    this.errorMessage,
    this.successType,
  });

  final RequestStatus status;
  final RequestStatus actionStatus;
  final Cart? cart;
  final String? errorMessage;
  final CartSuccessType? successType; // To track what action succeeded

  CartState copyWith({
    RequestStatus? status,
    RequestStatus? actionStatus,
    Cart? cart,
    String? errorMessage,
    CartSuccessType? successType,
  }) => CartState(
    status: status ?? this.status,
    actionStatus: actionStatus ?? this.actionStatus,
    cart: cart ?? this.cart,
    errorMessage: errorMessage ?? this.errorMessage,
    successType: successType ?? this.successType,
  );

  /// Helper getter for badge count in navigation bar
  int get cartCount => cart?.items.length ?? 0;

  @override
  List<Object?> get props => [
    status,
    actionStatus,
    cart,
    errorMessage,
    successType,
  ];
}

enum CartSuccessType { added, removed, updated }
