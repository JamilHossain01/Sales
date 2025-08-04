import 'dart:ui';

class NavButtonData {
  final String label;
  final String assetPath;
  final Color? color;
  final Color? textColor;

  NavButtonData({
    required this.label,
    required this.assetPath,
    this.color,
    this.textColor,
  });
}
