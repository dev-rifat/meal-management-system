


import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';

// void main() => runApp(const MyApp());

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.deepPurple),
//       home:  ZoomDrawerExample(),
//     );
//   }
// }

class ZoomDrawerExample extends StatelessWidget {
   ZoomDrawerExample({super.key});

  final _drawerController = ZoomDrawerController();

  @override
  Widget build(BuildContext context) {
    return ZoomDrawer(
      controller: _drawerController,
      menuScreen: MenuScreen(onItemClick: (item) {
        _drawerController.close?.call();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Navigate to: $item')));
      }),
      mainScreen: HomeScreen(onMenuTap: () => _drawerController.toggle?.call()),
      borderRadius: 24,
      showShadow: true,
      angle: 0,
      slideWidth: MediaQuery.of(context).size.width * 0.75,
      menuBackgroundColor: Colors.deepPurple.shade100,
    );
  }
}

class HomeScreen extends StatelessWidget {
  final VoidCallback onMenuTap;
  const HomeScreen({super.key, required this.onMenuTap});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: const Icon(Icons.menu), onPressed: onMenuTap),
        title: const Text("Mess Manager"),
      ),
      body: const Center(
        child: Text("Main Screen Content"),
      ),
    );
  }
}

class MenuScreen extends StatelessWidget {
  final Function(String) onItemClick;
  const MenuScreen({super.key, required this.onItemClick});

  @override
  Widget build(BuildContext context) {
    final items = [
      {"icon": Icons.settings_outlined, "title": "Mess Setting"},
      {"icon": Icons.restaurant_menu_outlined, "title": "Meal Setting"},
      {"icon": Icons.swap_horiz_outlined, "title": "Transfer Ownership"},
      {"icon": Icons.receipt_long_outlined, "title": "Fixed Expense"},
      {"icon": Icons.logout, "title": "Logout"},
    ];

    return Scaffold(
      backgroundColor: Colors.deepPurple.shade100,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Drawer Header
            Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.deepPurple.shade300, Colors.deepPurple.shade200],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  const CircleAvatar(radius: 28, backgroundColor: Colors.white, child: Icon(Icons.home, color: Colors.deepPurple)),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text("Mess Manager", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
                      SizedBox(height: 4),
                      Text("Manage meals & expenses", style: TextStyle(fontSize: 12, color: Colors.white70)),
                    ],
                  ),
                ],
              ),
            ),

            // Menu Items
            ...items.map((item) => ListTile(
                  leading: Icon(item["icon"] as IconData, color: item["title"] == "Logout" ? Colors.red : Colors.deepPurple),
                  title: Text(
                    item["title"] as String,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: item["title"] == "Logout" ? Colors.red : Colors.black87,
                    ),
                  ),
                  onTap: () => onItemClick(item["title"] as String),
                )),
          ],
        ),
      ),
    );
  }
}
