import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pet_donation/app/uitilies/app_images.dart';

import '../../../common widget/heart_conatiner.dart';

class AdoptionCard extends StatelessWidget {
  final String type;
  final String name;
  final String gender;
  final int age;
  final String imagePath;

  const AdoptionCard({
    Key? key,
    required this.type,
    required this.name,
    required this.gender,
    required this.age,
    required this.imagePath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color genderColor = gender.toLowerCase() == 'female' ? Colors.pink.shade200 : Colors.teal.shade300;

    return Container(
      height: 250.h,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8.r,
            offset: Offset(0, 3.h),
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
                imagePath,
                height: 112.h,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              Positioned(
                top: 8.h,
                right: 8.w,
                child: RoundedHeartIconContainer(
                  assetPath: AppImages.heart,
                  backgroundColor: Colors.white,
                  size: 20,
                  padding: 6,
                ),


              ),
            ],
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.fromLTRB(12.w, 12.h, 12.w, 10.h),
              child: SingleChildScrollView(
                physics: const NeverScrollableScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(15.r),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                      child: Text(
                        type,
                        style: TextStyle(
                          fontSize: 12.sp,
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
                          gender.toLowerCase() == 'female' ? Icons.female : Icons.male,
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
          ),
        ],
      ),
    );
  }
}
