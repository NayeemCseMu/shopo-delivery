import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shopo_delivery/modules/order/model/order_details_model.dart';

import '../../../../authentication/controller/login/login_bloc.dart';
import '../../repository/order_repository.dart';

part 'order_details_state.dart';

class OrderDetailsCubit extends Cubit<OrderDetailsState> {
  final OrderRepository _orderRepository;
  final LoginBloc _loginBloc;

  OrderDetailsCubit(
      {required OrderRepository orderRepository, required LoginBloc loginBloc})
      : _orderRepository = orderRepository,
        _loginBloc = loginBloc,
        super(OrderDetailsInitial());

  Future<void> getOrderDetails(String id) async {
    emit(const OrdeDetailsLoading());
    final result = await _orderRepository.orderDetails(
        id, _loginBloc.userInfo!.accessToken);
    result.fold(
      (failure) {
        emit(OrderDetailsStateError(failure.message, failure.statusCode));
      },
      (data) {
        emit(OrderDetailsStateLoaded(orders: data));
      },
    );
  }

  
}
