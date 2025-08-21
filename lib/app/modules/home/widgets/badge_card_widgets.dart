import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:wolf_pack/app/common%20widget/custom%20text/custom_text_widget.dart';
import 'package:wolf_pack/app/uitilies/app_colors.dart';
import 'package:wolf_pack/app/uitilies/app_images.dart'; // Import for local assets
import '../model/badget_model_data.dart';

class BadgeProgressCard extends StatelessWidget {
  final String? title;
  final String? badgeLabel;
  final String? progressText;
  final String? iconPath; // Optional
  final Widget? targetCard; // Optional
  final List<NavButtonData>? navButtons; // Optional

  const BadgeProgressCard({
    Key? key,
    this.title,
    this.badgeLabel,
    this.progressText,
    this.iconPath,
    this.targetCard,
    this.navButtons,
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
          if (title != null)
            CustomText(
              text: title!,
              fontWeight: FontWeight.w300,
              fontSize: 14.sp,
              color: AppColors.white,
            ),
          Gap(10.h),
          if (iconPath != null)
            Container(
              width: 42.w,
              height: 42.h,
              decoration: BoxDecoration(
                color: Colors.orange.withOpacity(0.5),
                borderRadius: BorderRadius.circular(8.r),
              ),
              alignment: Alignment.center,
              child: Image.asset(
                iconPath!,
                width: 30.w,
                height: 30.h,
                errorBuilder: (context, error, stackTrace) =>
                const Icon(Icons.error, size: 24, color: Colors.orange),
              ),
            ),
          if (badgeLabel != null)
            CustomText(
              text: badgeLabel!,
              fontWeight: FontWeight.w400,
              fontSize: 18.sp,
              color: AppColors.white,
            ),
          if (progressText != null) ...[
            SizedBox(height: 10.h),
            CustomText(
              text: progressText!,
              fontWeight: FontWeight.w400,
              fontSize: 14.sp,
              color: AppColors.white,
            ),
          ],
          if (targetCard != null) ...[
            SizedBox(height: 15.h),
            targetCard!,
          ],
          if (navButtons != null && navButtons!.isNotEmpty) ...[
            SizedBox(height: 15.h),
            Container(
              padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 8.w),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    const Color(0xFFFCB806).withOpacity(0.050),
                    const Color(0xFFFCB806).withOpacity(0.050),
                  ],
                  stops: const [0.0, 1.0],
                ),
                borderRadius: BorderRadius.circular(8.r),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x29000000),
                    offset: Offset(0, 4),
                    blurRadius: 13,
                    spreadRadius: 0,
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text: 'Earned Achievement',
                    fontWeight: FontWeight.w500,
                    fontSize: 14.sp,
                    color: AppColors.white,
                  ),
                  Gap(5.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: navButtons!
                        .map(
                          (e) => Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: _buildNavButton(
                          e.label,
                          e.assetPath,
                          e.color ?? AppColors.orangeColor,
                          e.textColor ?? AppColors.white,
                        ),
                      ),
                    )
                        .toList(),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildNavButton(String title, String iconUrl, Color bgColor, Color textColor) {
    return Container(
      width: 80.w,
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 1),
        child: Column(
          children: [
            Image.asset(
              iconUrl,
              width: 24.w,
              height: 24.h,
              errorBuilder: (context, error, stackTrace) =>
              const Icon(Icons.error, size: 24, color: Colors.orange),
            ),
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
      ),
    );
  }
}
