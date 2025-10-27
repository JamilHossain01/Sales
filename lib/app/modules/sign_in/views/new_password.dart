import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:wolf_pack/app/uitilies/app_colors.dart';

import '../../../common_widget/custom text/custom_text_widget.dart';
import '../../../common_widget/custom_button.dart';
import '../../../common_widget/custom_text_filed.dart';
import '../../../routes/app_pages.dart';

class NewPasswordView extends GetView {
  const NewPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.white,
      body:
      SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IconButton(onPressed: () {}, icon: Icon(Icons.arrow_back)),
            SizedBox(height: screenHeight * 0.1),
            CustomText(
              text: 'New Password',
              fontWeight: FontWeight.w600,
              fontSize: 24.sp,
            ),
            CustomText(
              text: 'New password must different from previous',
              fontWeight: FontWeight.w500,
              fontSize: 12.sp,
              color: AppColors.textGray,
            ),
            Gap(40.h),

            CustomText(
              text: 'New Password',
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
              color: Color(0XFF464646),
              // customize style as needed
            ),
            Gap(5.h),



            CustomTextField(hintText: 'password', showObscure: true),
            Gap(20.h),

            CustomText(
              text: ' Confirm Password',
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
              color: Color(0XFF464646),
              // customize style as needed
            ),
            Gap(5.h),


            CustomTextField(hintText: 'password', showObscure: true),
            Gap(40.h),



            CustomButton(title: 'Send Code', onTap: () {
              Get.toNamed(Routes.SIGN_IN);
            }),
            // Add more widgets (e.g., form fields, buttons) below here
          ],
        ),
      ),
    );
  }

}
