import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';


import '../uitilies/app_colors.dart';
import 'custom text/custom_text_widget.dart';
import 'custom_app_bar_widget.dart';
import 'custom_button.dart';

class SupportConfirmationScreen extends StatelessWidget {
  SupportConfirmationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.btnBorderColor,
      appBar: CommonAppBar(title:'Support' ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                // Success Icon
                Container(
                  height: 80,
                  width: 80,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.mainColor.withOpacity(0.2),
                  ),
                  child: Icon(
                    Icons.check_circle,
                    color: AppColors.mainColor,
                    size: 50,
                  ),
                ),
                // Confirmation Message
                CustomText(
                  text: 'Thank You!',
                  fontSize: 32,
                  fontWeight: FontWeight.w700,
                  color: AppColors.mainColor,
                ),
                CustomText(
                  text:
                  'Your support message has been successfully sent. Our team will get back to you within 48 hours.',
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: AppColors.white,
                  textAlign: TextAlign.center,
                ),
              Gap(50.h),

                // Back to Support or Home Button
                CustomButton(
                  isGradient: false,
                  buttonColor: AppColors.orangeColor,
                  titleColor: AppColors.white,
                  title: 'Back to Support',
                  onTap: () {
                    // Navigate back to SupportScreen or another relevant screen
                    Get.back(); // Or Get.off(() => SupportScreen());
                  },
                ),


                Gap(10.h),
                // Optional: Link to Home
                GestureDetector(
                  onTap: () {
                    // Navigate to home or another main screen
                    // Get.offAll(()=> LocationRadiusScreen()); // Adjust route name as per your app
                  },
                  child: CustomText(
                    text: 'Return to Home',
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppColors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}