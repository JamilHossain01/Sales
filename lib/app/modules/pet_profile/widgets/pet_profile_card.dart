import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wolf_pack/app/common%20widget/custom%20text/custom_text_widget.dart';
import 'package:wolf_pack/app/uitilies/app_colors.dart';
import 'package:wolf_pack/app/uitilies/app_images.dart';

class PetProfileCard extends StatelessWidget {
  final String petName;
  final String breed;
  final String gender;
  final String age;
  final String imagePath;
  final VoidCallback? onTap;

  const PetProfileCard({
    super.key,
    required this.petName,
    required this.breed,
    required this.gender,
    required this.age,
    required this.imagePath, this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(color: AppColors.mainColor.withOpacity(0.3)),
          color: Colors.white,
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8.r),
              child: Image.asset(
                imagePath,
                width: 70.w,
                height: 92.h,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text: petName,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                  SizedBox(height: 4.h),
                  Row(
                    children: [
                      CustomText(
                        text: 'Breed: ',
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                        color: AppColors.textGray,
                      ),
                      CustomText(
                        text: breed,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.mainColor,
                      ),
                    ],
                  ),
                  SizedBox(height: 8.h),
                  Row(
                    children: [
                      _infoIconText(
                        icon: Icons.female, // change to male/female icon based on gender
                        text: gender,
                        iconColor: AppColors.mainColor.withOpacity(0.7),
                      ),
                      SizedBox(width: 20.w),
                      _infoIconText(
                        icon: Icons.pets,
                        text: age,
                        iconColor: AppColors.mainColor.withOpacity(0.5),
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _infoIconText({required IconData icon, required String text, required Color iconColor}) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(4.w),
          decoration: BoxDecoration(
            color: iconColor.withOpacity(0.15),
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            size: 16.sp,
            color: iconColor,
          ),
        ),
        SizedBox(width: 6.w),
        CustomText(
          text: text,
          fontSize: 12.sp,
          fontWeight: FontWeight.w500,
          color: AppColors.textGray,
        ),
      ],
    );
  }
}
