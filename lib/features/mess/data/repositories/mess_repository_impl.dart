import 'package:mass_management/core/error/result.dart';
import 'package:mass_management/features/mess/data/datasources/mess_remote_data_source.dart';
import 'package:mass_management/features/mess/domain/entities/mess.dart' as domain;
import 'package:mass_management/features/mess/domain/repositories/mess_repository.dart';
import 'package:mess_manager_server_client/mess_manager_server_client.dart' as server;

class MessRepositoryImpl implements MessRepository {
  final MessRemoteDataSource remoteDataSource;

  const MessRepositoryImpl(this.remoteDataSource);

  @override
  Future<Result<domain.Mess>> createMess({
    required String name,
    required String phone,
  }) => guard(() async {
    final mess = await remoteDataSource.create(name: name, phone: phone);
    return _toDomain(mess);
  });

  @override
  Future<Result<domain.Mess>> joinMess({
    required String inviteCode,
    required String phone,
  }) => guard(() async {
    final mess = await remoteDataSource.join(
      inviteCode: inviteCode,
      phone: phone,
    );
    return _toDomain(mess);
  });

  domain.Mess _toDomain(server.Mess mess) => domain.Mess(
    id: mess.id.toString(),
    name: mess.name,
    inviteCode: mess.inviteCode,
  );
}
