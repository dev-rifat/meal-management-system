// Manual/optional integration check — lives in dev_scripts/ (not test/)
// specifically so plain `flutter test` never picks it up; it needs the
// real dev server (see mess_manager_server/) running against Postgres, and
// assumes its stdout was redirected to /tmp/serverpod_run10.log (adjust
// _serverLogPath below if you started it differently). Run explicitly with:
//   flutter test dev_scripts/auth_mess_flow_test.dart
// Verifies the actual production repository/DI wiring (not just the server
// itself) — register, verify, finish, create a mess, refresh session.
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mass_management/core/di/service_locator.dart';
import 'package:mass_management/features/auth/domain/repositories/auth_repository.dart';
import 'package:mass_management/features/mess/domain/repositories/mess_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _serverLogPath = '/tmp/serverpod_run10.log';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  // flutter_test blocks real HTTP by default (a hermeticity guard) — this
  // test's whole point is hitting the real dev server, so opt back out.
  HttpOverrides.global = null;

  test('register, verify, finish, create a mess — via the real DI-wired repositories', () async {
    SharedPreferences.setMockInitialValues({});
    setupServiceLocator();
    final authRepository = sl<AuthRepository>();
    final messRepository = sl<MessRepository>();

    final email = 'integration+${DateTime.now().millisecondsSinceEpoch}@example.com';
    const password = 'Integration-test-pass-123!';

    final startResult = await authRepository.startRegistration(email: email);
    final accountRequestId = startResult.fold((f) => fail('start failed: ${f.message}'), (id) => id);

    final log = File(_serverLogPath).readAsLinesSync();
    final code = log
        .lastWhere((l) => l.contains('[EmailIdp] Registration code'))
        .split(':')
        .last
        .trim();

    final verifyResult = await authRepository.verifyRegistrationCode(
      accountRequestId: accountRequestId,
      code: code,
    );
    final registrationToken = verifyResult.fold(
      (f) => fail('verify failed: ${f.message}'),
      (token) => token,
    );

    final finishResult = await authRepository.finishRegistration(
      registrationToken: registrationToken,
      password: password,
      fullName: 'Integration Test User',
    );
    final user = finishResult.fold(
      (f) => fail('finishRegistration failed: ${f.message}'),
      (u) => u,
    );
    expect(user.email, email);
    expect(user.name, 'Integration Test User');
    expect(user.messId, isNull);

    final createResult = await messRepository.createMess(
      name: 'Integration Test Mess',
      phone: '01700000099',
    );
    final mess = createResult.fold(
      (f) => fail('createMess failed: ${f.message}'),
      (m) => m,
    );
    expect(mess.name, 'Integration Test Mess');
    expect(mess.inviteCode, hasLength(6));

    final sessionResult = await authRepository.getCurrentSession();
    final refreshed = sessionResult.fold(
      (f) => fail('getCurrentSession failed: ${f.message}'),
      (u) => u,
    );
    expect(refreshed, isNotNull);
    expect(refreshed!.messId, mess.id);

    final logoutResult = await authRepository.logout();
    logoutResult.fold((f) => fail('logout failed: ${f.message}'), (_) {});
    final afterLogout = await authRepository.getCurrentSession();
    afterLogout.fold((f) => fail('getCurrentSession failed: ${f.message}'), (u) => expect(u, isNull));
  });
}
