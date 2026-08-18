import 'package:get_it/get_it.dart';
import 'package:mass_management/features/mess/data/datasources/mess_local_data_source.dart';
import 'package:mass_management/features/mess/data/repositories/mess_repository_impl.dart';
import 'package:mass_management/features/mess/domain/repositories/mess_repository.dart';
import 'package:mass_management/features/mess/domain/usecases/create_mess.dart';
import 'package:mass_management/features/mess/domain/usecases/join_mess.dart';
import 'package:mass_management/features/mess/presentation/cubit/mess_cubit.dart';

/// Registers every dependency the mess feature needs into [sl].
void initMessInjection(GetIt sl) {
  sl.registerLazySingleton<MessLocalDataSource>(
    () => MessLocalDataSourceImpl(),
  );

  sl.registerLazySingleton<MessRepository>(
    () => MessRepositoryImpl(sl<MessLocalDataSource>()),
  );

  sl.registerLazySingleton<CreateMess>(() => CreateMess(sl<MessRepository>()));
  sl.registerLazySingleton<JoinMess>(() => JoinMess(sl<MessRepository>()));

  sl.registerFactory<MessCubit>(
    () => MessCubit(createMess: sl<CreateMess>(), joinMess: sl<JoinMess>()),
  );
}
