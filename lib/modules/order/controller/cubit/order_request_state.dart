part of 'order_request_cubit.dart';

abstract class OrderRequestState extends Equatable {
  const OrderRequestState();

  @override
  List<Object> get props => [];
}

class OrderRequestInitial extends OrderRequestState {}

class OrderRequestLoading extends OrderRequestState {
  const OrderRequestLoading();
}

class OrderRequestStateError extends OrderRequestState {
  final String message;
  final int code;
  const OrderRequestStateError(this.message, this.code);

  @override
  List<Object> get props => [message, code];
}

class OrderRequestStateLoaded extends OrderRequestState {
  final List<OrderModel> orders;
  const OrderRequestStateLoaded({required this.orders});

  @override
  List<Object> get props => [orders];
}
