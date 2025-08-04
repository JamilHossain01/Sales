import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:pet_donation/app/common%20widget/custom%20text/custom_text_widget.dart';
import 'package:pet_donation/app/uitilies/app_colors.dart';
import 'package:pet_donation/app/uitilies/app_images.dart';

import '../model/badget_model_data.dart';

class BadgeProgressCard extends StatelessWidget {
  final String title;
  final String badgeLabel;
  final String progressText;
  final Widget targetCard;
  final List<NavButtonData> navButtons;

  const BadgeProgressCard({
    Key? key,
    required this.title,
    required this.badgeLabel,
    required this.progressText,
    required this.targetCard,
    required this.navButtons,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: AppColors.white.withOpacity(0.09),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Column(
        children: [
          CustomText(
            text: title,
            fontWeight: FontWeight.w300,
            fontSize: 14.sp,
            color: AppColors.white,
          ),
          SizedBox(child: Image.asset(AppImages.milestone,height: 56.h,width: 42.w
            ,)),
          CustomText(
            text: badgeLabel,
            fontWeight: FontWeight.w400,
            fontSize: 18.sp,
            color: AppColors.white,
          ),
          SizedBox(height: 10.h),
          CustomText(
            text: progressText,
            fontWeight: FontWeight.w400,
            fontSize: 14.sp,
            color: AppColors.white,
          ),
          SizedBox(height: 15.h),
          targetCard,
          SizedBox(height: 15.h),

          /// Nav Buttons (Badges)
          Container(
            padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 8.w),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFFFCB806).withOpacity(0.050),
                  Color(0xFFFCB806).withOpacity(0.050),
                ],
                stops: [0.0, 1.0],
              ),
              borderRadius: BorderRadius.circular(8.r),

              boxShadow: [
                BoxShadow(
                  color: Color(0x29000000), // Subtle shadow
                  offset: Offset(0, 4),
                  blurRadius: 13,
                  spreadRadius: 0,
                ),
              ],
            ),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                CustomText(text: 'Earned Badges',fontWeight: FontWeight.w500,fontSize: 14.sp,color: AppColors.white,),
                Gap(5.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: navButtons
                      .map((e) => _buildNavButton(
                    e.label,
                    e.assetPath,
                    e.color ?? AppColors.orangeColor,
                    e.textColor ?? AppColors.white,
                  ))
                      .toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavButton(String title, String iconPath, Color bgColor, Color textColor) {
    return Container(
      width: 70.w,
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Column(
        children: [
          Image.asset(iconPath, width: 24.w, height: 24.h),
          SizedBox(height: 4.h),
          CustomText(
            text: title,
            fontSize: 10.sp,
            fontWeight: FontWeight.w400,
            color: textColor,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
