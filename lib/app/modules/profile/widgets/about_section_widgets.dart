import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pet_donation/app/common%20widget/custom%20text/custom_text_widget.dart';

class AboutUsSection extends StatelessWidget {
  final String title;
  final String content;

  const AboutUsSection({
    super.key,
    this.title = 'About Us',
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          text: title,
          fontSize: 16.sp,
          fontWeight: FontWeight.w600,
          color: Colors.black,
        ),
        SizedBox(height: 8.h),
        CustomText(
          textAlign: TextAlign.start,
          text: content,
          fontSize: 14.sp,
          fontWeight: FontWeight.w400,
          color: Colors.black87,
        ),
      ],
    );
  }
}
