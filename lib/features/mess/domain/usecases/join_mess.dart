import 'package:equatable/equatable.dart';
import 'package:mass_management/core/error/result.dart';
import 'package:mass_management/core/usecase/usecase.dart';
import 'package:mass_management/features/mess/domain/entities/mess.dart';
import 'package:mass_management/features/mess/domain/repositories/mess_repository.dart';

class JoinMessParams extends Equatable {
  final String inviteCode;
  final String phone;

  const JoinMessParams({required this.inviteCode, required this.phone});

  @override
  List<Object?> get props => [inviteCode, phone];
}

class JoinMess implements UseCase<Mess, JoinMessParams> {
  final MessRepository repository;

  const JoinMess(this.repository);

  @override
  Future<Result<Mess>> call(JoinMessParams params) {
    return repository.joinMess(
      inviteCode: params.inviteCode,
      phone: params.phone,
    );
  }
}
