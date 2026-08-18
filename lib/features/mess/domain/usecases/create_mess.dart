import 'package:equatable/equatable.dart';
import 'package:mass_management/core/error/result.dart';
import 'package:mass_management/core/usecase/usecase.dart';
import 'package:mass_management/features/mess/domain/entities/mess.dart';
import 'package:mass_management/features/mess/domain/repositories/mess_repository.dart';

class CreateMessParams extends Equatable {
  final String name;

  const CreateMessParams(this.name);

  @override
  List<Object?> get props => [name];
}

class CreateMess implements UseCase<Mess, CreateMessParams> {
  final MessRepository repository;

  const CreateMess(this.repository);

  @override
  Future<Result<Mess>> call(CreateMessParams params) {
    return repository.createMess(name: params.name);
  }
}
