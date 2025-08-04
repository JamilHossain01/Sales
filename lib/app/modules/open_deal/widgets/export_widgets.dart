import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:pet_donation/app/common%20widget/custom_button.dart';
import 'package:pet_donation/app/uitilies/app_colors.dart';
import 'package:pet_donation/app/uitilies/app_images.dart';

import '../../../common widget/custom text/custom_text_widget.dart';

class ExportContainerWidgets extends StatelessWidget {
  const ExportContainerWidgets({
    super.key,
    this.title,
    this.butonText,
  });

  final String? title;
  final String? butonText;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: const Color(0XFF00D1FF).withOpacity(0.090),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            text: title ?? 'Export Data', // fallback text just in case
            fontSize: 14.sp,
            color: Colors.white.withOpacity(0.82),
            fontWeight: FontWeight.w300,
          ),
          Gap(10.h),
          Row(
            children: [
              Expanded(
                child: CustomButton(
                  imagePath: AppImages.export,
                  title: butonText ?? 'Export',
                  onTap: () {
                    // Handle export logic here
                  },
                  isGradient: false,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                  imageHeight: 15,
                  imageWidth: 15,
                  buttonColor: AppColors.white.withOpacity(0.16),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
