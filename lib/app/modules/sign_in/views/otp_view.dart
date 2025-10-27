import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:wolf_pack/app/modules/sign_in/views/new_password.dart';
import 'package:wolf_pack/app/uitilies/app_colors.dart';
import 'package:wolf_pack/app/uitilies/app_images.dart';

import '../../../common_widget/custom text/custom_text_widget.dart';
import '../../../common_widget/custom_button.dart';
import '../../../common_widget/custom_opt_field.dart';
import '../../../common_widget/gradient.dart';


class OtpView extends GetView {
  const OtpView({super.key, required String email});

  @override
  Widget build(BuildContext context) {
    final TextEditingController _otpController = TextEditingController();
    final screenHeight = MediaQuery.of(context).size.height;
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
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
                  IconButton(onPressed: () {}, icon: Icon(Icons.arrow_back)),
                  SizedBox(height: screenHeight * 0.1),
                  CustomText(
                    text: 'Verification Code',
                    fontWeight: FontWeight.w600,
                    fontSize: 24.sp,
                  ),
                  CustomText(
                    text: 'Please enter the code we just sent to your email',
                    fontWeight: FontWeight.w500,
                    fontSize: 12.sp,
                    color: AppColors.textGray,
                  ),
                  Gap(40.h),

                  CustomOtpWidget(
                    borderRadius: 100,
                    borderColor: Color(0XFFECEEF1),
                    numberOfFields: 4,
                    // ✅ Changed to 4 digits
                    fieldWidth: width / 8,
                    controller: _otpController,
                  ),
                  Gap(40.h),


                  Center(
                    child: CustomText(
                      text: 'Didn’t receive OTP?',
                      fontWeight: FontWeight.w500,
                      fontSize: 12.sp,
                      color: AppColors.textGray,
                    ),
                  ),
                  Center(
                    child: CustomText(
                      text: 'Resend Code',
                      fontWeight: FontWeight.w500,
                      fontSize: 12.sp,
                      color: AppColors.mainColor,
                    ),
                  ),
                  Gap(40.h),
                  CustomButton(title: 'Verify', onTap: () {
                    Get.to(()=>NewPasswordView());
                  }),
                  // Add more widgets (e.g., form fields, buttons) below here
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
