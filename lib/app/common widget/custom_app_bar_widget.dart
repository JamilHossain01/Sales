import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'custom text/custom_text_widget.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback? onBackPressed;
  final Widget? trailing;
  final bool showBackButton; // ✅ new flag

  const CommonAppBar({
    Key? key,
    required this.title,
    this.onBackPressed,
    this.trailing,
    this.showBackButton = true, // ✅ default true
  }) : super(key: key);

  @override
  Size get preferredSize => Size.fromHeight(60.h);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      forceMaterialTransparency: true,
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
      title: CustomText(
        text: title,
        fontWeight: FontWeight.w600,
        fontSize: 20.sp,
        color: Colors.black,
      ),
      leading: showBackButton
          ? IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.black),
        onPressed: onBackPressed ?? () => Navigator.of(context).pop(),
      )
          : const SizedBox.shrink(), // ✅ hide if false
      actions: trailing != null
          ? [
        Padding(
          padding: EdgeInsets.only(right: 16.w),
          child: trailing!,
        ),
      ]
          : null,
    );
  }
}
