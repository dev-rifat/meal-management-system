// Manual/optional integration check — see auth_mess_flow_test.dart's header
// comment for the how/why (dev_scripts/, real server, HttpOverrides.global
// = null). Verifies the members feature's real DI-wired repository:
// manager sees both members, non-manager update/delete is rejected,
// manager update/delete both succeed.
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mass_management/core/di/service_locator.dart';
import 'package:mass_management/features/auth/domain/repositories/auth_repository.dart';
import 'package:mass_management/features/members/domain/entities/member.dart';
import 'package:mass_management/features/members/domain/repositories/members_repository.dart';
import 'package:mass_management/features/mess/domain/repositories/mess_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _serverLogPath = '/tmp/serverpod_run4.log';

class _Account {
  final String email;
  final String password;
  const _Account(this.email, this.password);
}

Future<_Account> _register(
  AuthRepository authRepository,
  String emailPrefix,
  String fullName,
) async {
  final email =
      '$emailPrefix+${DateTime.now().millisecondsSinceEpoch}@example.com';
  const password = 'Members-flow-pass-123!';

  final accountRequestId = (await authRepository.startRegistration(
    email: email,
  )).fold((f) => throw StateError('start failed: ${f.message}'), (id) => id);

  final log = File(_serverLogPath).readAsLinesSync();
  final code = log
      .lastWhere((l) => l.contains('[EmailIdp] Registration code ($email)'))
      .split(':')
      .last
      .trim();

  final registrationToken = (await authRepository.verifyRegistrationCode(
    accountRequestId: accountRequestId,
    code: code,
  )).fold((f) => throw StateError('verify failed: ${f.message}'), (t) => t);

  (await authRepository.finishRegistration(
    registrationToken: registrationToken,
    password: password,
    fullName: fullName,
  )).fold((f) => throw StateError('finish failed: ${f.message}'), (u) => u);

  return _Account(email, password);
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = null;

  test('manager sees members, updates payment, removes a member', () async {
    SharedPreferences.setMockInitialValues({});
    setupServiceLocator();
    final authRepository = sl<AuthRepository>();
    final messRepository = sl<MessRepository>();
    final membersRepository = sl<MembersRepository>();

    final manager = await _register(
      authRepository,
      'flow-manager',
      'Flow Manager',
    );
    final mess = (await messRepository.createMess(
      name: 'Members Flow Mess',
      phone: '01733333333',
    )).fold((f) => throw StateError('createMess failed: ${f.message}'), (m) => m);
    print('Manager created mess ${mess.name} (${mess.inviteCode})');

    await authRepository.logout();
    await _register(authRepository, 'flow-member', 'Flow Member');
    (await messRepository.joinMess(
      inviteCode: mess.inviteCode,
      phone: '01744444444',
    )).fold((f) => throw StateError('joinMess failed: ${f.message}'), (m) => m);
    print('Second account joined the mess');

    final asMemberList = (await membersRepository.getMembers()).fold(
      (f) => throw StateError('getMembers failed: ${f.message}'),
      (m) => m,
    );
    expect(asMemberList.length, 2);
    final managerRow = asMemberList.firstWhere((m) => m.name == 'Flow Manager');
    final deleteAsNonManager = await membersRepository.deleteMember(
      managerRow.id,
    );
    expect(deleteAsNonManager.isSuccess, isFalse);
    print('Non-manager delete correctly rejected');
    final memberRow = asMemberList.firstWhere((m) => m.name == 'Flow Member');

    // Switch back to the manager session.
    await authRepository.logout();
    (await authRepository.login(
      email: manager.email,
      password: manager.password,
    )).fold((f) => throw StateError('login failed: ${f.message}'), (u) => u);

    final updateResult = await membersRepository.updateMemberPayment(
      id: memberRow.id,
      paymentStatus: MemberPaymentStatus.clear,
      paymentDate: DateTime.now(),
    );
    expect(updateResult.isSuccess, isTrue);
    final afterUpdate = (await membersRepository.getMembers()).fold(
      (f) => throw StateError('getMembers failed: ${f.message}'),
      (m) => m,
    );
    final updatedRow = afterUpdate.firstWhere((m) => m.id == memberRow.id);
    expect(updatedRow.paymentStatus, MemberPaymentStatus.clear);
    expect(updatedRow.paymentDate, isNotNull);
    print('Manager update succeeded: ${updatedRow.paymentStatus}');

    final deleteResult = await membersRepository.deleteMember(memberRow.id);
    expect(deleteResult.isSuccess, isTrue);
    final afterDelete = (await membersRepository.getMembers()).fold(
      (f) => throw StateError('getMembers failed: ${f.message}'),
      (m) => m,
    );
    expect(afterDelete.length, 1);
    print('Manager delete succeeded — ${afterDelete.length} member left');

    print('\nMEMBERS FLOW TEST PASSED');
  });
}
