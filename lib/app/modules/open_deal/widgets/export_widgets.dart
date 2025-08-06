import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:pet_donation/app/common%20widget/custom_button.dart';
import 'package:pet_donation/app/uitilies/app_colors.dart';
import 'package:pet_donation/app/uitilies/app_images.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../common widget/custom text/custom_text_widget.dart'; // Add this import

class ExportContainerWidgets extends StatelessWidget {
  const ExportContainerWidgets({
    super.key,
    this.title,
    this.butonText,
    this.url, // Add url parameter
  });

  final String? title;
  final String? butonText;
  final String? url; // URL to launch

  Future<void> _launchURL() async {
    if (url == null) return;

    final Uri uri = Uri.parse(url!);
    if (!await launchUrl(uri)) {
      throw Exception('Could not launch $url');
    }
  }

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
            text: title ?? 'Export Data',
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
                    if (url != null) {
                      _launchURL(); // Launch URL when button is pressed
                    } else {
                      // Handle export logic here if no URL is provided
                    }
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