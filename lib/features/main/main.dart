// lib/features/main/main_nav_screen.dart
import 'package:flutter/material.dart';
import 'package:mass_management/features/deashboard/pages/dashboard_screen.dart';
import 'package:mass_management/features/maneger/pages/manager_screen.dart';
import 'package:mass_management/features/user_list/page/user_list.dart';
import 'package:mass_management/utils/app_color.dart';
import '../profile/pages/profile.dart' show ProfilePage;

class MainNavScreen extends StatefulWidget {
  const MainNavScreen({super.key});

  @override
  State<MainNavScreen> createState() => _MainNavScreenState();
}

class _MainNavScreenState extends State<MainNavScreen>
    with AutomaticKeepAliveClientMixin {
  int _selectedIndex = 0;

  final List<Widget> _screens = const [
    DashboardScreen(),
    MessManagerPage(),
    UserListPage(),
    ProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  bool get wantKeepAlive => true; // Keeps state alive

  @override
  Widget build(BuildContext context) {
    super.build(context); // required when using keepAlive
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: AppColor.primaryColor,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.store), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.admin_panel_settings_outlined),
              label: 'Manager'),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_3_sharp), label: 'Members'),
          BottomNavigationBarItem(
              icon: Icon(Icons.person), label: 'My profile'),
        ],
      ),
    );
  }
}
