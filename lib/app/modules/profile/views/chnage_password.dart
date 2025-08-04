import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import 'package:pet_donation/app/common%20widget/custom_button.dart';
import 'package:pet_donation/app/common%20widget/custom%20text/custom_text_widget.dart';
import 'package:pet_donation/app/uitilies/app_colors.dart';
import 'package:pet_donation/app/common%20widget/custom_app_bar_widget.dart';

import '../../../common widget/custom_text_filed.dart';

class ChangedPasswordView extends StatefulWidget {
  const ChangedPasswordView({super.key});

  @override
  State<ChangedPasswordView> createState() => _ChangedPasswordViewState();
}

class _ChangedPasswordViewState extends State<ChangedPasswordView> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
      appBar: const CommonAppBar(
        title: 'Change Password',
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: screenHeight * 0.1),

            /// Current Password
            CustomText(
              text: 'Current Password',
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
              color: Colors.white.withOpacity(0.70),
            ),
            Gap(5.h),
            CustomTextField(
              hintText: 'Enter your password',
              showObscure: true,
              fillColor: Colors.white.withOpacity(0.090),
            ),

            Gap(12.h),

            /// New Password
            CustomText(
              text: 'New Password',
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
              color: Colors.white.withOpacity(0.70),
            ),
            Gap(5.h),
            CustomTextField(
              hintText: 'Enter your new password',
              showObscure: true,
              fillColor: Colors.white.withOpacity(0.090),
            ),

            Gap(12.h),

            /// Confirm New Password
            CustomText(
              text: 'Confirm New Password',
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
              color: Colors.white.withOpacity(0.70),
            ),
            Gap(5.h),
            CustomTextField(
              hintText: 'Enter your confirm password',
              showObscure: true,
              fillColor: Colors.white.withOpacity(0.090),
            ),

            Gap(30.h),

            /// Native Checkbox
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Checkbox(
                      value: isChecked,
                      onChanged: (value) {
                        setState(() {
                          isChecked = value!;
                        });
                      },
                      activeColor: const Color(0xFF00D1FF),
                      checkColor: Colors.black,
                      side:  BorderSide(color:AppColors.blue,
                      ),
                    ),
                    CustomText(
                      text: 'Remember Me',
                      fontSize: 14.sp,
                      color: AppColors.blue,
                    )
                  ],
                ),
                GestureDetector(
                  onTap: (){},
                  child: CustomText(
                    text: 'Forgot Password?',
                    fontSize: 14.sp,
                    color: AppColors.blue,
                  ),
                )
              ],
            ),

            Gap(20.h),

            /// Submit Button
            CustomButton(
              isGradient: false,
              buttonColor: AppColors.orangeColor,
              rightIcon: Icon(
                Icons.arrow_forward,
                color: AppColors.white,
              ),
              title: 'Update Password',
              onTap: () {
                // Add logic here if needed
              },
            ),
          ],
        ),
      ),
    );
  }
}
