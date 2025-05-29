import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pet_donation/app/common%20widget/check_box.dart';
import 'package:pet_donation/app/common%20widget/custom%20text/custom_text_widget.dart';
import 'package:pet_donation/app/common%20widget/custom_button.dart';
import 'package:pet_donation/app/common%20widget/custom_divider.dart';
import 'package:pet_donation/app/common%20widget/custom_text_filed.dart';
import 'package:pet_donation/app/common%20widget/gradient.dart';
import 'package:pet_donation/app/modules/sign_in/views/forget_password_view.dart';
import 'package:pet_donation/app/routes/app_pages.dart';
import 'package:pet_donation/app/uitilies/app_colors.dart';
import 'package:pet_donation/app/uitilies/app_images.dart';

import '../controllers/sign_in_controller.dart';

class SignInView extends GetView<SignInController> {
  const SignInView({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          GradientContainer(
            height: screenHeight * 0.2,
            width: double.infinity,
          ),
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconButton(onPressed: (){}, icon:Icon(Icons.arrow_back)),
                  SizedBox(height: screenHeight * 0.1),

                  CustomText(
                    text: 'Sign in to your',
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w600,
                    // optionally add fontSize, fontWeight etc in your CustomText widget
                  ),
                  SizedBox(height: 8),
                  CustomText(
                    text: 'Account',
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w600,
                    // customize style as needed
                  ),
                  SizedBox(height: 8),
                  CustomText(
                    text: 'Enter your email and password to log in ',
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textGray,
                    // customize style as needed
                  ),
                  SizedBox(height: 40.h),

                  CustomText(
                    text: 'Email',
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                    color: Color(0XFF464646),
                    // customize style as needed
                  ),
                  CustomTextField(hintText: 'email', showObscure: false),
                  Gap(10.h),
                  CustomText(
                    text: 'Password',
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                    color: Color(0XFF464646),
                    // customize style as needed
                  ),
                  CustomTextField(hintText: 'password', showObscure: true),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      LabeledCheckbox(
                        label: 'Keep me loggesd in',
                        initialValue: false,
                        onChanged: (bool newValue) {
                          print('Checkbox is now: $newValue');
                        },
                      ),
                      GestureDetector(
                        onTap: (){
                          Get.to(()=>
                            ForgetPasswordView()
                          );
                        },
                        child: CustomText(
                          text: 'Forgot Password ?',
                          fontWeight: FontWeight.w500,
                          color: AppColors.mainColor,
                        ),
                      )
                    ],
                  ),
                  CustomButton(title: 'Log In', onTap: () {
                    Get.toNamed(Routes.DASHBOARD);
                  }),
                  Gap(30.h),
                  Row(
                    children: [
                      Expanded(
                        child: Divider(
                          color: AppColors.borderColor,
                          thickness: 1,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: CustomText(
                          text: 'Or',
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          color: AppColors.borderColor,
                          thickness: 1,
                        ),
                      ),
                    ],
                  ),
                  Gap(30.h),

                  Row( mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                    Container(
                      height: 50.h,
                      width: 100.w,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.r),
                        border: Border.all(color: Color(0XFFF2F2F2)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Image.asset(AppImages.google,height: 18.h,width: 18.w,),
                      ),
                    ), Container(
                      height: 50.h,
                      width: 100.w,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.r),
                        border: Border.all(color: Color(0XFFF2F2F2)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Image.asset(AppImages.apple,height: 18.h,width: 18.w,),
                      ),
                    ), Container(
                      height: 50.h,
                      width: 100.w,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.r),
                        border: Border.all(color: Color(0XFFF2F2F2)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Image.asset(AppImages.group,height: 18.h,width: 18.w,),
                      ),
                    ),
                  ],),
                  Gap(40.h),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 80),
                    child: Center(
                      child: Row(
                        children: [
                          Center(
                            child: RichText(
                              text: TextSpan(
                                style: GoogleFonts.poppins(
                                    color: Colors.black,
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w500),
                                children: [
                                  TextSpan(
                                    text: 'Don’t have an account?',
                                    style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.btnBorderColor,
                                    ),
                                  ),

                                ],
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: (){
                              Get.toNamed(Routes.SIGNUP);
                            },
                            child: CustomText(
                              text: 'Sign Up',
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
                              color: AppColors.mainColor,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),

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
