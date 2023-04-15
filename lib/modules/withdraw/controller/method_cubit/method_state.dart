part of 'method_cubit.dart';

abstract class MethodState extends Equatable {
  const MethodState();

  @override
  List<Object> get props => [];
}

class MethodInitial extends MethodState {}

class MethodLoading extends MethodState {}

class MethodError extends MethodState {
  final String message;
  final int statusCode;

  const MethodError(this.message, this.statusCode);

  @override
  List<Object> get props => [message, statusCode];
}

class MethodLoaded extends MethodState {
  final List<MethodModel> methods;

  const MethodLoaded(this.methods);

  @override
  List<Object> get props => [methods];
}
