import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pet_donation/app/common%20widget/custom%20text/custom_text_widget.dart';
import 'package:pet_donation/app/uitilies/app_colors.dart';

class StatProgressCard extends StatelessWidget {
  final String primaryValue;
  final String label;
  final String subValue;
  final double progressValue; // progress 0.0 - 1.0
  final Color color;

  const StatProgressCard({
    Key? key,
    required this.primaryValue,
    required this.label,
    required this.subValue,
    required this.progressValue,
    this.color = Colors.amber,
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
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          /// Primary value text (e.g., €4,000)
            CustomText(
                      text: label,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400,
                      color: Colors.white.withOpacity(0.62),
                    ),
          CustomText(
            text: primaryValue,
            fontSize: 20.sp,
            fontWeight: FontWeight.w700,
            color: AppColors.white,
          ),


          /// Label text (e.g., Total Sales)



          /// Linear Progress
          // ClipRRect(
          //   borderRadius: BorderRadius.circular(20.r),
          //   child: LinearProgressIndicator(
          //     value: progressValue,
          //     backgroundColor: Colors.grey.withOpacity(0.4),
          //     color: color,
          //     minHeight: 10.h,
          //   ),
          // ),

          /// Optional Subtext (e.g., 60% Complete)
          if (subValue.isNotEmpty) ...[
            SizedBox(height: 8.h),
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
