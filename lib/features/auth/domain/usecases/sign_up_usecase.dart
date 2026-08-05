import 'package:equatable/equatable.dart';
import 'package:mass_management/core/error/result.dart';
import 'package:mass_management/core/usecase/usecase.dart';
import 'package:mass_management/features/auth/domain/entities/auth_user.dart';
import 'package:mass_management/features/auth/domain/repositories/auth_repository.dart';

class SignUpParams extends Equatable {
  final String email;
  final String username;
  final String password;

  const SignUpParams({
    required this.email,
    required this.username,
    required this.password,
  });

  @override
  List<Object?> get props => [email, username, password];
}

class SignUpUseCase implements UseCase<AuthUser, SignUpParams> {
  final AuthRepository repository;

  const SignUpUseCase(this.repository);

  @override
  Future<Result<AuthUser>> call(SignUpParams params) {
    return repository.signUp(
      email: params.email,
      username: params.username,
      password: params.password,
    );
  }
}
