// 📁 nav_item.dart
import 'package:flutter/material.dart';

class NavItem {
  final String label;
  final String iconPath;
  final Widget content;

  NavItem({
    required this.label,
    required this.iconPath,
    required this.content,
  });
}
