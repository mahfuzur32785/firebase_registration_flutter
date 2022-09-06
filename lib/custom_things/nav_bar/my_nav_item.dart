import 'package:flutter/material.dart';

class MyNavbarItem {
  final String? title;
  final IconData? icon;
  final Widget? customWidget;

  MyNavbarItem({
    this.icon,
    this.title,
    this.customWidget,
  }) : assert(icon != null || customWidget != null);
}
