// End-to-end drive of the mess-choice-first onboarding flow through the
// real app (real DI, real in-memory data sources, real router) — not
// mocks — covering: an unauthenticated session lands on the welcome
// screen (not sign-in), "Create a Mess" opens a create-only sheet (no
// toggle) followed by the invite-code dialog and the account-details
// sheet, and the resulting account lands straight on the dashboard
// (already attached to its mess). Also covers "Join with a Pass Code"
// surfacing an error for a bad code instead of crashing.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mass_management/core/di/service_locator.dart';
import 'package:mass_management/core/routes/app_page.dart' show buildAppRouter;
import 'package:mass_management/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:mass_management/features/auth/presentation/bloc/auth_event.dart';
import 'package:mass_management/features/auth/presentation/widgets/user_info_sheet.dart'
    show UserInfoSheet;
import 'package:mass_management/main.dart';

void main() {
  testWidgets(
    '"Create a Mess" walks through the create sheet, invite dialog and '
    'account-details sheet straight to the dashboard; "Join with a Pass '
    'Code" surfaces an error for a bad code',
    (tester) async {
      setupServiceLocator();
      final authBloc = sl<AuthBloc>();

      await tester.pumpWidget(
        MyApp(authBloc: authBloc, appRouter: buildAppRouter(authBloc)),
      );
      await tester.pump();

      // Splash holds for a branding delay, then (unauthenticated) pushes
      // the welcome screen — not sign-in.
      await tester.pump(const Duration(seconds: 5));
      await tester.pumpAndSettle();
      expect(find.text('Create a Mess'), findsOneWidget);
      expect(find.text('Login'), findsNothing);

      // Tapping "Create a Mess" opens a create-only sheet — no toggle, no
      // account-detail fields yet.
      await tester.tap(find.text('Create a Mess'));
      await tester.pumpAndSettle();
      expect(find.text('Create a new mess'), findsOneWidget);
      expect(find.text('How will you use Mess Manager?'), findsNothing);

      await tester.enterText(
        find.byKey(const ValueKey('mess-name')),
        'Sunshine Mess',
      );
      await tester.tap(find.text('Create Mess'));
      await tester.pumpAndSettle();

      expect(
        find.text('Share this invite code with your members:'),
        findsOneWidget,
      );
      await tester.tap(find.text('Continue'));
      await tester.pumpAndSettle();

      // Picker resolved -> now on the account-details sheet.
      expect(find.text('Almost there — set up your account'), findsOneWidget);

      await _fillAndSubmitUserInfo(
        tester,
        name: 'alice',
        email: 'alice@example.com',
      );

      // The account was created already attached to its mess -> straight
      // to the dashboard, no further gate/sheet.
      for (var i = 0; i < 10; i++) {
        await tester.pump(const Duration(milliseconds: 100));
      }
      expect(find.text('Welcome'), findsOneWidget);

      // --- Second user: exercise "Join with a Pass Code" with a bogus code ---
      authBloc.add(const LogoutRequested());
      for (var i = 0; i < 10; i++) {
        await tester.pump(const Duration(milliseconds: 100));
      }
      expect(find.text('Create a Mess'), findsOneWidget);

      await tester.tap(find.text('Join with a Pass Code'));
      await tester.pumpAndSettle();
      expect(find.text('Join with a pass code'), findsOneWidget);

      await tester.enterText(
        find.byKey(const ValueKey('invite-code')),
        'BOGUS1',
      );
      await tester.tap(find.text('Join Mess'));
      await tester.pumpAndSettle();

      // Error surfaces (as a SnackBar) and the sheet stays open — no
      // crash, no navigation to the account-details sheet.
      expect(
        find.text('No mess found for this invite code.'),
        findsOneWidget,
      );
      expect(find.text('Join with a pass code'), findsOneWidget);
      expect(find.text('Almost there — join as a member'), findsNothing);
    },
  );
}

/// Fills the account-details sheet and submits it.
Future<void> _fillAndSubmitUserInfo(
  WidgetTester tester, {
  required String name,
  required String email,
}) async {
  // Scoped to UserInfoSheet: order matches its build method — name, email,
  // phone, password, confirm password.
  final fields = find.descendant(
    of: find.byType(UserInfoSheet),
    matching: find.byType(TextFormField),
  );
  expect(fields, findsNWidgets(5));
  await tester.enterText(fields.at(0), name);
  await tester.enterText(fields.at(1), email);
  await tester.enterText(fields.at(2), '01700000000');
  // Meets userPasswordField's strength policy: upper, lower, digit, symbol, 8+ chars.
  await tester.enterText(fields.at(3), 'Password123!');
  await tester.enterText(fields.at(4), 'Password123!');
  await tester.ensureVisible(find.text('Create account'));
  for (var i = 0; i < 10; i++) {
    await tester.pump(const Duration(milliseconds: 100));
  }
  await tester.tap(find.text('Create account'));
  for (var i = 0; i < 10; i++) {
    await tester.pump(const Duration(milliseconds: 100));
  }
}
