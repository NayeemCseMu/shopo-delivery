import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../authentication/controller/login/login_bloc.dart';
import '../../../../dashboard/model/order_model.dart';
import '../../repository/order_repository.dart';

part 'running_order_state.dart';

class RunningOrderCubit extends Cubit<RunningOrderState> {
  final OrderRepository _orderRepository;
  final LoginBloc _loginBloc;

  RunningOrderCubit(
      {required OrderRepository orderRepository, required LoginBloc loginBloc})
      : _orderRepository = orderRepository,
        _loginBloc = loginBloc,
        super(RunningOrderInitial()) {
    getRunningOrderList();
  }

  Future<void> getRunningOrderList() async {
    emit(const RunningOrderLoading());
    final result = await _orderRepository
        .getRunningOrders(_loginBloc.userInfo!.accessToken);
    result.fold(
      (failure) {
        emit(RunningOrderStateError(failure.message, failure.statusCode));
      },
      (data) {
        emit(RunningOrderStateLoaded(orders: data));
      },
    );
  }
}
