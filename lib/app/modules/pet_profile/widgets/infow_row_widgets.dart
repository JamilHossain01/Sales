import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import '../../../common widget/custom text/custom_text_widget.dart';
import '../../../common widget/heart_conatiner.dart';
import '../../../uitilies/app_colors.dart';

class InfoRow extends StatelessWidget {
  final String title;
  final String value;
  final String assetPath;
  final Color iconBgColor;

  const InfoRow({
    super.key,
    required this.title,
    required this.value,
    required this.assetPath,
    this.iconBgColor = Colors.grey,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RoundedHeartIconContainer(
          backgroundColor: iconBgColor,
          assetPath: assetPath,
        ),
        Gap(10.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                text: title,
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
              CustomText(
                text: value,
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
                color: Colors.black.withOpacity(0.3),
              ),
              Divider(
                color: Colors.black.withOpacity(0.1),
                thickness: 1,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
