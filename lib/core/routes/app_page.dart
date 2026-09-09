import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mass_management/core/di/service_locator.dart';
import 'package:mass_management/core/enums/user_role.dart';
import 'package:mass_management/core/routes/app_route.dart';
import 'package:mass_management/core/routes/go_router_refresh_stream.dart';
import 'package:mass_management/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:mass_management/features/auth/presentation/bloc/auth_state.dart';
import 'package:mass_management/features/auth/presentation/pages/mess_choice_gate.dart';
import 'package:mass_management/features/auth/presentation/pages/sign_in.dart';
import 'package:mass_management/features/auth/presentation/pages/welcome_screen.dart';
import 'package:mass_management/features/dashboard/presentation/pages/meal_list.dart'
    show MealDetailsPage;
import 'package:mass_management/features/dashboard/presentation/pages/monthly_summary.dart';
import 'package:mass_management/features/dashboard/presentation/pages/my_wallet.dart';
import 'package:mass_management/features/main/main.dart';
import 'package:mass_management/features/manager/presentation/cubit/add_expense_cubit.dart';
import 'package:mass_management/features/manager/presentation/cubit/add_meal_cubit.dart';
import 'package:mass_management/features/manager/presentation/cubit/add_share_expense_cubit.dart';
import 'package:mass_management/features/manager/presentation/cubit/expense_list_cubit.dart';
import 'package:mass_management/features/manager/presentation/pages/add_expense.dart';
import 'package:mass_management/features/manager/presentation/pages/add_meal.dart'
    show AddMeal;
import 'package:mass_management/features/manager/presentation/pages/add_share_expense.dart';
import 'package:mass_management/features/manager/presentation/pages/expense_list.dart'
    show ExpenseListScreen;
import 'package:mass_management/features/splash/presentation/cubit/splash_cubit.dart';
import 'package:mass_management/features/splash/presentation/pages/splash_screen.dart';

/// Routes a member is never allowed onto, even via deep link/direct
/// navigation — mirrors the manager-only tabs/actions hidden in the nav
/// shell, enforced here too as defense in depth.
const Set<String> _managerOnlyRoutes = {
  AppRoute.addExpense,
  AppRoute.addMeal,
  AppRoute.addShareExpense,
  AppRoute.expenseList,
  AppRoute.monthlySummary,
};

String? _authRedirect(AuthBloc authBloc, GoRouterState state) {
  final location = state.matchedLocation;
  if (location == AppRoute.splash) {
    return null; // SplashScreen owns its own transition
  }

  final authState = authBloc.state;
  final isAuthRoute = location == AppRoute.welcome || location == AppRoute.login;

  if (authState is AuthAuthenticated) {
    // No mess yet — force the create/join gate regardless of where they
    // were headed, until it's resolved.
    if (authState.user.messId == null) {
      return location == AppRoute.messChoice ? null : AppRoute.messChoice;
    }
    if (isAuthRoute || location == AppRoute.messChoice) {
      return AppRoute.dashboard;
    }
    final isMember = authState.user.role == UserRole.member;
    if (isMember && _managerOnlyRoutes.contains(location)) {
      return AppRoute.dashboard;
    }
    return null;
  }
  if (authState is AuthUnauthenticated) {
    return isAuthRoute ? null : AppRoute.welcome;
  }
  // AuthInitial/AuthLoading/AuthError: transitional, don't fight in-flight navigation.
  return null;
}

/// Builds the app's router bound to [authBloc] — the same instance provided
/// at the app root — so `redirect` always sees the live auth/role state.
GoRouter buildAppRouter(AuthBloc authBloc) => GoRouter(
  initialLocation: '/splash',
  refreshListenable: GoRouterRefreshStream(authBloc.stream),
  redirect: (context, state) => _authRedirect(authBloc, state),
  routes: [
    GoRoute(
      path: '/splash',
      name: AppRoute.splash,
      builder: (_, __) => BlocProvider(
        create: (_) => sl<SplashCubit>(),
        child: const SplashScreen(),
      ),
    ),
    GoRoute(
      path: '/welcome',
      name: AppRoute.welcome,
      builder: (_, __) => const WelcomeScreen(),
    ),
    GoRoute(
      path: '/sign_in',
      name: AppRoute.login,
      builder: (_, __) => const SignInScreen(),
    ),
    GoRoute(
      path: '/dashboard_screen',
      name: AppRoute.dashboard,
      // Keyed by role: without this, navigating here as one role and later
      // (after logout + a different-role login) navigating here again
      // reuses the same `const MainNavScreen()` State — including its
      // PersistentTabController, whose current tab index can then be out
      // of range for the new, shorter tab list and crash. A role-derived
      // key forces a fresh State (and controller) whenever role changes.
      builder: (context, __) {
        final authState = context.watch<AuthBloc>().state;
        final role = authState is AuthAuthenticated
            ? authState.user.role
            : UserRole.member;
        return MainNavScreen(key: ValueKey(role));
      },
    ),
    GoRoute(
      path: '/add_meal_screen',
      name: AppRoute.addExpense,
      builder: (_, __) => BlocProvider(
        create: (_) => sl<AddExpenseCubit>(),
        child: const AddExpenseScreen(),
      ),
    ),
    GoRoute(
      path: '/entry_meal_screen',
      name: AppRoute.addMeal,
      builder: (_, __) => BlocProvider(
        create: (_) => sl<AddMealCubit>(),
        child: const AddMeal(),
      ),
    ),
    GoRoute(
      path: '/add_share_expense_screen',
      name: AppRoute.addShareExpense,
      builder: (_, __) => BlocProvider(
        create: (_) => sl<AddShareExpenseCubit>(),
        child: const AddShareExpenseScreen(),
      ),
    ),
    GoRoute(
      path: '/expense_screen_list',
      name: AppRoute.expenseList,
      builder: (_, __) => BlocProvider(
        create: (_) => sl<ExpenseListCubit>(),
        child: const ExpenseListScreen(),
      ),
    ),
    GoRoute(
      path: '/mess_choice',
      name: AppRoute.messChoice,
      builder: (_, __) => const MessChoiceGate(),
    ),
    GoRoute(
      path: '/my_wallet',
      name: AppRoute.myWallet,
      builder: (_, __) => const WalletScreen(),
    ),
    GoRoute(
      path: '/monthly_summary',
      name: AppRoute.monthlySummary,
      builder: (_, __) => const MonthlySummary(),
    ),
    GoRoute(
      path: '/meal_list',
      name: AppRoute.mealList,
      builder: (_, __) => const MealDetailsPage(),
    ),
  ],
);
