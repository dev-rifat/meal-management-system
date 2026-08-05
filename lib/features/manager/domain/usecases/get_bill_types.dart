import 'package:mass_management/core/error/result.dart';
import 'package:mass_management/core/usecase/usecase.dart';
import 'package:mass_management/features/manager/domain/repositories/manager_repository.dart';

class GetBillTypes implements UseCase<List<String>, NoParams> {
  final ManagerRepository repository;

  GetBillTypes(this.repository);

  @override
  Future<Result<List<String>>> call(NoParams params) {
    return repository.getBillTypes();
  }
}
