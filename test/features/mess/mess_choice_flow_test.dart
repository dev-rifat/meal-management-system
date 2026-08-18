// End-to-end drive of the pre-signup mess-choice flow through the real
// app (real DI, real in-memory data sources, real router) — not mocks —
// covering: tapping "Register Account" opens a create/join picker sheet
// *before* the sign-up form, choosing "Create" shows the invite code and
// the resulting account lands straight on the dashboard (already attached
// to its mess), and choosing "Join" with a bad code surfaces an error
// instead of crashing.

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mass_management/core/di/service_locator.dart';
import 'package:mass_management/core/routes/app_page.dart' show buildAppRouter;
import 'package:mass_management/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:mass_management/features/auth/presentation/bloc/auth_event.dart';
import 'package:mass_management/features/auth/presentation/pages/sign_up.dart'
    show SignupPage;
import 'package:mass_management/main.dart';

void main() {
  testWidgets(
    'Register Account opens a picker before sign-up; create reaches the '
    'dashboard directly; join surfaces an error for a bad code',
    (tester) async {
      setupServiceLocator();
      final authBloc = sl<AuthBloc>();

      await tester.pumpWidget(
        MyApp(authBloc: authBloc, appRouter: buildAppRouter(authBloc)),
      );
      await tester.pump();

      // Splash holds for a branding delay, then (unauthenticated) pushes login.
      await tester.pump(const Duration(seconds: 5));
      await tester.pumpAndSettle();
      expect(find.text('Login'), findsOneWidget);

      // Tapping "Register Account" opens the picker sheet — no sign-up
      // form yet.
      _tapRichTextSpan(tester, 'Register Account');
      await tester.pumpAndSettle();
      expect(find.text('How will you use Mess Manager?'), findsOneWidget);
      expect(find.text('Signup'), findsNothing);

      // Create a mess from the picker. Scoped by key: SignInScreen is still
      // mounted underneath the sheet (it's a modal, not a route replace),
      // so a bare TextFormField finder would also match its own email/
      // password fields.
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

      // Picker resolved -> now on the sign-up form (not the dashboard yet).
      expect(find.text('Signup'), findsOneWidget);
      expect(find.text('Welcome'), findsNothing);

      await _fillAndSubmitSignUp(
        tester,
        email: 'alice@example.com',
        username: 'alice',
      );

      // The account was created already attached to its mess -> straight
      // to the dashboard, no further gate/sheet.
      for (var i = 0; i < 10; i++) {
        await tester.pump(const Duration(milliseconds: 100));
      }
      expect(find.text('Welcome'), findsOneWidget);

      // --- Second user: exercise "Join a Mess" with a bogus code ---
      authBloc.add(const LogoutRequested());
      for (var i = 0; i < 10; i++) {
        await tester.pump(const Duration(milliseconds: 100));
      }
      expect(find.text('Login'), findsOneWidget);

      _tapRichTextSpan(tester, 'Register Account');
      await tester.pumpAndSettle();
      expect(find.text('How will you use Mess Manager?'), findsOneWidget);

      await tester.tap(find.text('Join a Mess'));
      await tester.pump();
      await tester.enterText(
        find.byKey(const ValueKey('invite-code')),
        'BOGUS1',
      );
      await tester.tap(find.text('Join Mess'));
      await tester.pumpAndSettle();

      // Error surfaces (as a SnackBar) and the picker stays open — no
      // crash, no navigation to sign-up.
      expect(
        find.text('No mess found for this invite code.'),
        findsOneWidget,
      );
      expect(find.text('How will you use Mess Manager?'), findsOneWidget);
      expect(find.text('Signup'), findsNothing);
    },
  );
}

/// Fills the sign-up form and submits it.
Future<void> _fillAndSubmitSignUp(
  WidgetTester tester, {
  required String email,
  required String username,
}) async {
  // Scoped to SignupPage: SignInScreen is still mounted underneath (it
  // pushed, not replaced), so a bare TextFormField finder would also
  // match its own email/password fields.
  // Order matches _buildUserForm: email, username, phone, dob (optional,
  // left blank), password, confirm password.
  final fields = find.descendant(
    of: find.byType(SignupPage),
    matching: find.byType(TextFormField),
  );
  expect(fields, findsNWidgets(6));
  await tester.enterText(fields.at(0), email);
  await tester.enterText(fields.at(1), username);
  await tester.enterText(fields.at(2), '01700000000');
  await tester.enterText(fields.at(4), 'password123');
  await tester.enterText(fields.at(5), 'password123');
  // The form is taller than the viewport — scroll the submit button into
  // view before tapping it. Not pumpAndSettle: SignInScreen is still
  // mounted underneath this pushed route, and something in that
  // still-mounted tree animates continuously, which would never satisfy
  // pumpAndSettle's "no more frames" condition.
  await tester.ensureVisible(find.text('Sign Up'));
  for (var i = 0; i < 10; i++) {
    await tester.pump(const Duration(milliseconds: 100));
  }
  await tester.tap(find.text('Sign Up'));
  for (var i = 0; i < 10; i++) {
    await tester.pump(const Duration(milliseconds: 100));
  }
}

/// Finds a [RichText] containing [text] and invokes the [TapGestureRecognizer]
/// on the matching span directly — `find.text()` can't hit-test a bare
/// [RichText]'s embedded [TextSpan] the way it can a [Text] widget.
void _tapRichTextSpan(WidgetTester tester, String text) {
  final richText = tester.widget<RichText>(
    find.byWidgetPredicate(
      (widget) => widget is RichText && widget.text.toPlainText().contains(text),
    ),
  );

  void visit(InlineSpan span) {
    if (span is TextSpan) {
      if (span.text == text && span.recognizer is TapGestureRecognizer) {
        (span.recognizer as TapGestureRecognizer).onTap?.call();
      }
      span.children?.forEach(visit);
    }
  }

  visit(richText.text);
}
