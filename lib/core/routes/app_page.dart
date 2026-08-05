// lib/core/routes/app_router.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mass_management/core/di/service_locator.dart';
import 'package:mass_management/core/routes/app_route.dart';
import 'package:mass_management/features/auth/presentation/pages/sign_in.dart';
import 'package:mass_management/features/auth/presentation/pages/sign_up.dart' show SignupPage;
import 'package:mass_management/features/dashboard/presentation/pages/meal_list.dart' show MealDetailsPage;
import 'package:mass_management/features/dashboard/presentation/pages/monthly_summary.dart';
import 'package:mass_management/features/dashboard/presentation/pages/my_wallet.dart';
import 'package:mass_management/features/main/home.dart' show ZoomDrawerExample;
import 'package:mass_management/features/main/main.dart';
import 'package:mass_management/features/manager/presentation/cubit/add_expense_cubit.dart';
import 'package:mass_management/features/manager/presentation/cubit/add_meal_cubit.dart';
import 'package:mass_management/features/manager/presentation/cubit/add_share_expense_cubit.dart';
import 'package:mass_management/features/manager/presentation/cubit/expense_list_cubit.dart';
import 'package:mass_management/features/manager/presentation/pages/add_expense.dart';
import 'package:mass_management/features/manager/presentation/pages/add_meal.dart' show AddMeal;
import 'package:mass_management/features/manager/presentation/pages/add_share_expense.dart';
import 'package:mass_management/features/manager/presentation/pages/expense_list.dart' show ExpenseListScreen;
import 'package:mass_management/features/splash/presentation/cubit/splash_cubit.dart';
import 'package:mass_management/features/splash/presentation/pages/splash_screen.dart';

// Global router instance (kept alive for hot reload)
final GoRouter appRouter = GoRouter(
  initialLocation: '/splash',
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
      path: '/sign_in',
      name: AppRoute.login,
      builder: (_, __) => SignInScreen(),
    ),
    GoRoute(
      path: '/dashboard_screen',
      name: AppRoute.dashboard,
      builder: (_, __) => const MainNavScreen(),
    ),
    GoRoute(
      path: '/add_meal_screen',
      name: AppRoute.addExpense,
      builder: (_, __) => BlocProvider(
        create: (_) => sl<AddExpenseCubit>(),
        child: AddExpenseScreen(),
      ),
    ),
    GoRoute(
      path: '/entry_meal_screen',
      name: AppRoute.addMeal,
      builder: (_, __) => BlocProvider(
        create: (_) => sl<AddMealCubit>(),
        child: AddMeal(),
      ),
    ),
    GoRoute(
      path: '/add_share_expense_screen',
      name: AppRoute.addShareExpense,
      builder: (_, __) => BlocProvider(
        create: (_) => sl<AddShareExpenseCubit>(),
        child: AddShareExpenseScreen(),
      ),
    ),
    GoRoute(
      path: '/expense_screen_list',
      name: AppRoute.expenseList,
      builder: (_, __) => BlocProvider(
        create: (_) => sl<ExpenseListCubit>(),
        child: ExpenseListScreen(),
      ),
    ),
    GoRoute(
      path: '/signup_screen',
      name: AppRoute.signUp,
      builder: (_, __) => SignupPage(),
    ),
    GoRoute(
      path: '/my_wallet',
      name: AppRoute.myWallet,
      builder: (_, __) => WalletScreen(),
    ),
    GoRoute(
      path: '/monthly_summary',
      name: AppRoute.monthlySummary,
      builder: (_, __) => MonthlySummary(),
    ),
    GoRoute(
      path: '/menu_screen',
      name: AppRoute.menuScreen,
      builder: (_, __) => const ZoomDrawerExample(),
    ),
    GoRoute(
      path: '/meal_list',
      name: AppRoute.mealList,
      builder: (_, __) => MealDetailsPage(),
    ),
  ],
);
