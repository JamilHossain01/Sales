import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pet_donation/app/common%20widget/custom%20text/custom_text_widget.dart';

import '../../../uitilies/app_images.dart';

class TrendingProvidersSection extends StatelessWidget {
  const TrendingProvidersSection({Key? key}) : super(key: key);

  static const List<String> serviceImages = [
    AppImages.service1,
    AppImages.service,
    AppImages.service2,
    AppImages.service3,AppImages.service1,
    AppImages.service,
    AppImages.service2,
    AppImages.service3,
  ];

  static const List<String> serviceNames = [
    "Veterinary",
    "Grooming",
    "Pet stores",
    "Pet Hotels",
    "Veterinary",
    "Grooming",
    "Pet stores",
    "Pet Hotels",
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 90.h, // increased height to fit text below image
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: serviceImages.length,
        itemBuilder: (context, index) {
          final image = serviceImages[index];
          final name = serviceNames[index];

          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 4.h),
            child: Column(
              children: [
                Container(
                  width: 60.w,
                  height: 55.h,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(100.r),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.08),
                        offset: const Offset(0, 0),
                        blurRadius: 24.r,
                        spreadRadius: 0,
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Image.asset(
                      image,
                      width: 24.w,
                      height: 24.h,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(height: 6.h),
                CustomText(
                  text: name,
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w400,
                  color: Colors.black87,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
