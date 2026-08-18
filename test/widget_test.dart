// Smoke test: the app boots through DI + routing and shows the splash
// screen first, instead of the default (and unrelated) Flutter counter demo
// this file used to contain.

import 'package:flutter_test/flutter_test.dart';

import 'package:mass_management/core/di/service_locator.dart';
import 'package:mass_management/core/routes/app_page.dart' show buildAppRouter;
import 'package:mass_management/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:mass_management/main.dart';
import 'package:mass_management/core/constants/app_string.dart';

void main() {
  testWidgets('App boots and shows the splash screen first', (
    WidgetTester tester,
  ) async {
    setupServiceLocator();
    final authBloc = sl<AuthBloc>();

    await tester.pumpWidget(
      MyApp(authBloc: authBloc, appRouter: buildAppRouter(authBloc)),
    );
    await tester.pump();

    expect(find.text(AppString.appVersion), findsOneWidget);
  });
}
