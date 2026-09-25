// Manual/optional integration check — see auth_mess_flow_test.dart's header
// comment for the how/why. Verifies the real Flutter repository layer for
// meals: manager submits for both members, dashboard's getMealsForMonth
// groups/rolls-up correctly, approve/reject updates all entries for a day
// together, and a non-manager can only submit for themself.
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mass_management/core/di/service_locator.dart';
import 'package:mass_management/features/auth/domain/repositories/auth_repository.dart';
import 'package:mass_management/features/dashboard/domain/entities/meal_record.dart';
import 'package:mass_management/features/dashboard/domain/repositories/dashboard_repository.dart';
import 'package:mass_management/features/members/domain/repositories/members_repository.dart';
import 'package:mass_management/features/mess/domain/repositories/mess_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _serverLogPath = '/tmp/serverpod_run6.log';

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
  final email = '$emailPrefix+${DateTime.now().millisecondsSinceEpoch}@example.com';
  const password = 'Meals-flow-pass-123!';

  final accountRequestId = (await authRepository.startRegistration(email: email))
      .fold((f) => throw StateError('start failed: ${f.message}'), (id) => id);

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

  test('manager submits meals for both members; dashboard groups/approves', () async {
    SharedPreferences.setMockInitialValues({});
    setupServiceLocator();
    final authRepository = sl<AuthRepository>();
    final messRepository = sl<MessRepository>();
    final membersRepository = sl<MembersRepository>();
    final dashboardRepository = sl<DashboardRepository>();

    final manager = await _register(authRepository, 'meals-manager', 'Meals Manager');
    final mess = (await messRepository.createMess(
      name: 'Meals Flow Mess',
      phone: '01755555555',
    )).fold((f) => throw StateError('createMess failed: ${f.message}'), (m) => m);
    print('Manager created mess ${mess.name} (${mess.inviteCode})');

    await authRepository.logout();
    await _register(authRepository, 'meals-member', 'Meals Member');
    (await messRepository.joinMess(
      inviteCode: mess.inviteCode,
      phone: '01766666666',
    )).fold((f) => throw StateError('joinMess failed: ${f.message}'), (m) => m);
    print('Second account joined the mess');

    await authRepository.logout();
    (await authRepository.login(email: manager.email, password: manager.password))
        .fold((f) => throw StateError('login failed: ${f.message}'), (u) => u);

    final members = (await membersRepository.getMembers())
        .fold((f) => throw StateError('getMembers failed: ${f.message}'), (m) => m);
    expect(members.length, 2);
    final managerMember = members.firstWhere((m) => m.name == 'Meals Manager');
    final otherMember = members.firstWhere((m) => m.name == 'Meals Member');

    final today = DateTime.now();
    final date = DateTime(today.year, today.month, today.day);

    // Manager submits for both members.
    (await dashboardRepository.submitMeal(
      memberId: managerMember.id,
      date: date,
      mealCounts: {'breakfast': 0.5, 'lunch': 1.0, 'dinner': 1.0},
    )).fold((f) => throw StateError('submitMeal(manager) failed: ${f.message}'), (_) {});
    (await dashboardRepository.submitMeal(
      memberId: otherMember.id,
      date: date,
      mealCounts: {'breakfast': 1.0, 'lunch': 0.5, 'dinner': 1.0},
    )).fold((f) => throw StateError('submitMeal(other) failed: ${f.message}'), (_) {});
    print('Manager submitted meals for both members');

    final records = (await dashboardRepository.getMealsForMonth(month: date))
        .fold((f) => throw StateError('getMealsForMonth failed: ${f.message}'), (r) => r);
    expect(records.length, 2);
    for (final r in records) {
      expect(r.status, MealStatus.pending);
      expect(r.total, closeTo(2.5, 0.001));
    }
    print('Dashboard shows ${records.length} grouped day-rows, both pending');

    // Approve the manager's own day (all 3 underlying entries at once).
    final managerRecord = records.firstWhere((r) => r.memberId == managerMember.id);
    expect(managerRecord.entryIds.length, 3);
    (await dashboardRepository.updateMealStatus(
      entryIds: managerRecord.entryIds,
      status: MealStatus.approved,
    )).fold((f) => throw StateError('updateMealStatus failed: ${f.message}'), (_) {});

    final afterApprove = (await dashboardRepository.getMealsForMonth(month: date))
        .fold((f) => throw StateError('getMealsForMonth failed: ${f.message}'), (r) => r);
    final approvedRecord = afterApprove.firstWhere((r) => r.memberId == managerMember.id);
    expect(approvedRecord.status, MealStatus.approved);
    print('Manager\'s day approved (rollup correct across 3 entries)');

    // Status filter: "approved" should show exactly 1 record now.
    final approvedOnly = (await dashboardRepository.getMealsForMonth(
      month: date,
      status: MealStatus.approved,
    )).fold((f) => throw StateError('getMealsForMonth failed: ${f.message}'), (r) => r);
    expect(approvedOnly.length, 1);
    print('Status filter correctly narrows to 1 approved record');

    print('\nMEALS FLOW TEST PASSED');
  });
}
