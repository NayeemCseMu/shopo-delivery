import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopo_delivery/modules/withdraw/model/account_info_model.dart';
import '../../model/withdraw_model.dart';
import '../../../authentication/controller/login/login_bloc.dart';
import '../../model/withdraw_list_model.dart';
import '../../repository/withdraw_repository.dart';

part 'account_info_state.dart';

class AccountInfoCubit extends Cubit<AccountInfoState> {
  final WithdrawRepository _withdrawRepository;
  final LoginBloc _loginBloc;
  late WithdrawListModel withdrawListModel;
  List<WithdrawModel> withdrawList = [];

  AccountInfoCubit(
      {required WithdrawRepository withdrawRepository,
      required LoginBloc loginBloc})
      : _withdrawRepository = withdrawRepository,
        _loginBloc = loginBloc,
        super(AccountInfoInitial());

  Future<void> getAllWithdrawList() async {
    emit(AccountInfoLoading());
    // final account = await _withdrawRepository
    //     .getAllMethodList(_loginBloc.userInfo!.accessToken);

    final account = await _withdrawRepository
        .getAllWithdrawList(_loginBloc.userInfo!.accessToken);
    account.fold((failure) {
      emit(AccountInfoError(failure.message, failure.statusCode));
    }, (methodList) {
      withdrawList = methodList;
      emit(AllWithdrawListLoaded(methodList));
    });
  }
}
