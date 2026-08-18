import 'package:mass_management/core/error/result.dart';
import 'package:mass_management/features/mess/domain/entities/mess.dart';

/// Contract the data layer must fulfil for anything mess-related. The
/// presentation layer (via the use cases) only ever talks to this interface.
abstract class MessRepository {
  Future<Result<Mess>> createMess({required String name});

  Future<Result<Mess>> joinMess({required String inviteCode});
}
