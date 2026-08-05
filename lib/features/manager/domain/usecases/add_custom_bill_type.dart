import 'package:mass_management/core/error/result.dart';
import 'package:mass_management/core/usecase/usecase.dart';
import 'package:mass_management/features/manager/domain/repositories/manager_repository.dart';

class AddCustomBillTypeParams {
  final String billType;

  const AddCustomBillTypeParams(this.billType);
}

/// Adds a new bill type and returns the updated list so it persists for the
/// rest of the session and shows up from [GetBillTypes] afterward.
class AddCustomBillType implements UseCase<List<String>, AddCustomBillTypeParams> {
  final ManagerRepository repository;

  AddCustomBillType(this.repository);

  @override
  Future<Result<List<String>>> call(AddCustomBillTypeParams params) {
    return repository.addCustomBillType(params.billType);
  }
}
