part of 'complete_order_cubit.dart';

abstract class CompleteOrderState extends Equatable {
  const CompleteOrderState();

  @override
  List<Object> get props => [];
}

class CompleteOrderInitial extends CompleteOrderState {}
class CompleteOrderLoading extends CompleteOrderState {
  const CompleteOrderLoading();
}

class CompleteOrderStateError extends CompleteOrderState {
  final String message;
  final int code;
  const CompleteOrderStateError(this.message, this.code);

  @override
  List<Object> get props => [message, code];
}

class CompleteOrderStateLoaded extends CompleteOrderState {
  final List<OrderModel> orders;
  const CompleteOrderStateLoaded({required this.orders});

  @override
  List<Object> get props => [orders];
}
