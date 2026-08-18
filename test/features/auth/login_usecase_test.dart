import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mass_management/core/enums/user_role.dart';
import 'package:mass_management/core/error/failure.dart';
import 'package:mass_management/core/error/result.dart';
import 'package:mass_management/features/auth/domain/entities/auth_user.dart';
import 'package:mass_management/features/auth/domain/repositories/auth_repository.dart';
import 'package:mass_management/features/auth/domain/usecases/login_usecase.dart';

class _MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  late _MockAuthRepository repository;
  late LoginUseCase useCase;

  setUp(() {
    repository = _MockAuthRepository();
    useCase = LoginUseCase(repository);
  });

  const user = AuthUser(
    id: 1,
    name: 'Jane',
    email: 'jane@example.com',
    token: 'token',
    role: UserRole.member,
  );

  test('returns the authenticated user on success', () async {
    when(
      () => repository.login(email: 'jane@example.com', password: 'secret'),
    ).thenAnswer((_) async => const ResultSuccess(user));

    final result = await useCase(
      const LoginParams(email: 'jane@example.com', password: 'secret'),
    );

    expect(result, isA<ResultSuccess<AuthUser>>());
    result.fold((_) => fail('expected success'), (data) => expect(data, user));
    verify(
      () => repository.login(email: 'jane@example.com', password: 'secret'),
    ).called(1);
  });

  test('propagates the repository failure on error', () async {
    when(
      () => repository.login(
        email: any(named: 'email'),
        password: any(named: 'password'),
      ),
    ).thenAnswer(
      (_) async => const ResultError(ServerFailure('bad credentials')),
    );

    final result = await useCase(
      const LoginParams(email: 'jane@example.com', password: 'wrong'),
    );

    expect(result, isA<ResultError<AuthUser>>());
    result.fold(
      (failure) => expect(failure.message, 'bad credentials'),
      (_) => fail('expected failure'),
    );
  });
}
