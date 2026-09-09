import 'package:get_it/get_it.dart';
import 'package:mass_management/features/members/data/datasources/members_local_data_source.dart';
import 'package:mass_management/features/members/data/repositories/members_repository_impl.dart';
import 'package:mass_management/features/members/domain/repositories/members_repository.dart';
import 'package:mass_management/features/members/domain/usecases/delete_member.dart';
import 'package:mass_management/features/members/domain/usecases/get_members.dart';
import 'package:mass_management/features/members/domain/usecases/update_member.dart';
import 'package:mass_management/features/members/presentation/cubit/members_cubit.dart';

/// Registers every dependency the members feature needs into [sl].
///
/// Called from `core/di/service_locator.dart`, alongside the equivalent
/// init function for every other feature.
void initMembersInjection(GetIt sl) {
  sl.registerLazySingleton<MembersLocalDataSource>(
    () => MembersLocalDataSourceImpl(),
  );

  sl.registerLazySingleton<MembersRepository>(
    () => MembersRepositoryImpl(sl<MembersLocalDataSource>()),
  );

  sl.registerLazySingleton<GetMembers>(() => GetMembers(sl<MembersRepository>()));
  sl.registerLazySingleton<DeleteMember>(() => DeleteMember(sl<MembersRepository>()));
  sl.registerLazySingleton<UpdateMember>(() => UpdateMember(sl<MembersRepository>()));

  sl.registerFactory<MembersCubit>(
    () => MembersCubit(
      getMembers: sl<GetMembers>(),
      deleteMember: sl<DeleteMember>(),
      updateMember: sl<UpdateMember>(),
    ),
  );
}
