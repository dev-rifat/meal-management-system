import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mass_management/core/error/result.dart';
import 'package:mass_management/features/manager/domain/entities/expense.dart';
import 'package:mass_management/features/manager/domain/repositories/manager_repository.dart';
import 'package:mass_management/features/manager/domain/usecases/add_expense.dart';

class _MockManagerRepository extends Mock implements ManagerRepository {}

void main() {
  late _MockManagerRepository repository;
  late AddExpense useCase;

  setUp(() {
    repository = _MockManagerRepository();
    useCase = AddExpense(repository);
  });

  test('forwards params to the repository and returns the created expense', () async {
    final date = DateTime(2025, 8, 10);
    final created = Expense(
      id: 'e1',
      title: 'Groceries',
      amount: 1200,
      type: ExpenseType.market,
      date: date,
      details: 'Vegetables',
      spentBy: 'Rifat Al Hasan',
    );

    when(() => repository.addExpense(
          title: 'Groceries',
          amount: 1200,
          date: date,
          details: 'Vegetables',
          spentBy: 'Rifat Al Hasan',
        )).thenAnswer((_) async => ResultSuccess(created));

    final result = await useCase(AddExpenseParams(
      title: 'Groceries',
      amount: 1200,
      date: date,
      details: 'Vegetables',
      spentBy: 'Rifat Al Hasan',
    ));

    expect(result, isA<ResultSuccess<Expense>>());
    result.fold(
      (_) => fail('expected success'),
      (expense) => expect(expense, created),
    );
  });
}
