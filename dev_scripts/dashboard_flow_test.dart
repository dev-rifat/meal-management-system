// Manual/optional integration check — see auth_mess_flow_test.dart's header
// comment for the how/why. Verifies the real Flutter repository layer for
// the dashboard's financial aggregates: balance cards, wallet summary,
// transactions and monthly summary all come from real Payment/Expense/
// MealEntry rows via DashboardRepository, not mock data.
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mass_management/core/di/service_locator.dart';
import 'package:mass_management/features/auth/domain/repositories/auth_repository.dart';
import 'package:mass_management/features/dashboard/domain/entities/meal_record.dart';
import 'package:mass_management/features/dashboard/domain/repositories/dashboard_repository.dart';
import 'package:mass_management/features/manager/domain/repositories/manager_repository.dart';
import 'package:mass_management/features/members/domain/repositories/members_repository.dart';
import 'package:mass_management/features/mess/domain/repositories/mess_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _serverLogPath = '/tmp/serverpod_run9.log';

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
  const password = 'Dashboard-flow-pass-123!';

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

  test('dashboard balance/wallet/transactions/monthly-summary reflect real data', () async {
    SharedPreferences.setMockInitialValues({});
    setupServiceLocator();
    final authRepository = sl<AuthRepository>();
    final messRepository = sl<MessRepository>();
    final membersRepository = sl<MembersRepository>();
    final managerRepository = sl<ManagerRepository>();
    final dashboardRepository = sl<DashboardRepository>();

    final manager = await _register(authRepository, 'dash-manager', 'Dash Manager');
    final mess = (await messRepository.createMess(
      name: 'Dashboard Flow Mess',
      phone: '01799999991',
    )).fold((f) => throw StateError('createMess failed: ${f.message}'), (m) => m);
    print('Manager created mess ${mess.name} (${mess.inviteCode})');

    await authRepository.logout();
    await _register(authRepository, 'dash-member', 'Dash Member');
    (await messRepository.joinMess(
      inviteCode: mess.inviteCode,
      phone: '01799999992',
    )).fold((f) => throw StateError('joinMess failed: ${f.message}'), (m) => m);
    print('Second account joined the mess');

    await authRepository.logout();
    (await authRepository.login(email: manager.email, password: manager.password))
        .fold((f) => throw StateError('login failed: ${f.message}'), (u) => u);

    final members = (await membersRepository.getMembers())
        .fold((f) => throw StateError('getMembers failed: ${f.message}'), (m) => m);
    expect(members.length, 2);
    final managerMember = members.firstWhere((m) => m.name == 'Dash Manager');
    final otherMember = members.firstWhere((m) => m.name == 'Dash Member');

    final today = DateTime.now();
    final date = DateTime(today.year, today.month, today.day);

    // Meals for both, then approve everything.
    (await dashboardRepository.submitMeal(
      memberId: managerMember.id,
      date: date,
      mealCounts: {'breakfast': 1.0, 'lunch': 1.0, 'dinner': 1.0},
    )).fold((f) => throw StateError('submitMeal failed: ${f.message}'), (_) {});
    (await dashboardRepository.submitMeal(
      memberId: otherMember.id,
      date: date,
      mealCounts: {'breakfast': 1.0, 'lunch': 1.0, 'dinner': 1.0},
    )).fold((f) => throw StateError('submitMeal failed: ${f.message}'), (_) {});
    final records = (await dashboardRepository.getMealsForMonth(month: date))
        .fold((f) => throw StateError('getMealsForMonth failed: ${f.message}'), (r) => r);
    for (final r in records) {
      (await dashboardRepository.updateMealStatus(
        entryIds: r.entryIds,
        status: MealStatus.approved,
      )).fold((f) => throw StateError('updateMealStatus failed: ${f.message}'), (_) {});
    }
    print('Submitted and approved meals for both members');

    // Market expense (food cost) recorded by the manager.
    (await managerRepository.addExpense(
      title: 'Groceries',
      amount: 1200,
      date: date,
      details: 'Weekly shop',
      spentByMemberId: managerMember.id,
    )).fold((f) => throw StateError('addExpense failed: ${f.message}'), (_) {});
    print('Recorded market expense');

    // Deposits for both members.
    (await membersRepository.recordPayment(id: managerMember.id, amount: 3000, date: date))
        .fold((f) => throw StateError('recordPayment failed: ${f.message}'), (_) {});
    (await membersRepository.recordPayment(id: otherMember.id, amount: 1500, date: date))
        .fold((f) => throw StateError('recordPayment failed: ${f.message}'), (_) {});
    print('Recorded deposits for both members');

    // Balance cards: [0] mess-wide this month, [1] manager's own personal balance.
    final balances = (await dashboardRepository.getBalanceSummaries())
        .fold((f) => throw StateError('getBalanceSummaries failed: ${f.message}'), (b) => b);
    expect(balances.length, 2);
    expect(balances[0].deposit, closeTo(4500, 0.001));
    expect(balances[0].expense, closeTo(1200, 0.001));
    expect(balances[1].deposit, closeTo(3000, 0.001));
    expect(balances[1].expense, closeTo(1200, 0.001));
    expect(balances[1].balance, closeTo(1800, 0.001));
    print('Balance cards correct: mess deposit=${balances[0].deposit} expense=${balances[0].expense}; '
        'personal balance=${balances[1].balance}');

    // Wallet summary mirrors the manager's own personal figures + mesh-wide meal rate.
    final wallet = (await dashboardRepository.getWalletSummary())
        .fold((f) => throw StateError('getWalletSummary failed: ${f.message}'), (w) => w);
    expect(wallet.balance, closeTo(1800, 0.001));
    expect(wallet.mealRate, closeTo(200, 0.001)); // 1200 / 6 approved meals
    print('Wallet summary correct: balance=${wallet.balance} mealRate=${wallet.mealRate}');

    // Manager's own transactions: 1 deposit + 1 market expense.
    final transactions = (await dashboardRepository.getTransactions())
        .fold((f) => throw StateError('getTransactions failed: ${f.message}'), (t) => t);
    expect(transactions.length, 2);
    expect(transactions.any((t) => t.title == 'Deposit' && t.amount == 3000), true);
    expect(transactions.any((t) => t.title == 'Groceries' && t.amount == 1200), true);
    print('Transactions correct: ${transactions.map((t) => '${t.title}:${t.amount}').join(', ')}');

    // Monthly summary: mess-wide totalCost/totalMeal, manager's own row.
    final monthly = (await dashboardRepository.getMonthlySummary())
        .fold((f) => throw StateError('getMonthlySummary failed: ${f.message}'), (m) => m);
    expect(monthly.totalCost, closeTo(1200, 0.001));
    expect(monthly.totalMeal, closeTo(6, 0.001));
    final managerRow = monthly.members.firstWhere((m) => m.name == 'Dash Manager');
    expect(managerRow.totalMeal, closeTo(3, 0.001));
    expect(managerRow.paid, closeTo(3000, 0.001));
    expect(managerRow.totalCost, closeTo(3 * wallet.mealRate!, 0.001));
    print('Monthly summary correct: totalCost=${monthly.totalCost} totalMeal=${monthly.totalMeal}');

    print('\nDASHBOARD FLOW TEST PASSED');
  });
}
