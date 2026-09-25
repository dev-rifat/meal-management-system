import 'package:mass_management/core/error/exceptions.dart';
import 'package:mess_manager_server_client/mess_manager_server_client.dart';

/// Talks to the real backend's `MessEndpoint` member methods — all three
/// require an authenticated session already in a mess; the update/remove
/// pair is manager-only, enforced server-side.
abstract class MembersRemoteDataSource {
  Future<List<MessMemberProfile>> getMembers();

  Future<void> deleteMember(int id);

  Future<void> updateMemberPayment({
    required int id,
    required MessMemberPaymentStatus paymentStatus,
    DateTime? paymentDate,
  });

  Future<void> recordPayment({
    required int id,
    required double amount,
    required DateTime date,
  });
}

class MembersRemoteDataSourceImpl implements MembersRemoteDataSource {
  final Client client;

  MembersRemoteDataSourceImpl(this.client);

  @override
  Future<List<MessMemberProfile>> getMembers() => _run(() => client.mess.members());

  @override
  Future<void> deleteMember(int id) =>
      _run(() => client.mess.removeMember(memberId: id));

  @override
  Future<void> updateMemberPayment({
    required int id,
    required MessMemberPaymentStatus paymentStatus,
    DateTime? paymentDate,
  }) => _run(
    () => client.mess.updateMemberPayment(
      memberId: id,
      paymentStatus: paymentStatus,
      paymentDate: paymentDate,
    ),
  );

  @override
  Future<void> recordPayment({
    required int id,
    required double amount,
    required DateTime date,
  }) => _run(() => client.payment.addPayment(memberId: id, amount: amount, date: date));

  /// Translates the server's typed exceptions into this app's own exception
  /// types so `guard()` (core/error/result.dart) maps them to a [Failure]
  /// the same way every other repository does.
  Future<T> _run<T>(Future<T> Function() action) async {
    try {
      return await action();
    } on MessMemberNotFoundException {
      throw const NotFoundException('Member not found.');
    } on NotMessManagerException {
      throw const UnauthenticatedException(
        'Only the mess manager can do that.',
      );
    } on ServerpodClientException catch (e) {
      throw NetworkException('Could not reach the server (${e.statusCode}).');
    }
  }
}
