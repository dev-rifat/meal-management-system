import 'package:mass_management/core/error/result.dart';
import 'package:mass_management/core/usecase/usecase.dart';
import 'package:mass_management/features/manager/domain/entities/manager_meal_entry.dart';
import 'package:mass_management/features/manager/domain/repositories/manager_repository.dart';

class AddMealEntryParams {
  final DateTime date;
  final Map<String, double> mealCounts;
  final String submittedFor;
  final String role;

  const AddMealEntryParams({
    required this.date,
    required this.mealCounts,
    required this.submittedFor,
    required this.role,
  });
}

class AddMealEntry implements UseCase<ManagerMealEntry, AddMealEntryParams> {
  final ManagerRepository repository;

  AddMealEntry(this.repository);

  @override
  Future<Result<ManagerMealEntry>> call(AddMealEntryParams params) {
    return repository.addMealEntry(
      date: params.date,
      mealCounts: params.mealCounts,
      submittedFor: params.submittedFor,
      role: params.role,
    );
  }
}
