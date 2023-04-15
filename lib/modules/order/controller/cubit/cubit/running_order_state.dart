part of 'running_order_cubit.dart';

abstract class RunningOrderState extends Equatable {
  const RunningOrderState();

  @override
  List<Object> get props => [];
}

class RunningOrderInitial extends RunningOrderState {}

class RunningOrderLoading extends RunningOrderState {
  const RunningOrderLoading();
}

class RunningOrderStateError extends RunningOrderState {
  final String message;
  final int code;
  const RunningOrderStateError(this.message, this.code);

  @override
  List<Object> get props => [message, code];
}

class RunningOrderStateLoaded extends RunningOrderState {
  final List<OrderModel> orders;
  const RunningOrderStateLoaded({required this.orders});

  @override
  List<Object> get props => [orders];
}
