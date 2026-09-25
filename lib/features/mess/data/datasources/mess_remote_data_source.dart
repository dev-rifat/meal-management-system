import 'package:mass_management/core/error/exceptions.dart';
import 'package:mess_manager_server_client/mess_manager_server_client.dart';

/// Talks to the real backend's `MessEndpoint` — both methods require an
/// authenticated session (see `MessEndpoint.requireLogin` server-side).
abstract class MessRemoteDataSource {
  Future<Mess> create({required String name, required String phone});

  Future<Mess> join({required String inviteCode, required String phone});
}

class MessRemoteDataSourceImpl implements MessRemoteDataSource {
  final Client client;

  MessRemoteDataSourceImpl(this.client);

  @override
  Future<Mess> create({
    required String name,
    required String phone,
  }) => _run(() => client.mess.create(name: name, phone: phone));

  @override
  Future<Mess> join({
    required String inviteCode,
    required String phone,
  }) => _run(
    () => client.mess.join(inviteCode: inviteCode, phone: phone),
  );

  /// Translates the server's typed exceptions into this app's own exception
  /// types so `guard()` (core/error/result.dart) maps them to a [Failure]
  /// the same way every other repository does.
  Future<T> _run<T>(Future<T> Function() action) async {
    try {
      return await action();
    } on MessNotFoundException {
      throw const NotFoundException('No mess found for this invite code.');
    } on AlreadyInAMessException {
      throw const ServerException('This account is already in a mess.');
    } on ServerpodClientException catch (e) {
      throw NetworkException('Could not reach the server (${e.statusCode}).');
    }
  }
}
