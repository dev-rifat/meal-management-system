import 'package:get_it/get_it.dart';
import 'package:mass_management/features/members/data/datasources/members_remote_data_source.dart';
import 'package:mass_management/features/members/data/repositories/members_repository_impl.dart';
import 'package:mass_management/features/members/domain/repositories/members_repository.dart';
import 'package:mass_management/features/members/domain/usecases/delete_member.dart';
import 'package:mass_management/features/members/domain/usecases/get_members.dart';
import 'package:mass_management/features/members/domain/usecases/record_payment.dart';
import 'package:mass_management/features/members/domain/usecases/update_member_payment.dart';
import 'package:mass_management/features/members/presentation/cubit/members_cubit.dart';
import 'package:mess_manager_server_client/mess_manager_server_client.dart';

/// Registers every dependency the members feature needs into [sl]. Depends
/// on the shared `Client` that `service_locator.dart` registers before
/// calling this.
void initMembersInjection(GetIt sl) {
  sl.registerLazySingleton<MembersRemoteDataSource>(
    () => MembersRemoteDataSourceImpl(sl<Client>()),
  );

  sl.registerLazySingleton<MembersRepository>(
    () => MembersRepositoryImpl(sl<MembersRemoteDataSource>()),
  );

  sl.registerLazySingleton<GetMembers>(() => GetMembers(sl<MembersRepository>()));
  sl.registerLazySingleton<DeleteMember>(() => DeleteMember(sl<MembersRepository>()));
  sl.registerLazySingleton<UpdateMemberPayment>(
    () => UpdateMemberPayment(sl<MembersRepository>()),
  );
  sl.registerLazySingleton<RecordPayment>(
    () => RecordPayment(sl<MembersRepository>()),
  );

  sl.registerFactory<MembersCubit>(
    () => MembersCubit(
      getMembers: sl<GetMembers>(),
      deleteMember: sl<DeleteMember>(),
      updateMemberPayment: sl<UpdateMemberPayment>(),
      recordPayment: sl<RecordPayment>(),
    ),
  );
}
