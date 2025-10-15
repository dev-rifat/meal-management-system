import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:mass_management/utils/app_color.dart';
import 'package:mass_management/features/deashboard/pages/dashboard_screen.dart';
import 'package:mass_management/features/maneger/pages/manager_screen.dart';
import 'package:mass_management/features/user_list/page/user_list.dart';
import 'package:mass_management/features/profile/pages/profile.dart';

import '../maneger/pages/add_meal.dart';

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

  /// List of tab screens
  List<Widget> _buildScreens() {
    return const [
      DashboardScreen(),
      MessManagerPage(),
      AddMeal(),
      UserListPage(),
      ProfilePage(),
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
