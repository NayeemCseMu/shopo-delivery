part of 'dashboard_cubit.dart';

abstract class DashboardState extends Equatable {
  const DashboardState();

  @override
  List<Object?> get props => [];
}

class DashboardInitial extends DashboardState {
  @override
  List<Object> get props => [];
}

class DashboardStateLoading extends DashboardState {}

class DashboardStateLoaded extends DashboardState {
  final DashboardModel dashboardModel;

  const DashboardStateLoaded({required this.dashboardModel});

  @override
  List<Object?> get props => [dashboardModel];
}

class DashboardStateError extends DashboardState {
  final String message;
  final int statusCode;

  const DashboardStateError(this.message, this.statusCode);

  @override
  List<Object?> get props => [message, statusCode];
}
