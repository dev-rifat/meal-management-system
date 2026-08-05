import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mass_management/core/usecase/usecase.dart';
import 'package:mass_management/features/auth/domain/usecases/logout_usecase.dart';
import 'package:mass_management/features/profile/domain/usecases/get_current_profile.dart';
import 'package:mass_management/features/profile/presentation/cubit/profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final GetCurrentProfile getCurrentProfile;
  final LogoutUseCase logoutUseCase;

  ProfileCubit({
    required this.getCurrentProfile,
    required this.logoutUseCase,
  }) : super(const ProfileLoading());

  Future<void> loadProfile() async {
    emit(const ProfileLoading());
    final result = await getCurrentProfile(const NoParams());
    result.fold(
      (failure) => emit(ProfileError(failure.message)),
      (profile) => emit(ProfileLoaded(profile)),
    );
  }

  Future<void> logout() async {
    final result = await logoutUseCase(const NoParams());
    result.fold(
      (failure) => emit(ProfileError(failure.message)),
      (_) => emit(const ProfileLoggedOut()),
    );
  }
}
