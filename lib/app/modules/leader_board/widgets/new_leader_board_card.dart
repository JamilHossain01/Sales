import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wolf_pack/app/uitilies/app_colors.dart';
import 'package:wolf_pack/app/uitilies/app_images.dart';

import '../../../common_widget/custom text/custom_text_widget.dart';

class NewLeaderBoardCard extends StatelessWidget {
  final String? name;
  final String? totalAmount;
  final String? value;
  final String? profileImage;  // Add profileImage field for URL or asset

  const NewLeaderBoardCard({
    Key? key,
    this.name,
    this.value,
    this.profileImage, this.totalAmount,  // Accept profileImage as a parameter
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xFF2B1B0F),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Padding(
        padding: EdgeInsets.all(12.h),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile Image Section
            CircleAvatar(
              radius: 30.r, // Circle avatar with fixed radius
              backgroundColor: AppColors.orangeColor, // Optional background color for image
              child: profileImage != null && profileImage!.isNotEmpty
                  ? ClipOval(
                child: CachedNetworkImage(
                  imageUrl: profileImage!,
                  width: 60.w,
                  height: 60.h,
                  fit: BoxFit.cover,
                  // placeholder: (context, url) => const CircularProgressIndicator(), // Loading placeholder
                  errorWidget: (context, url, error) => const Icon(Icons.error, size: 30), // Error handling
                ),
              )
                  : const Icon(Icons.account_circle, size: 50, color: Colors.white), // Default icon when no image
            ),
            SizedBox(width: 12.w), // Spacing between the image and text

            // Text and Value Section
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text: name ?? '',
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),  CustomText(
                    text: totalAmount ?? '',
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                  if (value != null)
                    Padding(
                      padding: EdgeInsets.only(top: 4.h),
                      child: Text(
                        value!.replaceAll('_', ' '),
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFFFFA500),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            SizedBox(
              child: Image.asset(AppImages.badges, width: 30, height: 30), // Badge icon
            ),
          ],
        ),
      ),
    );
  }
}
