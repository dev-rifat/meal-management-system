import 'package:equatable/equatable.dart';
import 'package:mass_management/core/error/result.dart';
import 'package:mass_management/core/usecase/usecase.dart';
import 'package:mass_management/features/members/domain/repositories/members_repository.dart';

class RecordPaymentParams extends Equatable {
  final String id;
  final double amount;
  final DateTime date;

  const RecordPaymentParams({
    required this.id,
    required this.amount,
    required this.date,
  });

  @override
  List<Object?> get props => [id, amount, date];
}

class RecordPayment implements UseCase<void, RecordPaymentParams> {
  final MembersRepository repository;

  const RecordPayment(this.repository);

  @override
  Future<Result<void>> call(RecordPaymentParams params) {
    return repository.recordPayment(id: params.id, amount: params.amount, date: params.date);
  }
}
