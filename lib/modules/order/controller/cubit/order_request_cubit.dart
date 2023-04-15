import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shopo_delivery/modules/order/controller/repository/order_repository.dart';

import '../../../authentication/controller/login/login_bloc.dart';
import '../../../dashboard/model/order_model.dart';

part 'order_request_state.dart';

class OrderRequestCubit extends Cubit<OrderRequestState> {
  final OrderRepository _orderRepository;
  final LoginBloc _loginBloc;

  OrderRequestCubit(
      {required OrderRepository orderRepository, required LoginBloc loginBloc})
      : _orderRepository = orderRepository,
        _loginBloc = loginBloc,
        super(OrderRequestInitial()) {
    getRequestOrderList();
  }

  Future<void> getRequestOrderList() async {
    emit(const OrderRequestLoading());
    final result = await _orderRepository
        .getRequestOrders(_loginBloc.userInfo!.accessToken);
    result.fold(
      (failure) {
        emit(OrderRequestStateError(failure.message, failure.statusCode));
      },
      (data) {
        emit(OrderRequestStateLoaded(orders: data));
      },
    );
  }
}
