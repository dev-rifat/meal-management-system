// Manual/optional integration check — see auth_mess_flow_test.dart's header
// comment for the how/why. Verifies the real Flutter repository layer for
// expenses: manager records a market expense and a shared expense (with a
// brand-new bill type), bill-type reuse doesn't create a duplicate, a
// non-manager can read but not write, and getExpenseSummary()'s math lines
// up with the real rows.
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mass_management/core/di/service_locator.dart';
import 'package:mass_management/core/error/result.dart';
import 'package:mass_management/features/auth/domain/repositories/auth_repository.dart';
import 'package:mass_management/features/manager/domain/entities/expense.dart';
import 'package:mass_management/features/manager/domain/repositories/manager_repository.dart';
import 'package:mass_management/features/members/domain/repositories/members_repository.dart';
import 'package:mass_management/features/mess/domain/repositories/mess_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _serverLogPath = '/tmp/serverpod_run8.log';

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
  const password = 'Expenses-flow-pass-123!';

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

  test('manager records market/shared expenses; summary and access rules hold', () async {
    SharedPreferences.setMockInitialValues({});
    setupServiceLocator();
    final authRepository = sl<AuthRepository>();
    final messRepository = sl<MessRepository>();
    final membersRepository = sl<MembersRepository>();
    final managerRepository = sl<ManagerRepository>();

    final manager = await _register(authRepository, 'expenses-manager', 'Expenses Manager');
    final mess = (await messRepository.createMess(
      name: 'Expenses Flow Mess',
      phone: '01777777777',
    )).fold((f) => throw StateError('createMess failed: ${f.message}'), (m) => m);
    print('Manager created mess ${mess.name} (${mess.inviteCode})');

    await authRepository.logout();
    final member = await _register(authRepository, 'expenses-member', 'Expenses Member');
    (await messRepository.joinMess(
      inviteCode: mess.inviteCode,
      phone: '01788888888',
    )).fold((f) => throw StateError('joinMess failed: ${f.message}'), (m) => m);
    print('Second account joined the mess');

    await authRepository.logout();
    (await authRepository.login(email: manager.email, password: manager.password))
        .fold((f) => throw StateError('login failed: ${f.message}'), (u) => u);

    final members = (await membersRepository.getMembers())
        .fold((f) => throw StateError('getMembers failed: ${f.message}'), (m) => m);
    expect(members.length, 2);
    final managerMember = members.firstWhere((m) => m.name == 'Expenses Manager');

    final date = DateTime.now();

    // Market expense.
    final market = (await managerRepository.addExpense(
      title: 'Rice & Vegetables',
      amount: 1500,
      date: date,
      details: 'Weekly groceries',
      spentByMemberId: managerMember.id,
    )).fold((f) => throw StateError('addExpense failed: ${f.message}'), (e) => e);
    expect(market.type, ExpenseType.market);
    expect(market.spentBy, 'Expenses Manager');
    print('Market expense recorded: ${market.title} (${market.amount})');

    // Shared expense with a brand-new bill type.
    final shared1 = (await managerRepository.addSharedExpense(
      title: 'Wifi Bill',
      amount: 1000,
      date: date,
      details: 'Monthly internet',
      spentByMemberId: managerMember.id,
      billType: 'Internet',
    )).fold((f) => throw StateError('addSharedExpense failed: ${f.message}'), (e) => e);
    expect(shared1.type, ExpenseType.share);
    expect(shared1.billType, 'Internet');
    print('Shared expense recorded with new bill type: ${shared1.billType}');

    // Reusing the same bill type name should not create a duplicate.
    (await managerRepository.addSharedExpense(
      title: 'Wifi Bill (top-up)',
      amount: 200,
      date: date,
      details: 'Extra data',
      spentByMemberId: managerMember.id,
      billType: 'Internet',
    )).fold((f) => throw StateError('addSharedExpense failed: ${f.message}'), (e) => e);
    final billTypes = (await managerRepository.getBillTypes())
        .fold((f) => throw StateError('getBillTypes failed: ${f.message}'), (b) => b);
    expect(billTypes.where((b) => b == 'Internet').length, 1);
    print('Bill type reuse confirmed — no duplicate "Internet" entry');

    // Summary math.
    final summary = (await managerRepository.getExpenseSummary())
        .fold((f) => throw StateError('getExpenseSummary failed: ${f.message}'), (s) => s);
    expect(summary.membersCount, 2);
    expect(summary.totalCost, closeTo(1500 + 1000 + 200, 0.001));
    print('Summary: members=${summary.membersCount} totalCost=${summary.totalCost} '
        'food%=${summary.foodExpensePercentage.toStringAsFixed(1)} '
        'share%=${summary.sharedExpensePercentage.toStringAsFixed(1)}');

    // A non-manager can read expenses...
    await authRepository.logout();
    (await authRepository.login(email: member.email, password: member.password))
        .fold((f) => throw StateError('login failed: ${f.message}'), (u) => u);
    final expensesAsMember = (await managerRepository.getExpenses())
        .fold((f) => throw StateError('getExpenses failed: ${f.message}'), (e) => e);
    expect(expensesAsMember.length, 3);
    print('Non-manager can read all ${expensesAsMember.length} expenses');

    // ...but cannot write.
    final blocked = await managerRepository.addExpense(
      title: 'Should be blocked',
      amount: 10,
      date: date,
      details: 'n/a',
      spentByMemberId: managerMember.id,
    );
    expect(blocked, isA<ResultError<Expense>>());
    print('Non-manager write correctly rejected');

    // Query/type filtering.
    final marketOnly = (await managerRepository.getExpenses(filter: ExpenseType.market))
        .fold((f) => throw StateError('getExpenses failed: ${f.message}'), (e) => e);
    expect(marketOnly.length, 1);
    final queried = (await managerRepository.getExpenses(query: 'wifi'))
        .fold((f) => throw StateError('getExpenses failed: ${f.message}'), (e) => e);
    expect(queried.length, 2);
    print('Type filter and query search both correct');

    print('\nEXPENSES FLOW TEST PASSED');
  });
}
