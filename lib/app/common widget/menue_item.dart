import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pet_donation/app/common%20widget/custom%20text/custom_text_widget.dart';

class MenuItem extends StatelessWidget {
  final IconData? icon;
  final String? assetImagePath;
  final String title;
  final VoidCallback onTap;
  final Color? textColor;
  final Color? iconColors;
  final Color? backgroundColor;
  final EdgeInsetsGeometry? padding;
  final BorderRadiusGeometry? borderRadius;

  const MenuItem({
    super.key,
    this.icon,
    this.assetImagePath,
    required this.title,
    required this.onTap,
    this.textColor,
    this.backgroundColor,
    this.padding,
    this.borderRadius,
    this.iconColors,
  }) : assert(icon != null || assetImagePath != null,
  'Either icon or assetImagePath must be provided.');

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: padding ?? EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
        decoration: BoxDecoration(
          color: backgroundColor ?? const Color(0xFF333333).withOpacity(0.25),
          borderRadius: borderRadius ?? BorderRadius.circular(0),
          border: Border(
            top: BorderSide(color: const Color(0XFFFDFDFD).withOpacity(0.29)),
            bottom: BorderSide(color: const Color(0XFFFDFDFD).withOpacity(0.29)),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Image + Title
            Row(
              children: [
                if (assetImagePath != null)
                  Image.asset(
                    assetImagePath!,
                    width: 24,
                    height: 24,
                    fit: BoxFit.contain,
                  )
                else if (icon != null)
                  Icon(icon, color: iconColors ?? Colors.white, size: 24),
                SizedBox(width: 5.w), // 5 pixel gap between image and text
                CustomText(
                  text: title,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w400,
                  color: textColor ?? Colors.black,
                ),
              ],
            ),
            // Trailing arrow
            Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: iconColors ?? Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
