import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mass_management/core/usecase/usecase.dart';
import 'package:mass_management/features/auth/domain/usecases/check_session_usecase.dart';
import 'package:mass_management/features/auth/domain/usecases/finish_registration_usecase.dart';
import 'package:mass_management/features/auth/domain/usecases/login_usecase.dart';
import 'package:mass_management/features/auth/domain/usecases/logout_usecase.dart';
import 'package:mass_management/features/auth/presentation/bloc/auth_event.dart';
import 'package:mass_management/features/auth/presentation/bloc/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUseCase loginUseCase;
  final FinishRegistrationUseCase finishRegistrationUseCase;
  final LogoutUseCase logoutUseCase;
  final CheckSessionUseCase checkSessionUseCase;

  AuthBloc({
    required this.loginUseCase,
    required this.finishRegistrationUseCase,
    required this.logoutUseCase,
    required this.checkSessionUseCase,
  }) : super(const AuthInitial()) {
    on<LoginRequested>(_onLoginRequested);
    on<FinishRegistrationRequested>(_onFinishRegistrationRequested);
    on<LogoutRequested>(_onLogoutRequested);
    on<CheckSessionRequested>(_onCheckSessionRequested);
  }

  Future<void> _onLoginRequested(
    LoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());
    final result = await loginUseCase(
      LoginParams(email: event.email, password: event.password),
    );
    result.fold(
      (failure) => emit(AuthError(failure.message)),
      (user) => emit(AuthAuthenticated(user)),
    );
  }

  Future<void> _onFinishRegistrationRequested(
    FinishRegistrationRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());
    final result = await finishRegistrationUseCase(
      FinishRegistrationParams(
        registrationToken: event.registrationToken,
        password: event.password,
        fullName: event.fullName,
      ),
    );
    result.fold(
      (failure) => emit(AuthError(failure.message)),
      (user) => emit(AuthAuthenticated(user)),
    );
  }

  Future<void> _onLogoutRequested(
    LogoutRequested event,
    Emitter<AuthState> emit,
  ) async {
    final result = await logoutUseCase(const NoParams());
    result.fold(
      (failure) => emit(AuthError(failure.message)),
      (_) => emit(const AuthUnauthenticated()),
    );
  }

  /// Also used to refresh the current user after `MessCubit` attaches a
  /// mess (create/join) — that call doesn't itself update `AuthBloc`'s
  /// state, so the caller re-fires this afterward to pick up the new
  /// `messId` (see `mess_choice_sheet.dart`/`user_info_sheet.dart`).
  Future<void> _onCheckSessionRequested(
    CheckSessionRequested event,
    Emitter<AuthState> emit,
  ) async {
    final result = await checkSessionUseCase(const NoParams());
    result.fold(
      (failure) => emit(AuthError(failure.message)),
      (user) => emit(
        user != null ? AuthAuthenticated(user) : const AuthUnauthenticated(),
      ),
    );
  }
}
