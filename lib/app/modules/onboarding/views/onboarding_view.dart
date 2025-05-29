import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:pet_donation/app/common%20widget/custom%20text/custom_text_widget.dart';
import 'package:pet_donation/app/common%20widget/custom_button.dart';

import '../controllers/onboarding_controller.dart';

class OnboardingView extends GetView<OnboardingController> {
  const OnboardingView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = this.controller;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Align(
              alignment: Alignment.topRight,
              child:
              TextButton(
                onPressed: () {
                  final lastIndex = controller.pages.length - 1;
                  controller.pageController.animateToPage(
                    lastIndex,
                    duration: const Duration(milliseconds: 400),
                    curve: Curves.easeInOut,
                  );
                  controller.currentPage.value = lastIndex;
                },
                child: CustomText(
                  text: 'Skip',
                  fontWeight: FontWeight.w600,
                  fontSize: 24.sp,
                ),
              ),

            ),
            Expanded(
              child: PageView.builder(
                controller: controller.pageController,
                itemCount: controller.pages.length,
                onPageChanged: controller.onPageChanged,
                itemBuilder: (context, index) {
                  final page = controller.pages[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.asset(
                              page.imageAsset,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),
                        CustomText(
                          text: page.title,
                          fontWeight: FontWeight.w600,
                          fontSize: 24.sp,
                        ),
                        const SizedBox(height: 12),
                        CustomText(
                          text: page.subtitle,
                          fontWeight: FontWeight.w400,
                          fontSize: 16.sp,
                          color: const Color(0xFF999999),
                        ),
                        const SizedBox(height: 40),
                      ],
                    ),
                  );
                },
              ),
            ),
            Obx(() {
              final isLastPage =
                  controller.currentPage.value == controller.pages.length - 1;
              return Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                child: Row(
                  children: [
                    Row(
                      children: List.generate(
                        controller.pages.length,
                            (index) {
                          final bool isActive =
                              controller.currentPage.value == index;
                          return AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            margin: const EdgeInsets.symmetric(horizontal: 4),
                            width: isActive ? 20 : 8,
                            height: 6,
                            decoration: BoxDecoration(
                              color:
                              isActive ? Colors.teal : Colors.grey.shade300,
                              borderRadius: BorderRadius.circular(
                                  isActive ? 12 : 50),
                            ),
                          );
                        },
                      ),
                    ),
                    const Spacer(),
                    SizedBox(
                      width: 160.w,
                      child: CustomButton(
                        borderRadius: 100,
                        title: isLastPage ? 'Get Started' : 'Next',
                        fontSize: 16.sp,
                        onTap: controller.nextPage,
                        isGradient: true,
                      ),
                    ),
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
