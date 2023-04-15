import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../repository/profile_repository.dart';
import '../../model/profile_model.dart';

import '../../../authentication/controller/login/login_bloc.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final ProfileRepository _profileRepository;
  final LoginBloc _loginBloc;

  ProfileCubit(
      {required ProfileRepository profileRepository,
      required LoginBloc loginBloc})
      : _profileRepository = profileRepository,
        _loginBloc = loginBloc,
        super(const ProfileInitial()) {
    getProfileInfo();
  }

  Future<void> getProfileInfo() async {
    emit(const ProfileStateLoading());
    final result = await _profileRepository
        .fetchProfileInfo(_loginBloc.userInfo!.accessToken);

    result.fold(
      (failure) {
        emit(ProfileStateError(
            message: failure.message, code: failure.statusCode));
      },
      (data) {
        emit(ProfileStateLoaded(deliveryManProfile: data));
      },
    );
  }

  
}
