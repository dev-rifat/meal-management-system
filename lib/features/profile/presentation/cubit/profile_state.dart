import 'package:equatable/equatable.dart';
import 'package:mass_management/features/profile/domain/entities/profile.dart';

sealed class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object?> get props => [];
}

class ProfileLoading extends ProfileState {
  const ProfileLoading();
}

class ProfileLoaded extends ProfileState {
  final Profile profile;

  const ProfileLoaded(this.profile);

  @override
  List<Object?> get props => [profile];
}

class ProfileError extends ProfileState {
  final String message;

  const ProfileError(this.message);

  @override
  List<Object?> get props => [message];
}

/// Emitted once logout has actually completed (session cleared via
/// [LogoutUseCase]) — the page reacts to this by navigating away.
class ProfileLoggedOut extends ProfileState {
  const ProfileLoggedOut();
}
