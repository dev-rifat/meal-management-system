import 'package:mass_management/core/error/result.dart';

abstract class UseCase<ReturnType, Params> {
  Future<Result<ReturnType>> call(Params params);
}

class NoParams {
  const NoParams();
}
