import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pet_donation/app/common%20widget/custom%20text/custom_text_widget.dart';
import 'package:pet_donation/app/uitilies/app_colors.dart';

class TargetProgressCard extends StatelessWidget {
  final String title;
  final double progressValue; // Between 0.0 and 1.0
  final String achievedText;
  final String percentageLabel;
  final String footerMessage;
  final String? motivationLine1;
  final String? motivationLine2;

  const TargetProgressCard({
    Key? key,
    required this.title,
    required this.progressValue,
    required this.achievedText,
    required this.percentageLabel,
    required this.footerMessage,
    this.motivationLine1,
    this.motivationLine2,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
      Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            const Color(0xFFFCB806).withOpacity(0.070),
            const Color(0xFFFCB806).withOpacity(0.070),
          ],
          stops: [0.0, 1.0],
        ),
        borderRadius: BorderRadius.circular(8.r),
        boxShadow: [
          BoxShadow(
            color: const Color(0x29000000),
            offset: const Offset(0, 4),
            blurRadius: 13,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Header Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(
                text: title,
                fontSize: 20.sp,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
              CustomText(
                text: percentageLabel,
                fontSize: 14.sp,
                color: Colors.amber,
              ),
            ],
          ),

          SizedBox(height: 10.h),

          /// Progress Bar
          LinearProgressIndicator(
            borderRadius: BorderRadius.circular(20),
            value: progressValue,
            backgroundColor: const Color(0XFFFBBF24).withOpacity(0.090),
            color: Colors.amber,
            minHeight: 10.h,
          ),

          SizedBox(height: 10.h),

          /// Footer Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(
                text: achievedText,
                fontSize: 10.sp,
                color: Colors.white,
              ),
              CustomText(
                text: footerMessage,
                fontSize: 10.sp,
                color: Colors.grey,
              ),
            ],
          ),

          /// 💡 Optional Motivation Block
          if (motivationLine1 != null && motivationLine2 != null)
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(top: 12.h),
              padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
              decoration: BoxDecoration(
                color: const Color(0xFF00D1FF).withOpacity(0.13),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CustomText(
                    text: motivationLine1!,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xFF00D1FF),
                  ),
                  CustomText(
                    text: motivationLine2!,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xFF00D1FF),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
