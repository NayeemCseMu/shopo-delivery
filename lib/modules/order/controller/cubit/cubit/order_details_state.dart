part of 'order_details_cubit.dart';

abstract class OrderDetailsState extends Equatable {
  const OrderDetailsState();

  @override
  List<Object> get props => [];
}

class OrderDetailsInitial extends OrderDetailsState {}

class OrdeDetailsLoading extends OrderDetailsState {
  const OrdeDetailsLoading();
}

class OrderDetailsStateError extends OrderDetailsState {
  final String message;
  final int code;
  const OrderDetailsStateError(this.message, this.code);

  @override
  List<Object> get props => [message, code];
}

class OrderRequestState extends OrderDetailsState {
  final String message;
  const OrderRequestState(this.message);

  @override
  List<Object> get props => [message];
}

class OrderDetailsStateLoaded extends OrderDetailsState {
  final OrderDetailsModel orders;
  const OrderDetailsStateLoaded({required this.orders});

  @override
  List<Object> get props => [orders];
}
