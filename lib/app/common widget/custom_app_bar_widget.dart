import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pet_donation/app/uitilies/app_images.dart';

import '../uitilies/app_colors.dart';
import 'custom text/custom_text_widget.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback? onBackPressed;
  final Widget? trailing;
  final bool showBackButton;

  const CommonAppBar({
    Key? key,
    required this.title,
    this.onBackPressed,
    this.trailing,
    this.showBackButton = true,
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

      /// 🧠 Title
      title: CustomText(
        text: title,
        fontWeight: FontWeight.w400,
        fontSize: 16.sp,
        color: AppColors.white,
      ),

      /// ⬅️ Smol Back Button
      leading: showBackButton
          ? Padding(
        padding: EdgeInsets.only(left: 12.w, top: 12.h, bottom: 12.h),
        child: InkWell(
          onTap: onBackPressed ?? () => Navigator.of(context).pop(),
          borderRadius: BorderRadius.circular(30.r),
          child: Image.asset(AppImages.arrowBack)
        ),
      )
          : const SizedBox.shrink(),

      /// ➡️ Trailing Button
      actions: trailing != null
          ? [
        Container(
          height: 36.h,
          width: 36.h,
          margin: EdgeInsets.only(right: 16.w, top: 8.h, bottom: 8.h),
          decoration: BoxDecoration(
            color: AppColors.orangeColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: Center(child: trailing),
        ),
      ]
          : null,
    );
  }
}
