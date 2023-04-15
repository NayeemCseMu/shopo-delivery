import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../authentication/controller/login/login_bloc.dart';
import '../../model/account_info_model.dart';
import '../../repository/withdraw_repository.dart';

part 'single_account_info_state.dart';

class SingleAccountInfoCubit extends Cubit<SingleAccountInfoState> {
  final WithdrawRepository _withdrawRepository;
  final LoginBloc _loginBloc;

  SingleAccountInfoCubit(
      {required WithdrawRepository withdrawRepository,
      required LoginBloc loginBloc})
      : _withdrawRepository = withdrawRepository,
        _loginBloc = loginBloc,
        super(SingleAccountInfoInitial());

  Future<void> getAccountInformation(String id) async {
    emit(SingleAccountInfoLoading());
    // final account = await _withdrawRepository.getAccountInformation(
    //     id, _loginBloc.userInfo!.accessToken);
    //
    final account =
        await _withdrawRepository.getAccountInformation(id, _loginBloc.userInfo!.accessToken);
    account.fold((failure) {
      emit(SingleAccountInfoError(failure.message, failure.statusCode));
    }, (accountInfo) {
      emit(SingleAccountInfoLoaded(accountInfo));
    });
  }
}
