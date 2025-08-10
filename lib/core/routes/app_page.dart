// lib/core/routes/app_router.dart
import 'package:go_router/go_router.dart';
import 'package:mass_management/core/routes/app_route.dart';
import 'package:mass_management/features/auth/presentation/pages/sign_in.dart';
import 'package:mass_management/features/deashboard/pages/dashboard_screen.dart';
import 'package:mass_management/features/main/main.dart';
import 'package:mass_management/features/maneger/pages/add_expense.dart';
import 'package:mass_management/features/maneger/pages/add_meal.dart' show AddMeal;
import 'package:mass_management/features/maneger/pages/add_share_expense.dart';
import 'package:mass_management/features/starting/view/splash_screen.dart';

import '../../features/maneger/pages/epense_list.dart' show ExpenseListScreen;

// Global router instance (kept alive for hot reload)
final GoRouter appRouter = GoRouter(
  initialLocation: '/splash',
  routes: [
    GoRoute(
      path: '/splash',
      name: AppRoute.splash,
      builder: (_, __) => const SplashScreen(),
    ),
    GoRoute(
      path: '/sign_in',
      name: AppRoute.login,
      builder: (_, __) =>  SignInScreen(),
    ),
    GoRoute(
      path: '/deashboard_screen',
      name: AppRoute.deashboard,
      builder: (_, __) => const MainNavScreen(),
    ),
    GoRoute(
      path: '/add_meal_screen',
      name: AppRoute.addExpense,
      builder: (_, __) =>  AddExpenseScreen(),
    ),
    GoRoute(
      path: '/entry_meal_screen',
      name: AppRoute.addMeal,
      builder: (_, __) =>  AddMeal(),
    ), GoRoute(
      path: '/add_share_expense_screen',
      name: AppRoute.addShareExpense,
      builder: (_, __) =>  AddShareExpenseScreen(),
    ),GoRoute(
      path: '/expense_screen_list',
      name: AppRoute.expenseList,
      builder: (_, __) =>  ExpenseListScreen(),
    ),
  ],
);
