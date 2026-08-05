import 'package:equatable/equatable.dart';
import 'package:mass_management/core/error/result.dart';
import 'package:mass_management/core/usecase/usecase.dart';
import 'package:mass_management/features/auth/domain/entities/auth_user.dart';
import 'package:mass_management/features/auth/domain/repositories/auth_repository.dart';

class LoginParams extends Equatable {
  final String email;
  final String password;

  const LoginParams({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}

class LoginUseCase implements UseCase<AuthUser, LoginParams> {
  final AuthRepository repository;

  const LoginUseCase(this.repository);

  @override
  Future<Result<AuthUser>> call(LoginParams params) {
    return repository.login(email: params.email, password: params.password);
  }
}
