import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wolf_pack/app/uitilies/app_images.dart';

import '../uitilies/container_icon.dart';

class ItemCard extends StatelessWidget {
  final String gender;
  final String name;
  final int age;
  final VoidCallback? onTap;

  const ItemCard({
    Key? key,
    required this.gender,
    required this.name,
    required this.age, this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isFemale = gender.toLowerCase() == 'female';
    final Color genderColor = isFemale ? Colors.pink.shade200 : Colors.teal.shade300.withOpacity(0.5);

    return
      GestureDetector(
        onTap: onTap,
      child: Container(
        height: 280.h,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 8.r,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Image.asset(
                  AppImages.pet2,
                  height: 112.h,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                Positioned(
                  top: 8.h,
                  right: 8.w,
                  child: ContainerIcon(
                    assetPath: AppImages.heart,
                    backgroundColor: Colors.white,
                    size: 20,
                    padding: 9, tappedAssetPath:  AppImages.love,
                  ),
                ),
              ],
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.fromLTRB(12.w, 12.h, 12.w, 16.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(15.r),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                      child: const Text(
                        'Adoption',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      name,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.sp,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Row(
                      children: [
                        Icon(
                          isFemale ? Icons.female : Icons.male,
                          color: genderColor,
                          size: 18.sp,
                        ),
                        SizedBox(width: 6.w),
                        Text(
                          gender,
                          style: TextStyle(
                            color: genderColor,
                            fontWeight: FontWeight.w500,
                            fontSize: 14.sp,
                          ),
                        ),
                        SizedBox(width: 16.w),
                        Icon(
                          Icons.pets,
                          color: Colors.orange.shade300,
                          size: 18.sp,
                        ),
                        SizedBox(width: 6.w),
                        Text(
                          '$age yrs',
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontWeight: FontWeight.w500,
                            fontSize: 14.sp,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}



