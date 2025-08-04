import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import '../../../common widget/custom text/custom_text_widget.dart';
import '../../../common widget/heart_conatiner.dart';
import '../../../uitilies/app_colors.dart';

class InfoRow extends StatelessWidget {
  final String title;
  final String value;
  final Color iconBgColor;

  const InfoRow({
    super.key,
    required this.title,
    required this.value,
    this.iconBgColor = Colors.grey,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        Gap(10.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                text: title,
                fontSize: 14.sp,

                fontWeight: FontWeight.w500,
                color: AppColors.white,
              ),
              CustomText(
                textAlign: TextAlign.start,
                text: value,
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
              Divider(
                color: AppColors.orangeColor,
                thickness: 1,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
