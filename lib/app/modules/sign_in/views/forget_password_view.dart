import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pet_donation/app/common%20widget/CustomBottomSheet.dart';
import 'package:pet_donation/app/common%20widget/custom%20text/custom_text_widget.dart';
import 'package:pet_donation/app/common%20widget/custom_button.dart';
import 'package:pet_donation/app/common%20widget/gradient.dart';
import 'package:pet_donation/app/modules/sign_in/views/otp_view.dart';
import 'package:pet_donation/app/uitilies/app_colors.dart';
import 'package:pet_donation/app/uitilies/app_images.dart';

import '../../../common widget/custom_text_filed.dart';

class ForgetPasswordView extends GetView {
  const ForgetPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          GradientContainer(

          ),
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: const Icon(Icons.arrow_back),
                  ),
                  SizedBox(height: screenHeight * 0.1),
                  CustomText(
                    text: 'Forgot Password',
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w600,
                  ),
                  SizedBox(height: 8),
                  CustomText(
                    text: 'Enter your email account to reset password',
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textGray,
                  ),
                  SizedBox(height: 40.h),
                  CustomText(
                    text: 'Email',
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                    color: const Color(0XFF464646),
                  ),
                  SizedBox(height: 4),
                  CustomTextField(
                    hintText: 'email',
                    showObscure: false,
                  ),
                  SizedBox(height: 40.h),
                  CustomButton(
                    title: 'Send Code',
                    onTap: () {
                      // TODO: Add your send code logic here
                      // e.g. call controller method or API to send reset code
                      showCustomBottomSheet(
                        context: context,
                        height: 300,
                        title: 'Check your email',
                        subtitle1: 'We have sent instructions to recover',
                        subtitle2: 'your password to your email',
                        imageAsset: AppImages.chat,
                        onDone: () {
                          Get.to(() => OtpView(email: '',));
                          Navigator.of(context).pop(); // Close the bottom sheet
                        },
                      );

                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

}
