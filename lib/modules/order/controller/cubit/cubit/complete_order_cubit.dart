import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../authentication/controller/login/login_bloc.dart';
import '../../../../dashboard/model/order_model.dart';
import '../../repository/order_repository.dart';

part 'complete_order_state.dart';

class CompleteOrderCubit extends Cubit<CompleteOrderState> {
  final OrderRepository _orderRepository;
  final LoginBloc _loginBloc;

  CompleteOrderCubit(
      {required OrderRepository orderRepository, required LoginBloc loginBloc})
      : _orderRepository = orderRepository,
        _loginBloc = loginBloc,
        super(CompleteOrderInitial()) {
    getCompleteOrderList();
  }

  Future<void> getCompleteOrderList() async {
    emit(const CompleteOrderLoading());
    final result = await _orderRepository
        .getCompleteOrders(_loginBloc.userInfo!.accessToken);
    result.fold(
      (failure) {
        emit(CompleteOrderStateError(failure.message, failure.statusCode));
      },
      (data) {
        emit(CompleteOrderStateLoaded(orders: data));
      },
    );
  }
}
