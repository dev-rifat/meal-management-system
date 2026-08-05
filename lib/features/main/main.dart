import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:mass_management/core/di/service_locator.dart';
import 'package:mass_management/utils/app_color.dart';
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

class _MainNavScreenState extends State<MainNavScreen> {
  late PersistentTabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = PersistentTabController(initialIndex: 0);
  }

  /// List of tab screens. Tabs whose page reads a cubit via `context.read`
  /// (instead of resolving it from GetIt internally) get their own
  /// `BlocProvider` here since `PersistentTabView` mounts each tab directly,
  /// not through `app_page.dart`'s go_router routes.
  List<Widget> _buildScreens() {
    return [
      const DashboardScreen(),
      BlocProvider(
        create: (_) => sl<ManagerSummaryCubit>()..loadSummary(),
        child: const MessManagerPage(),
      ),
      BlocProvider(
        create: (_) => sl<AddMealCubit>(),
        child: AddMeal(),
      ),
      BlocProvider(
        create: (_) => sl<MembersCubit>(),
        child: const MemberListPage(),
      ),
      const ProfilePage(),
    ];
  }

  /// Bottom navigation items
  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.store),
        title: ("Home"),
        activeColorPrimary: AppColor.primaryColor,
        activeColorSecondary: AppColor.cardColor,

        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.admin_panel_settings_outlined),
        title: ("Manager"),
        activeColorPrimary: AppColor.primaryColor,
        activeColorSecondary: AppColor.cardColor,

        inactiveColorPrimary: Colors.grey,
      ), PersistentBottomNavBarItem(
        icon: const Icon(Icons.add),
        title: ("Add"),
        activeColorSecondary: AppColor.cardColor,
        activeColorPrimary: AppColor.primaryColor,
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.person_3_sharp),
        title: ("Members"),
        activeColorSecondary: AppColor.cardColor,

        activeColorPrimary: AppColor.primaryColor,
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.person),
        title: ("My Profile"),
        activeColorSecondary: AppColor.cardColor,

        activeColorPrimary: AppColor.primaryColor,
        inactiveColorPrimary: Colors.grey,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
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
