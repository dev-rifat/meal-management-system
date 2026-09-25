import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mass_management/features/auth/domain/usecases/start_registration_usecase.dart';
import 'package:mass_management/features/auth/domain/usecases/verify_registration_code_usecase.dart';
import 'package:mass_management/features/auth/presentation/cubit/registration_state.dart';

/// Drives the "check your email for a code" step of sign-up — see
/// registration_state.dart for why this is a separate, screen-local Cubit
/// instead of living in the app-wide AuthBloc.
class RegistrationCubit extends Cubit<RegistrationState> {
  final StartRegistrationUseCase _startRegistration;
  final VerifyRegistrationCodeUseCase _verifyRegistrationCode;

  RegistrationCubit({
    required StartRegistrationUseCase startRegistrationUseCase,
    required VerifyRegistrationCodeUseCase verifyRegistrationCodeUseCase,
  }) : _startRegistration = startRegistrationUseCase,
       _verifyRegistrationCode = verifyRegistrationCodeUseCase,
       super(const RegistrationInitial());

  Future<void> startRegistration(String email) async {
    emit(const RegistrationSubmitting());
    final result = await _startRegistration(
      StartRegistrationParams(email: email),
    );
    result.fold(
      (failure) => emit(RegistrationFailure(failure.message)),
      (accountRequestId) => emit(RegistrationCodeSent(accountRequestId)),
    );
  }

  Future<void> verifyCode(String accountRequestId, String code) async {
    emit(const RegistrationSubmitting());
    final result = await _verifyRegistrationCode(
      VerifyRegistrationCodeParams(
        accountRequestId: accountRequestId,
        code: code,
      ),
    );
    result.fold(
      (failure) => emit(RegistrationFailure(failure.message)),
      (registrationToken) => emit(RegistrationVerified(registrationToken)),
    );
  }
}
