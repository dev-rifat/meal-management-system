import 'package:get_it/get_it.dart';
import 'package:mass_management/features/manager/data/datasources/manager_local_data_source.dart';
import 'package:mass_management/features/manager/data/repositories/manager_repository_impl.dart';
import 'package:mass_management/features/manager/domain/repositories/manager_repository.dart';
import 'package:mass_management/features/manager/domain/usecases/add_custom_bill_type.dart';
import 'package:mass_management/features/manager/domain/usecases/add_expense.dart';
import 'package:mass_management/features/manager/domain/usecases/add_meal_entry.dart';
import 'package:mass_management/features/manager/domain/usecases/add_shared_expense.dart';
import 'package:mass_management/features/manager/domain/usecases/get_bill_types.dart';
import 'package:mass_management/features/manager/domain/usecases/get_expense_summary.dart';
import 'package:mass_management/features/manager/domain/usecases/get_expenses.dart';
import 'package:mass_management/features/manager/domain/usecases/get_members_for_dropdown.dart';
import 'package:mass_management/features/manager/presentation/cubit/add_expense_cubit.dart';
import 'package:mass_management/features/manager/presentation/cubit/add_meal_cubit.dart';
import 'package:mass_management/features/manager/presentation/cubit/add_share_expense_cubit.dart';
import 'package:mass_management/features/manager/presentation/cubit/expense_list_cubit.dart';
import 'package:mass_management/features/manager/presentation/cubit/manager_summary_cubit.dart';

/// Registers every dependency the manager feature needs into [sl].
///
/// This is NOT called anywhere yet — a central `service_locator.dart` (owned
/// by a different part of this refactor) will call `initManagerInjection(sl)`
/// once it exists, alongside similar init functions for other features. That
/// same central pass is also responsible for wrapping each manager route in
/// `app_page.dart` with a `BlocProvider(create: (_) => sl<XCubit>())` for the
/// cubit(s) that route's page reads via `context.read`/`BlocBuilder`.
void initManagerInjection(GetIt sl) {
  // In-memory demo data store — no backend exists for mess-management data
  // yet, so this seeds the same values the old widgets hardcoded directly.
  sl.registerLazySingleton<ManagerLocalDataSource>(() => ManagerLocalDataSource());

  sl.registerLazySingleton<ManagerRepository>(
    () => ManagerRepositoryImpl(sl<ManagerLocalDataSource>()),
  );

  sl.registerLazySingleton<GetExpenses>(() => GetExpenses(sl<ManagerRepository>()));
  sl.registerLazySingleton<GetExpenseSummary>(() => GetExpenseSummary(sl<ManagerRepository>()));
  sl.registerLazySingleton<AddExpense>(() => AddExpense(sl<ManagerRepository>()));
  sl.registerLazySingleton<AddSharedExpense>(() => AddSharedExpense(sl<ManagerRepository>()));
  sl.registerLazySingleton<AddCustomBillType>(() => AddCustomBillType(sl<ManagerRepository>()));
  sl.registerLazySingleton<GetBillTypes>(() => GetBillTypes(sl<ManagerRepository>()));
  sl.registerLazySingleton<GetMembersForDropdown>(
    () => GetMembersForDropdown(sl<ManagerRepository>()),
  );
  sl.registerLazySingleton<AddMealEntry>(() => AddMealEntry(sl<ManagerRepository>()));

  // Cubits — one factory per screen/section so each navigation to a manager
  // page gets a fresh cubit instance.
  sl.registerFactory<ManagerSummaryCubit>(
    () => ManagerSummaryCubit(getExpenseSummary: sl<GetExpenseSummary>()),
  );
  sl.registerFactory<ExpenseListCubit>(
    () => ExpenseListCubit(getExpenses: sl<GetExpenses>()),
  );
  sl.registerFactory<AddExpenseCubit>(
    () => AddExpenseCubit(
      addExpense: sl<AddExpense>(),
      getMembersForDropdown: sl<GetMembersForDropdown>(),
    ),
  );
  sl.registerFactory<AddShareExpenseCubit>(
    () => AddShareExpenseCubit(
      addSharedExpense: sl<AddSharedExpense>(),
      addCustomBillType: sl<AddCustomBillType>(),
      getBillTypes: sl<GetBillTypes>(),
      getMembersForDropdown: sl<GetMembersForDropdown>(),
    ),
  );
  sl.registerFactory<AddMealCubit>(
    () => AddMealCubit(
      addMealEntry: sl<AddMealEntry>(),
      getMembersForDropdown: sl<GetMembersForDropdown>(),
    ),
  );
}
