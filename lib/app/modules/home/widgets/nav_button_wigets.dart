import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pet_donation/app/common%20widget/custom%20text/custom_text_widget.dart';

import '../../../uitilies/app_colors.dart';

class NavButton extends StatelessWidget {
  final String label;
  final String iconPath;
  final VoidCallback? onTap;
  final bool isActive;  // <-- Add this field!

  const NavButton({
    super.key,
    required this.label,
    required this.iconPath,
    this.onTap,
    required this.isActive,  // <-- Make sure to add it here too
  });

  @override
  Widget build(BuildContext context) {
    final activeColor = AppColors.orangeColor;
    final inactiveColor = Colors.white.withOpacity(0.7);

    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Container(
            width: 79.w,
            padding: EdgeInsets.all(2.w),
            decoration: BoxDecoration(
              color: isActive ? activeColor.withOpacity(0.2) : AppColors.white.withOpacity(0.09),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Column(
              children: [
                Image.asset(
                  iconPath,
                  height: 20.h,
                  width: 20.w,
                  color: isActive ? activeColor : inactiveColor,
                ),
                SizedBox(height: 4.h),
                CustomText(
                  text: label,
                  fontSize: 8.sp,
                  color: isActive ? activeColor : inactiveColor,
                  fontWeight: isActive ? FontWeight.bold : FontWeight.w400,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
