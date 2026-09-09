import 'package:mass_management/core/error/result.dart';
import 'package:mass_management/features/profile/data/datasources/profile_local_data_source.dart';
import 'package:mass_management/features/profile/domain/entities/profile.dart';
import 'package:mass_management/features/profile/domain/repositories/profile_repository.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileLocalDataSource localDataSource;

  const ProfileRepositoryImpl({required this.localDataSource});

  @override
  Future<Result<Profile>> getCurrentProfile() =>
      guard(() => localDataSource.getCurrentProfile());
}
