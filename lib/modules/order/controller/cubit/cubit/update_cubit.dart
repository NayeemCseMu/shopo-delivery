import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../authentication/controller/login/login_bloc.dart';
import '../../../../dashboard/model/order_model.dart';
import '../../repository/order_repository.dart';

part 'update_state.dart';

class UpdateCubit extends Cubit<UpdateState> {
  final OrderRepository _orderRepository;
  final LoginBloc _loginBloc;

  UpdateCubit(
      {required OrderRepository orderRepository, required LoginBloc loginBloc})
      : _orderRepository = orderRepository,
        _loginBloc = loginBloc,
        super(UpdateInitial());

  Future<void> updateRequestStatus(String id, Map<String, String> map) async {
    emit(const UpdateOrderLoading());
    final result = await _orderRepository.orderRequestUpdate(
        id, map, _loginBloc.userInfo!.accessToken);
    result.fold(
      (failure) {
        emit(UpdateOrderStateError(failure.message, failure.statusCode));
      },
      (data) {
        emit(UpdateOrderStateLoaded(message: data));
      },
    );
  }

  Future<void> updateRunningStatus(String id, Map<String, String> map) async {
    emit(const UpdateOrderLoading());
    final result = await _orderRepository.orderRunningUpdate(
        id, map, _loginBloc.userInfo!.accessToken);
    result.fold(
      (failure) {
        emit(UpdateOrderStateError(failure.message, failure.statusCode));
      },
      (data) {
        emit(UpdateOrderStateLoaded(message: data));
      },
    );
  }
}
