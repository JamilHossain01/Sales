import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:pet_donation/app/common widget/custom text/custom_text_widget.dart';
import 'package:pet_donation/app/common widget/heart_conatiner.dart';
import 'package:pet_donation/app/uitilies/app_colors.dart';
import 'package:pet_donation/app/uitilies/app_images.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback? onBackPressed;
  final Widget? trailing;

  const CommonAppBar({
    Key? key,
    required this.title,
    this.onBackPressed,
    this.trailing,
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
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.black),
        onPressed: onBackPressed ?? () => Navigator.of(context).pop(),
      ),
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
