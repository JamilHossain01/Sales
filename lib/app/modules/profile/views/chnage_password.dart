import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import 'package:pet_donation/app/common%20widget/custom_button.dart';
import 'package:pet_donation/app/common%20widget/custom_text_filed.dart';
import 'package:pet_donation/app/common%20widget/gradient.dart';
import 'package:pet_donation/app/common%20widget/custom%20text/custom_text_widget.dart';
import 'package:pet_donation/app/modules/profile/controllers/porfile_image_controller.dart';
import 'package:pet_donation/app/modules/profile/controllers/profile_controller.dart';
import 'package:pet_donation/app/uitilies/app_colors.dart';
import 'package:pet_donation/app/uitilies/app_images.dart';

import '../../../common widget/custom_app_bar_widget.dart';
import '../../../common widget/custom_dropdown_controller.dart';

class ChangedPasswordView extends StatefulWidget {
  const ChangedPasswordView({super.key});

  @override
  State<ChangedPasswordView> createState() => _ChangedPasswordViewState();
}

class _ChangedPasswordViewState extends State<ChangedPasswordView> {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      appBar: const CommonAppBar(
        title: 'Edit Profile',
      ),
      body: Stack(
        children: [
          // Top gradient fading softly to white
          GradientContainer(
            height: screenHeight * 0.2,
            width: double.infinity,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: screenHeight * 0.1),
                CustomText(
                  text: 'Current Password',
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
                Gap(4.h),
                const CustomTextField(
                  hintText: 'Current Password',
                  showObscure: true,
                ),
                Gap(12.h),
                CustomText(
                  text: 'New Password',
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
                Gap(4.h),
                const CustomTextField(
                  hintText: 'New Password',
                  showObscure: true,
                ),
                Gap(12.h),

                CustomText(
                  text: 'Confirm Password',
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
                Gap(4.h),
                const CustomTextField(
                  hintText: 'Confirm Password',
                  showObscure: true,
                ),
                Gap(40.h),
                CustomButton(title: 'Save', onTap: () {})
              ],
            ),
          ),
        ],
      ),
    );
  }
}
