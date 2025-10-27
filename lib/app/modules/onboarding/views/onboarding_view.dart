import 'package:action_slider/action_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import 'package:wolf_pack/app/modules/sign_in/views/sign_in_view.dart';
import 'package:wolf_pack/app/uitilies/app_colors.dart';
import 'package:wolf_pack/app/uitilies/app_images.dart';

import '../../../common_widget/custom text/custom_text_widget.dart';
import '../controllers/onboarding_controller.dart';

class OnboardingView extends GetView<OnboardingController> {
  const OnboardingView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = this.controller;

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(
          children: [
            /// Background Image
            Positioned.fill(
              child: Image.asset(
                AppImages.onBoard,
                fit: BoxFit.cover,
              ),
            ),

            /// Bottom Content
            Positioned(
              left: 0,
              right: 0,
              bottom: 40.h,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomText(
                        text: 'Rise',
                        color: AppColors.orangeColor,
                        fontSize: 36.sp,
                        fontWeight: FontWeight.w700,
                      ),
                      CustomText(
                        text: ' to the Top',
                        color: Colors.white,
                        fontSize: 36.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomText(
                        text: 'with the',
                        color: Colors.white,
                        fontSize: 36.sp,
                        fontWeight: FontWeight.w700,
                      ),
                      CustomText(
                        text: ' Wolf Pack',
                        color: AppColors.orangeColor,
                        fontSize: 36.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ],
                  ),
                  Gap(8.h),
                  CustomText(
                    text: 'Track your wins, hit your milestones, and rise as',
                    color: Colors.white,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                  ),
                  CustomText(
                    text: 'the sales closer you were born to be.',
                    color: Colors.white,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                  ),
                  Gap(40.h),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: ActionSlider.standard(
                      backgroundColor: AppColors.orangeColor,
                      toggleColor: AppColors.white,

                      icon: Icon(
                        Icons.arrow_forward,
                        color: AppColors.orangeColor,
                      ),

                      child: const Text(
                        'Swipe to Get Started',
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                      ),

                      action: (controller) async {
                        controller.loading(); // Start loading
                        await Future.delayed(const Duration(seconds: 2));
                        controller.success(); // Show success animation
                        Get.off(() => const SignInView()); // Navigate to next screen
                      },
                    ),
                  ),

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
