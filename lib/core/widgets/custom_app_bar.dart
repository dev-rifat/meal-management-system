import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final Widget? titleWidget;
  final bool centerTitle;
  final List<Widget>? actions;
  final Widget? leading;
  final double? leadingWidth;
  final Color? backgroundColor;
  final double elevation;

  const CustomAppBar({
    super.key,
    this.title,
    this.titleWidget,
    this.centerTitle = true,
    this.actions,
    this.leading,
    this.leadingWidth,
    this.backgroundColor,
    this.elevation = 0,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title:
          titleWidget ??
          (title != null
              ? Text(
                  title!,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                )
              : null),
      centerTitle: centerTitle,
      actions: actions,
      leading: leading,
      scrolledUnderElevation: 0, // Prevent color change on scroll
      surfaceTintColor: Colors.transparent, // Disable Material 3 tint
      iconTheme: const IconThemeData(color: Colors.black),
      leadingWidth: leadingWidth,
      backgroundColor:
          backgroundColor ?? Theme.of(context).scaffoldBackgroundColor,
      elevation: elevation,
    );
  }
}
