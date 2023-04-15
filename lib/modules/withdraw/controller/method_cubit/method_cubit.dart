import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../authentication/controller/login/login_bloc.dart';
import '../../model/method_model.dart';
import '../../repository/withdraw_repository.dart';

part 'method_state.dart';

class MethodCubit extends Cubit<MethodState> {
  final WithdrawRepository _withdrawRepository;
  final LoginBloc _loginBloc;
  List<MethodModel> methods = [];

  MethodCubit(
      {required WithdrawRepository withdrawRepository,
      required LoginBloc loginBloc})
      : _withdrawRepository = withdrawRepository,
        _loginBloc = loginBloc,
        super(MethodInitial()) {
    getAllMethodList();
  }

  Future<void> getAllMethodList() async {
    emit(MethodLoading());
    // final account = await _withdrawRepository
    //     .getAllMethodList(_loginBloc.userInfo!.accessToken);

    final account = await _withdrawRepository
        .getAllMethodList(_loginBloc.userInfo!.accessToken);
    account.fold((failure) {
      emit(MethodError(failure.message, failure.statusCode));
    }, (methodList) {
      methods = methodList;
      emit(MethodLoaded(methodList));
    });
  }
}
