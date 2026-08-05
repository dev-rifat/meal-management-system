import 'package:equatable/equatable.dart';
import 'package:mass_management/features/auth/domain/entities/auth_user.dart';

/// States emitted by [SplashCubit] while it decides where to route the
/// user once the branding delay has elapsed.
sealed class SplashState extends Equatable {
  const SplashState();

  @override
  List<Object?> get props => [];
}

/// Initial/in-progress state — branding animation is shown while the
/// session check runs in the background.
class SplashLoading extends SplashState {
  const SplashLoading();
}

/// A session already exists — the UI should route to the dashboard.
class SplashAuthenticated extends SplashState {
  final AuthUser user;

  const SplashAuthenticated(this.user);

  @override
  List<Object?> get props => [user];
}

/// No active session — the UI should route to the login screen.
class SplashUnauthenticated extends SplashState {
  const SplashUnauthenticated();
}
