import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shopo_delivery/modules/profile/model/profile_model.dart';

import '../../../../../core/error/failure.dart';
import '../../../../authentication/controller/login/login_bloc.dart';
import '../../../../authentication/models/auth_error_model.dart';
import '../../repository/profile_repository.dart';

part 'profile_edit_state.dart';

class ProfileEditCubit extends Cubit<DeliveryMan> {
  final LoginBloc _loginBloc;
  final ProfileRepository _profileRepository;
  ProfileEditCubit({
    required LoginBloc loginBloc,
    required ProfileRepository profileRepository,
  })  : _loginBloc = loginBloc,
        _profileRepository = profileRepository,
        super(const DeliveryMan());

  Future<void> submitForm() async {
    //if (!profileFormKey.currentState!.validate()) return;

    emit(state.copyWith(state: const ProfileEditStateLoading()));

    final result = await _profileRepository.profileUpdate(
        state, _loginBloc.userInfo!.accessToken);

    result.fold(
      (failure) {
        if (failure is InvalidAuthData) {
          final errorState = ProfileEditFormValidState(failure.errors);
          emit(state.copyWith(state: errorState));
        } else {
          emit(state.copyWith(
              state: ProfileEditStateError(
                  message: failure.message, code: failure.statusCode)));
        }
      },
      (successData) {
        emit(state.copyWith(state: ProfileEditStateLoaded(successData)));
      },
    );
  }

  void changeImage(String value) {
    emit(
      state.copyWith(
        manImage: value,
        state: const ProfileEditInitial(),
      ),
    );
  }

  void changeFirstName(String value) {
    emit(
      state.copyWith(
        fname: value,
        state: const ProfileEditInitial(),
      ),
    );
  }

  void changeLastName(String value) {
    emit(
      state.copyWith(
        lname: value,
        state: const ProfileEditInitial(),
      ),
    );
  }

  void changeEmail(String value) {
    emit(
      state.copyWith(
        email: value,
        state: const ProfileEditInitial(),
      ),
    );
  }

  void changePhone(String value) {
    emit(
      state.copyWith(
        phone: value,
        state: const ProfileEditInitial(),
      ),
    );
  }

  void changeManType(String value) {
    emit(
      state.copyWith(
        mayType: value,
        state: const ProfileEditInitial(),
      ),
    );
  }

  void changeIdnType(String value) {
    emit(
      state.copyWith(
        idnType: value,
        state: const ProfileEditInitial(),
      ),
    );
  }

  void changeIdnNumber(String value) {
    emit(
      state.copyWith(
        idnNum: value,
        state: const ProfileEditInitial(),
      ),
    );
  }
}
