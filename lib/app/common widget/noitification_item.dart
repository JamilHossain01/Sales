import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pet_donation/app/common%20widget/custom%20text/custom_text_widget.dart';
import 'package:pet_donation/app/uitilies/app_images.dart';

class NotificationItem extends StatelessWidget {
  final String title;
  final String message;
  final String message1;
  final String time;
  final VoidCallback? onTap;
  final bool showEmoji;
  final bool isHighlighted;


  const NotificationItem({
    super.key,
    required this.title,
    required this.message,
    required this.message1,
    required this.time,
    this.onTap,
    this.showEmoji = false, required this.isHighlighted,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(12.w),
        margin: EdgeInsets.symmetric(vertical: 6.h),
        decoration: BoxDecoration(
          color:isHighlighted ?Colors.transparent: Colors.white.withOpacity(0.090),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              AppImages.NotificationMAin,
              height: 24.h,
              width: 24.w,
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    textAlign: TextAlign.start,
                    text: showEmoji ? "🎉 $title" : title,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w300,
                    color: Colors.white,
                  ),
                  SizedBox(height: 4.h),
                  CustomText(
                    textAlign: TextAlign.start,
                    text: message,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                  ),
                  if (message1.isNotEmpty) ...[
                    SizedBox(height: 4.h),
                    CustomText(
                      textAlign: TextAlign.start,
                      text: message1,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                    ),
                  ],
                  SizedBox(height: 6.h),
                  CustomText(
                    text: time,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                    color: Colors.grey,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
