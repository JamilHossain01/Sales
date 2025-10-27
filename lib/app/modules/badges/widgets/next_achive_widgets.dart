import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common_widget/custom text/custom_text_widget.dart';


class NextAchievementCard extends StatelessWidget {
  final String title;
  final String iconUrl;
  final Color bgColor;
  final Color textColor;

  const NextAchievementCard({
    Key? key,
    required this.title,
    required this.iconUrl,
    required this.bgColor,
    required this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100.w,
      height: 90.h,
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            iconUrl, // local asset path
            width: 30.w,
            height: 30.h,
            errorBuilder: (context, error, stackTrace) => const Icon(
              Icons.error,
              size: 24,
              color: Colors.orange,
            ),
          ),
          SizedBox(height: 4.h),
          CustomText(
            text: title,
            fontSize: 12.sp,
            fontWeight: FontWeight.w400,
            color: textColor,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
