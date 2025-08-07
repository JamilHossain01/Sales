import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:wolf_pack/app/common%20widget/custom_button.dart';
import 'package:wolf_pack/app/common%20widget/custom%20text/custom_text_widget.dart';
import 'package:wolf_pack/app/uitilies/app_colors.dart';
import 'package:wolf_pack/app/common%20widget/custom_app_bar_widget.dart';

import '../../../common widget/custom_text_filed.dart';
import '../controllers/chnage_password_controller.dart'; // Import the controller

class ChangedPasswordView extends StatefulWidget {
  const ChangedPasswordView({super.key});

  @override
  State<ChangedPasswordView> createState() => _ChangedPasswordViewState();
}

class _ChangedPasswordViewState extends State<ChangedPasswordView> {
  bool isChecked = false;

  // TextEditingControllers for the input fields
  final TextEditingController currentPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  final ChangePasswordController changePasswordController = Get.put(ChangePasswordController());

  @override
  void dispose() {
    currentPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

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
              controller: currentPasswordController, // Attach controller
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
              controller: newPasswordController, // Attach controller
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
              controller: confirmPasswordController, // Attach controller
              hintText: 'Enter your confirm password',
              showObscure: true,
              fillColor: Colors.white.withOpacity(0.090),
            ),

            Gap(30.h),




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
                changePasswordController.passwordChange(
                  oldPassword: currentPasswordController.text,
                  newPassword: newPasswordController.text,
                  confirmPassword: confirmPasswordController.text,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}