part of 'profile_edit_cubit.dart';

abstract class ProfileEditState extends Equatable {
  const ProfileEditState();

  @override
  List<Object> get props => [];
}

class ProfileEditInitial extends ProfileEditState {
  const ProfileEditInitial();
}

class ProfileEditStateLoading extends ProfileEditState {
  const ProfileEditStateLoading();
}

class ProfileEditStateError extends ProfileEditState {
  final String message;
  final int code;
  const ProfileEditStateError({required this.message, required this.code});

  @override
  List<Object> get props => [message, code];
}

class ProfileEditFormValidState extends ProfileEditState {
  final Errors errors;

  const ProfileEditFormValidState(this.errors);

  @override
  List<Object> get props => [errors];
}


class ProfileEditStateLoaded extends ProfileEditState {
  final String message;

  const ProfileEditStateLoaded(this.message);

  @override
  List<Object> get props => [message];
}