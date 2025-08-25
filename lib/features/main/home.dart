import 'package:flutter/material.dart' show ScaffoldMessenger, SnackBar, Colors;
import 'package:flutter/widgets.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:mass_management/features/main/menu_bar.dart';

class ZoomDrawerExample extends StatefulWidget {
  const ZoomDrawerExample({super.key});

  @override
  State<ZoomDrawerExample> createState() => _ZoomDrawerExampleState();
}

class _ZoomDrawerExampleState extends State<ZoomDrawerExample> {
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