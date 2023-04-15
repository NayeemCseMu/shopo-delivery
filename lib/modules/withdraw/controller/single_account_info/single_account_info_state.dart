part of 'single_account_info_cubit.dart';

abstract class SingleAccountInfoState extends Equatable {
  const SingleAccountInfoState();
  @override
  List<Object> get props => [];
}

class SingleAccountInfoInitial extends SingleAccountInfoState {
}
class SingleAccountInfoLoading extends SingleAccountInfoState {}

class SingleAccountInfoError extends SingleAccountInfoState {
  final String message;
  final int statusCode;

  const SingleAccountInfoError(this.message, this.statusCode);

  @override
  List<Object> get props => [message, statusCode];
}

class SingleAccountInfoLoaded extends SingleAccountInfoState {
  final AccountInfoModel accountInfo;

  const SingleAccountInfoLoaded(this.accountInfo);

  @override
  List<Object> get props => [accountInfo];
}
