import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:wolf_pack/app/uitilies/app_colors.dart';
import '../../../common_widget/custom text/custom_text_widget.dart';
import '../model/badget_model_data.dart';

class BadgeProgressCard extends StatelessWidget {
  final String? title;
  final String? badgeLabel;
  final String? progressText;
  final String? iconPath;
  final Widget? targetCard;
  final List<NavButtonData>? navButtons;

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
        crossAxisAlignment: CrossAxisAlignment.start,
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
            Center(
              child: Container(
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
                  errorBuilder: (_, __, ___) =>
                  const Icon(Icons.error, size: 24, color: Colors.orange),
                ),
              ),
            ),

          if (badgeLabel != null) ...[
            Gap(6.h),
            CustomText(
              text: badgeLabel!,
              fontWeight: FontWeight.w400,
              fontSize: 18.sp,
              color: AppColors.white,
            ),
          ],

          if (progressText != null) ...[
            Gap(10.h),
            CustomText(
              text: progressText!,
              fontWeight: FontWeight.w400,
              fontSize: 14.sp,
              color: AppColors.white,
            ),
          ],

          if (targetCard != null) ...[
            Gap(15.h),
            targetCard!,
          ],

          if (navButtons != null && navButtons!.isNotEmpty) ...[
            Gap(15.h),
            Container(
              padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 8.w),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    const Color(0xFFFCB806).withOpacity(0.05),
                    const Color(0xFFFCB806).withOpacity(0.05),
                  ],
                ),
                borderRadius: BorderRadius.circular(8.r),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x29000000),
                    offset: Offset(0, 4),
                    blurRadius: 13,
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

                  Gap(8.h),

                  SizedBox(
                    height: 80.h,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: navButtons!.length,
                      itemBuilder: (context, index) {
                        final item = navButtons![index];
                        return Padding(
                          padding: EdgeInsets.only(right: 8.w),
                          child: _buildNavButton(
                            item.label,
                            item.assetPath,
                            item.color ?? AppColors.orangeColor,
                            item.textColor ?? AppColors.white,
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildNavButton(
      String title,
      String iconUrl,
      Color bgColor,
      Color textColor,
      ) {
    return Container(
      width: 100.w,
      padding: EdgeInsets.symmetric(vertical: 10.h),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            iconUrl,
            width: 24.w,
            height: 24.h,
            errorBuilder: (_, __, ___) =>
            const Icon(Icons.error, size: 24, color: Colors.orange),
          ),
          Gap(4.h),
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
