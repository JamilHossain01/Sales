import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pet_donation/app/common%20widget/custom%20text/custom_text_widget.dart';

class MenuItem extends StatelessWidget {
  final IconData? icon;
  final String? assetImagePath;
  final String title;
  final VoidCallback onTap;
  final Color? textColor;
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
  }) : assert(icon != null || assetImagePath != null, 'Either icon or assetImagePath must be provided.');

  @override
  Widget build(BuildContext context) {
    Widget leadingWidget;

    if (assetImagePath != null) {
      leadingWidget = Padding(
        padding: padding ?? const EdgeInsets.only(right: 12.0),
        child: Image.asset(
          assetImagePath!,
          width: 24,
          height: 24,
          fit: BoxFit.contain,
        ),
      );
    } else {
      leadingWidget = Padding(
        padding: padding ?? const EdgeInsets.only(right: 12.0),
        child: Icon(icon, color: textColor ?? Colors.black),
      );
    }

    return Container(
      decoration: BoxDecoration(
        color: backgroundColor ?? Colors.transparent,
        borderRadius: borderRadius ?? BorderRadius.circular(0),
      ),
      child: ListTile(
        leading: leadingWidget,
        title: CustomText(
          text: title,
          fontSize: 12.sp,
          fontWeight: FontWeight.w500,
          color: textColor ?? Colors.black,
        ),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
      ),
    );
  }
}
