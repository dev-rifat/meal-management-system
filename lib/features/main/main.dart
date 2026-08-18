import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:mass_management/core/di/service_locator.dart';
import 'package:mass_management/core/enums/user_role.dart';
import 'package:mass_management/core/theme/app_color.dart';
import 'package:mass_management/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:mass_management/features/auth/presentation/bloc/auth_state.dart';
import 'package:mass_management/features/dashboard/presentation/pages/dashboard_screen.dart';
import 'package:mass_management/features/manager/presentation/cubit/add_meal_cubit.dart';
import 'package:mass_management/features/manager/presentation/cubit/manager_summary_cubit.dart';
import 'package:mass_management/features/manager/presentation/pages/manager_screen.dart';
import 'package:mass_management/features/members/presentation/cubit/members_cubit.dart';
import 'package:mass_management/features/members/presentation/pages/member_list_page.dart';
import 'package:mass_management/features/profile/presentation/pages/profile.dart';

import '../manager/presentation/pages/add_meal.dart';

class MainNavScreen extends StatefulWidget {
  const MainNavScreen({super.key});

  @override
  State<MainNavScreen> createState() => _MainNavScreenState();
}

/// Pairs a tab's screen with its nav-bar item so the two can be built from
/// one role-filtered list instead of two hand-synced parallel lists (a real
/// bug risk once tabs became conditional per role).
class _TabSpec {
  final Widget screen;
  final PersistentBottomNavBarItem item;

  const _TabSpec(this.screen, this.item);
}

class _MainNavScreenState extends State<MainNavScreen> {
  late PersistentTabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = PersistentTabController(initialIndex: 0);
  }

  PersistentBottomNavBarItem _navItem(IconData icon, String title) {
    return PersistentBottomNavBarItem(
      icon: Icon(icon),
      title: title,
      activeColorPrimary: AppColor.primaryColor,
      activeColorSecondary: AppColor.cardColor,
      inactiveColorPrimary: Colors.grey,
    );
  }

  /// Tabs whose page reads a cubit via `context.read` (instead of resolving
  /// it from GetIt internally) get their own `BlocProvider` here since
  /// `PersistentTabView` mounts each tab directly, not through
  /// `app_page.dart`'s go_router routes.
  ///
  /// Manager gets all 5 tabs; Member gets 4 — the Manager tab (mess-wide
  /// summary + cross-member operations) is dropped entirely, not just
  /// hidden-but-reachable.
  List<_TabSpec> _buildTabs(UserRole role, String userName) {
    final isManager = role == UserRole.manager;

    return [
      _TabSpec(const DashboardScreen(), _navItem(Icons.store, "Home")),
      if (isManager)
        _TabSpec(
          BlocProvider(
            create: (_) => sl<ManagerSummaryCubit>()..loadSummary(),
            child: const MessManagerPage(),
          ),
          _navItem(Icons.admin_panel_settings_outlined, "Manager"),
        ),
      _TabSpec(
        BlocProvider(
          create: (_) => sl<AddMealCubit>(),
          child: AddMeal(role: role.value, currentUserName: userName),
        ),
        _navItem(Icons.add, "Add"),
      ),
      _TabSpec(
        BlocProvider(
          create: (_) => sl<MembersCubit>(),
          child: MemberListPage(viewerRole: role),
        ),
        _navItem(Icons.person_3_sharp, "Members"),
      ),
      _TabSpec(const ProfilePage(), _navItem(Icons.person, "My Profile")),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final authState = context.watch<AuthBloc>().state;
    final role = authState is AuthAuthenticated
        ? authState.user.role
        : UserRole.member;
    final userName = authState is AuthAuthenticated ? authState.user.name : '';

    final tabs = _buildTabs(role, userName);

    return PersistentTabView(
      context,
      controller: _controller,
      screens: tabs.map((t) => t.screen).toList(),
      items: tabs.map((t) => t.item).toList(),
      backgroundColor: AppColor.backgroundColor,
      handleAndroidBackButtonPress: true,
      resizeToAvoidBottomInset: true,
      stateManagement: true,
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(20.0),
        colorBehindNavBar: Colors.white,
      ),
      navBarStyle: NavBarStyle.style7, //  Style 15
    );
  }
}
