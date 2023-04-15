part of 'profile_cubit.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

class ProfileInitial extends ProfileState {
  const ProfileInitial();
}

class ProfileStateLoading extends ProfileState {
  const ProfileStateLoading();
}

class ProfileStateError extends ProfileState {
  final String message;
  final int code;
  const ProfileStateError({required this.message, required this.code});

  @override
  List<Object> get props => [message, code];
}

class ProfileStateLoaded extends ProfileState {
  final DeliveryManProfile deliveryManProfile;

  const ProfileStateLoaded({required this.deliveryManProfile});

  @override
  List<Object> get props => [deliveryManProfile];
}
