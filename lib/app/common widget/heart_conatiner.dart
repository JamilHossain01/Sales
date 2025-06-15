import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RoundedHeartIconContainer extends StatelessWidget {
  final String assetPath;
  final Color backgroundColor;
  final Color? borderColor;
  final double size; // image size
  final double padding;
  final VoidCallback? onTap;
  final double? containerHeight;
  final double? containerWidth;

  const RoundedHeartIconContainer({
    Key? key,
    required this.assetPath,
    this.backgroundColor = Colors.white,
    this.size = 20,
    this.padding = 8,
    this.containerHeight,
    this.containerWidth,
    this.borderColor,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double diameter = (containerHeight ?? 40).h;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: diameter,
        width: diameter,
        decoration: BoxDecoration(
          color: backgroundColor,
          shape: BoxShape.circle,
          border: borderColor != null ? Border.all(color: borderColor!) : null,
        ),
        padding: EdgeInsets.all(padding.w),
        child: Image.asset(
          assetPath,
          height: size.sp,
          width: size.sp,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
