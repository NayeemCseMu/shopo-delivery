import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../authentication/models/auth_error_model.dart';
import '/core/error/failure.dart';
import '../../../authentication/controller/login/login_bloc.dart';
import '../../repository/withdraw_repository.dart';
import 'create_withdraw_state_model.dart';

part 'create_withdraw_state.dart';

class CreateWithdrawCubit extends Cubit<CreateWithdrawStateModel> {
  final WithdrawRepository _withdrawRepository;
  final LoginBloc _loginBloc;

  CreateWithdrawCubit(
      {required WithdrawRepository withdrawRepository,
      required LoginBloc loginBloc})
      : _withdrawRepository = withdrawRepository,
        _loginBloc = loginBloc,
        super(const CreateWithdrawStateModel());

  void changeMethodId(String id) {
    emit(state.copyWith(
      methodId: id,
      withdrawState: const CreateWithdrawInitial(),
    ));
  }

  void changeAmount(String amount) {
    emit(state.copyWith(
      withdrawAmount: amount,
      withdrawState: const CreateWithdrawInitial(),
    ));
  }

  void changeBankInfo(String accountInfo) {
    emit(state.copyWith(
      accountInfo: accountInfo,
      withdrawState: const CreateWithdrawInitial(),
    ));
  }

  Future<void> createWithdrawMethod() async {
    emit(state.copyWith(withdrawState: const CreateWithdrawLoading()));
    final body = state;
    // final result = await _withdrawRepository.createNewWithdrawRequest(
    //     body, _loginBloc.userInfo!.accessToken);

    final result =
        await _withdrawRepository.createWithdrawMethod(body, _loginBloc.userInfo!.accessToken);
    result.fold((failure) {
      if (failure is InvalidAuthData) {
        final errors = CreateWithdrawFormError(failure.errors);
        emit(state.copyWith(withdrawState: errors));
      } else {
        final errors = CreateWithdrawError(failure.message, failure.statusCode);
        emit(state.copyWith(withdrawState: errors));
        emit(state.clear());
      }
    }, (success) {
      emit(state.copyWith(withdrawState: CreateWithdrawLoaded(success)));
      emit(state.clear());
    });
  }

  Future<void> removeData() async {
    emit(state.clear());
  }
}
