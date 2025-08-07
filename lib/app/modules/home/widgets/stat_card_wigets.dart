import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wolf_pack/app/common%20widget/custom%20text/custom_text_widget.dart';
import 'package:wolf_pack/app/uitilies/app_colors.dart';

class StatCard extends StatelessWidget {
  final String primaryValue;
  final String label;
  final String subValue;
  final Color color;

  const StatCard({
    Key? key,
    required this.primaryValue,
    required this.label,
    required this.subValue,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width:165.w,
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: AppColors.white.withOpacity(0.09),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CustomText(
            text: primaryValue,
            fontSize: 20.sp,
            fontWeight: FontWeight.w700,
            color: AppColors.white,
          ),
          SizedBox(height: 4.h),
          CustomText(
            text: label,
            fontSize: 10.sp,
            fontWeight: FontWeight.w400,
            color: Colors.white.withOpacity(0.62),
          ),
          if (subValue.isNotEmpty) ...[
            SizedBox(height: 4.h),
            CustomText(
              text: subValue,
              fontSize: 10.sp,
              fontWeight: FontWeight.w300,
              color: Colors.white.withOpacity(0.62),
            ),
          ],
        ],
      ),
    );
  }
}
