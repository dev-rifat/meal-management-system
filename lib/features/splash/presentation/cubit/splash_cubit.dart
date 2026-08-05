import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mass_management/core/usecase/usecase.dart';
import 'package:mass_management/features/auth/domain/usecases/check_session_usecase.dart';
import 'package:mass_management/features/splash/presentation/cubit/splash_state.dart';

/// Decides where the app should route to once it starts: the dashboard if
/// a session already exists, or the login screen otherwise.
///
/// A short branding delay is kept before emitting the final state purely
/// so the loader animation has time to be visible — it is a cancellable
/// [Timer]-backed [Future], not a fire-and-forget navigation timer, so it
/// never fires after the cubit (and the widget observing it) is gone.
class SplashCubit extends Cubit<SplashState> {
  final CheckSessionUseCase checkSessionUseCase;

  static const _brandingDelay = Duration(seconds: 5);

  Timer? _brandingTimer;

  SplashCubit(this.checkSessionUseCase) : super(const SplashLoading());

  /// Waits out the branding delay, then asks [CheckSessionUseCase] whether
  /// there is an active session and emits the matching state.
  Future<void> checkSession() async {
    final completer = Completer<void>();
    _brandingTimer = Timer(_brandingDelay, () {
      if (!completer.isCompleted) completer.complete();
    });
    await completer.future;

    if (isClosed) return;

    final result = await checkSessionUseCase(const NoParams());

    if (isClosed) return;

    result.fold(
      (failure) => emit(const SplashUnauthenticated()),
      (user) => emit(user == null ? const SplashUnauthenticated() : SplashAuthenticated(user)),
    );
  }

  @override
  Future<void> close() {
    _brandingTimer?.cancel();
    return super.close();
  }
}
