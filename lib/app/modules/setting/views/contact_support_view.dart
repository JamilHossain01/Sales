import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import 'package:pet_donation/app/common%20widget/custom_button.dart';
import 'package:pet_donation/app/common%20widget/custom%20text/custom_text_widget.dart';
import 'package:pet_donation/app/uitilies/app_colors.dart';
import 'package:pet_donation/app/common%20widget/custom_app_bar_widget.dart';

import '../../../common widget/custom_text_filed.dart';

class ContactSupportView extends StatefulWidget {
  const ContactSupportView({super.key});

  @override
  State<ContactSupportView> createState() => _ContactSupportViewState();
}

class _ContactSupportViewState extends State<ContactSupportView> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
      appBar: const CommonAppBar(
        title: 'Contact Support',
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: screenHeight * 0.1),

            /// Current Password
            CustomText(
              text: 'Name',
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
              color: Colors.white.withOpacity(0.70),
            ),
            Gap(5.h),
            CustomTextField(
              hintText: 'Enter your Name',
              showObscure: false,
              fillColor: Colors.white.withOpacity(0.090),
            ),

            Gap(12.h),

            /// New Password
            CustomText(
              text: 'Email Address',
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
              color: Colors.white.withOpacity(0.70),
            ),
            Gap(5.h),
            CustomTextField(
              hintText: 'Enter your email address',
              showObscure: false,
              fillColor: Colors.white.withOpacity(0.090),
            ),

            Gap(12.h),

            /// Confirm New Password
            CustomText(
              text: 'Message',
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
              color: Colors.white.withOpacity(0.70),
            ),
            Gap(5.h),
            CustomTextField(
              maxLines: 5,
              hintText: 'Enter your message here....',
              showObscure: false,
              fillColor: Colors.white.withOpacity(0.090),
            ),


            /// Native Checkbox

            Gap(20.h),

            /// Submit Button
            CustomButton(
              isGradient: false,
              buttonColor: AppColors.orangeColor,
              rightIcon: Icon(
                Icons.arrow_forward,
                color: AppColors.white,
              ),
              title: 'Submit',
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
