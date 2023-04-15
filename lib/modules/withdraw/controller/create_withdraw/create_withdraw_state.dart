part of 'create_withdraw_cubit.dart';

abstract class CreateWithdrawState extends Equatable {
  const CreateWithdrawState();

  @override
  List<Object> get props => [];
}

class CreateWithdrawInitial extends CreateWithdrawState {
  const CreateWithdrawInitial();
}

class CreateWithdrawLoading extends CreateWithdrawState {
  const CreateWithdrawLoading();
}

class CreateWithdrawLoaded extends CreateWithdrawState {
  final String message;

  const CreateWithdrawLoaded(this.message);

  @override
  List<Object> get props => [message];
}

class CreateWithdrawError extends CreateWithdrawState {
  final String message;
  final int statusCode;

  const CreateWithdrawError(this.message, this.statusCode);

  @override
  List<Object> get props => [message, statusCode];
}

class CreateWithdrawFormError extends CreateWithdrawState {
  final Errors errors;

  const CreateWithdrawFormError(this.errors);

  @override
  List<Object> get props => [errors];
}
