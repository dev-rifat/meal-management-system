import 'package:get_it/get_it.dart';
import 'package:mass_management/features/dashboard/data/datasources/dashboard_remote_data_source.dart';
import 'package:mass_management/features/dashboard/data/repositories/dashboard_repository_impl.dart';
import 'package:mass_management/features/dashboard/domain/repositories/dashboard_repository.dart';
import 'package:mass_management/features/dashboard/domain/usecases/get_balance_summaries.dart';
import 'package:mass_management/features/dashboard/domain/usecases/get_meals_for_month.dart';
import 'package:mass_management/features/dashboard/domain/usecases/get_monthly_summary.dart';
import 'package:mass_management/features/dashboard/domain/usecases/get_transactions.dart';
import 'package:mass_management/features/dashboard/domain/usecases/get_wallet_summary.dart';
import 'package:mass_management/features/dashboard/domain/usecases/submit_meal.dart';
import 'package:mass_management/features/dashboard/domain/usecases/update_meal_status.dart';
import 'package:mass_management/features/dashboard/presentation/cubit/dashboard_cubit.dart';
import 'package:mass_management/features/dashboard/presentation/cubit/meal_list_cubit.dart';
import 'package:mass_management/features/dashboard/presentation/cubit/monthly_summary_cubit.dart';
import 'package:mass_management/features/dashboard/presentation/cubit/wallet_cubit.dart';
import 'package:mess_manager_server_client/mess_manager_server_client.dart';

/// Registers every dependency the dashboard feature needs into [sl].
///
/// Called from `core/di/service_locator.dart`, alongside the equivalent
/// init function for every other feature.
void initDashboardInjection(GetIt sl) {
  sl.registerLazySingleton<DashboardRemoteDataSource>(
    () => DashboardRemoteDataSourceImpl(sl<Client>()),
  );

  sl.registerLazySingleton<DashboardRepository>(
    () => DashboardRepositoryImpl(remoteDataSource: sl<DashboardRemoteDataSource>()),
  );

  sl.registerLazySingleton<GetBalanceSummariesUseCase>(
    () => GetBalanceSummariesUseCase(sl<DashboardRepository>()),
  );
  sl.registerLazySingleton<GetWalletSummaryUseCase>(
    () => GetWalletSummaryUseCase(sl<DashboardRepository>()),
  );
  sl.registerLazySingleton<GetTransactionsUseCase>(
    () => GetTransactionsUseCase(sl<DashboardRepository>()),
  );
  sl.registerLazySingleton<GetMealsForMonthUseCase>(
    () => GetMealsForMonthUseCase(sl<DashboardRepository>()),
  );
  sl.registerLazySingleton<UpdateMealStatusUseCase>(
    () => UpdateMealStatusUseCase(sl<DashboardRepository>()),
  );
  sl.registerLazySingleton<GetMonthlySummaryUseCase>(
    () => GetMonthlySummaryUseCase(sl<DashboardRepository>()),
  );
  sl.registerLazySingleton<SubmitMealUseCase>(
    () => SubmitMealUseCase(sl<DashboardRepository>()),
  );

  sl.registerFactory<DashboardCubit>(
    () => DashboardCubit(
      getBalanceSummaries: sl<GetBalanceSummariesUseCase>(),
      getTransactions: sl<GetTransactionsUseCase>(),
    ),
  );
  sl.registerFactory<WalletCubit>(
    () => WalletCubit(
      getWalletSummary: sl<GetWalletSummaryUseCase>(),
      getTransactions: sl<GetTransactionsUseCase>(),
    ),
  );
  sl.registerFactory<MealListCubit>(
    () => MealListCubit(
      getMealsForMonth: sl<GetMealsForMonthUseCase>(),
      updateMealStatusUseCase: sl<UpdateMealStatusUseCase>(),
    ),
  );
  sl.registerFactory<MonthlySummaryCubit>(
    () => MonthlySummaryCubit(
      getMonthlySummary: sl<GetMonthlySummaryUseCase>(),
    ),
  );
}
