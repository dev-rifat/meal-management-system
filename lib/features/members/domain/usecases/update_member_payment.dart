import 'package:equatable/equatable.dart';
import 'package:mass_management/core/error/result.dart';
import 'package:mass_management/core/usecase/usecase.dart';
import 'package:mass_management/features/members/domain/entities/member.dart';
import 'package:mass_management/features/members/domain/repositories/members_repository.dart';

class UpdateMemberPaymentParams extends Equatable {
  final String id;
  final MemberPaymentStatus paymentStatus;
  final DateTime? paymentDate;

  const UpdateMemberPaymentParams({
    required this.id,
    required this.paymentStatus,
    this.paymentDate,
  });

  @override
  List<Object?> get props => [id, paymentStatus, paymentDate];
}

class UpdateMemberPayment implements UseCase<void, UpdateMemberPaymentParams> {
  final MembersRepository repository;

  const UpdateMemberPayment(this.repository);

  @override
  Future<Result<void>> call(UpdateMemberPaymentParams params) {
    return repository.updateMemberPayment(
      id: params.id,
      paymentStatus: params.paymentStatus,
      paymentDate: params.paymentDate,
    );
  }
}
