import 'package:mass_management/core/error/exceptions.dart';
import 'package:mass_management/core/error/failure.dart';
import 'package:mass_management/core/error/result.dart';
import 'package:mass_management/features/mess/data/datasources/mess_local_data_source.dart';
import 'package:mass_management/features/mess/domain/entities/mess.dart';
import 'package:mass_management/features/mess/domain/repositories/mess_repository.dart';

class MessRepositoryImpl implements MessRepository {
  final MessLocalDataSource localDataSource;

  const MessRepositoryImpl(this.localDataSource);

  @override
  Future<Result<Mess>> createMess({required String name}) async {
    return ResultSuccess(localDataSource.createMess(name: name));
  }

  @override
  Future<Result<Mess>> joinMess({required String inviteCode}) async {
    try {
      return ResultSuccess(localDataSource.joinMess(inviteCode: inviteCode));
    } on NotFoundException catch (e) {
      return ResultError(NotFoundFailure(e.message));
    }
  }
}
