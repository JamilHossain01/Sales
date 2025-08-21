import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:wolf_pack/app/common%20widget/custom%20text/custom_text_widget.dart';
import 'package:wolf_pack/app/uitilies/app_images.dart';

class NoDataWidget extends StatelessWidget {
  final String message;
  final String imagePath;
  final double imageHeight;
  final double spacing;

  const NoDataWidget({
    super.key,
    this.message = "No data available",
    this.imagePath = AppImages.noData,
    this.imageHeight = 140,
    this.spacing = 5,
    required String text,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(imagePath, height: imageHeight),
          Gap(10.h),
          CustomText(
            text: message,
            fontSize: 14,
            color: Colors.grey,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
