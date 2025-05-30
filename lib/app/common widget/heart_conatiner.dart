import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RoundedHeartIconContainer extends StatelessWidget {
  final String assetPath;
  final Color backgroundColor;
  final Color? borderColor;
  final double size; // image size
  final double padding;
  final double borderRadius;
  final VoidCallback? onTap;
  final double? containerHeight; // optional container height
  final double? containerWidth;  // optional container width

  const RoundedHeartIconContainer({
    Key? key,
    required this.assetPath,
    this.backgroundColor = Colors.white,
    this.size = 20,
    this.padding = 6,
    this.borderRadius = 15,
    this.containerHeight,
    this.containerWidth,
    this.borderColor, this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: containerHeight?.h,
        width: containerWidth?.w,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(borderRadius.r),
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
