import 'package:get_it/get_it.dart';
import 'package:mass_management/features/manager/data/datasources/manager_remote_data_source.dart';
import 'package:mass_management/features/manager/data/repositories/manager_repository_impl.dart';
import 'package:mass_management/features/manager/domain/repositories/manager_repository.dart';
import 'package:mass_management/features/manager/domain/usecases/add_expense.dart';
import 'package:mass_management/features/manager/domain/usecases/add_shared_expense.dart';
import 'package:mass_management/features/manager/domain/usecases/get_bill_types.dart';
import 'package:mass_management/features/manager/domain/usecases/get_expense_summary.dart';
import 'package:mass_management/features/manager/domain/usecases/get_expenses.dart';
import 'package:mass_management/features/manager/presentation/cubit/add_expense_cubit.dart';
import 'package:mass_management/features/manager/presentation/cubit/add_meal_cubit.dart';
import 'package:mass_management/features/manager/presentation/cubit/add_share_expense_cubit.dart';
import 'package:mass_management/features/manager/presentation/cubit/expense_list_cubit.dart';
import 'package:mass_management/features/manager/presentation/cubit/manager_summary_cubit.dart';
import 'package:mass_management/features/dashboard/domain/usecases/submit_meal.dart';
import 'package:mass_management/features/members/domain/repositories/members_repository.dart';
import 'package:mass_management/features/members/domain/usecases/get_members.dart';
import 'package:mess_manager_server_client/mess_manager_server_client.dart';

/// Registers every dependency the manager feature needs into [sl].
///
/// Called from `core/di/service_locator.dart`, alongside the equivalent
/// init function for every other feature. Each manager route in
/// `app_page.dart` separately wraps itself in a
/// `BlocProvider(create: (_) => sl<XCubit>())` for the cubit(s) that
/// route's page reads via `context.read`/`BlocBuilder`.
void initManagerInjection(GetIt sl) {
  sl.registerLazySingleton<ManagerRemoteDataSource>(
    () => ManagerRemoteDataSourceImpl(sl<Client>()),
  );

  sl.registerLazySingleton<ManagerRepository>(
    () => ManagerRepositoryImpl(
      remoteDataSource: sl<ManagerRemoteDataSource>(),
      membersRepository: sl<MembersRepository>(),
    ),
  );

  sl.registerLazySingleton<GetExpenses>(() => GetExpenses(sl<ManagerRepository>()));
  sl.registerLazySingleton<GetExpenseSummary>(() => GetExpenseSummary(sl<ManagerRepository>()));
  sl.registerLazySingleton<AddExpense>(() => AddExpense(sl<ManagerRepository>()));
  sl.registerLazySingleton<AddSharedExpense>(() => AddSharedExpense(sl<ManagerRepository>()));
  sl.registerLazySingleton<GetBillTypes>(() => GetBillTypes(sl<ManagerRepository>()));

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
      getMembers: sl<GetMembers>(),
    ),
  );
  sl.registerFactory<AddShareExpenseCubit>(
    () => AddShareExpenseCubit(
      addSharedExpense: sl<AddSharedExpense>(),
      getBillTypes: sl<GetBillTypes>(),
      getMembers: sl<GetMembers>(),
    ),
  );
  sl.registerFactory<AddMealCubit>(
    () => AddMealCubit(
      submitMealUseCase: sl<SubmitMealUseCase>(),
      getMembers: sl<GetMembers>(),
    ),
  );
}
