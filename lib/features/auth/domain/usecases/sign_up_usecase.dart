import 'package:equatable/equatable.dart';
import 'package:mass_management/core/enums/user_role.dart';
import 'package:mass_management/core/error/result.dart';
import 'package:mass_management/core/usecase/usecase.dart';
import 'package:mass_management/features/auth/domain/entities/auth_user.dart';
import 'package:mass_management/features/auth/domain/repositories/auth_repository.dart';

class SignUpParams extends Equatable {
  final String email;
  final String username;
  final String phone;
  final String password;
  final UserRole role;
  final String messId;

  const SignUpParams({
    required this.email,
    required this.username,
    required this.phone,
    required this.password,
    required this.role,
    required this.messId,
  });

  @override
  List<Object?> get props => [email, username, phone, password, role, messId];
}

class SignUpUseCase implements UseCase<AuthUser, SignUpParams> {
  final AuthRepository repository;

  const SignUpUseCase(this.repository);

  @override
  Future<Result<AuthUser>> call(SignUpParams params) {
    return repository.signUp(
      email: params.email,
      username: params.username,
      phone: params.phone,
      password: params.password,
      role: params.role,
      messId: params.messId,
    );
  }
}
