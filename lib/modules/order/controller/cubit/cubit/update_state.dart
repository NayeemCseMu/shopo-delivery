part of 'update_cubit.dart';

abstract class UpdateState extends Equatable {
  const UpdateState();

  @override
  List<Object> get props => [];
}

class UpdateInitial extends UpdateState {}

class UpdateOrderLoading extends UpdateState {
  const UpdateOrderLoading();
}

class UpdateOrderStateError extends UpdateState {
  final String message;
  final int code;
  const UpdateOrderStateError(this.message, this.code);

  @override
  List<Object> get props => [message, code];
}

class UpdateOrderStateLoaded extends UpdateState {
  final String message;
  const UpdateOrderStateLoaded({required this.message});

  @override
  List<Object> get props => [message];
}
