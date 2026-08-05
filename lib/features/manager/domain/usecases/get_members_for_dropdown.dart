import 'package:mass_management/core/error/result.dart';
import 'package:mass_management/core/usecase/usecase.dart';
import 'package:mass_management/features/manager/domain/repositories/manager_repository.dart';

/// This feature's OWN seeded member-name list, used to populate the
/// "Spent By" / "Submitted For" dropdowns. Deliberately NOT a cross-feature
/// call into members/user_list — see the manager feature notes.
class GetMembersForDropdown implements UseCase<List<String>, NoParams> {
  final ManagerRepository repository;

  GetMembersForDropdown(this.repository);

  @override
  Future<Result<List<String>>> call(NoParams params) {
    return repository.getMembersForDropdown();
  }
}
