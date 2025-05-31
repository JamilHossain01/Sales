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
import 'package:pet_donation/app/common%20widget/noitification_item.dart';
import 'package:pet_donation/app/common%20widget/show_alert_dialog.dart';
import 'package:pet_donation/app/modules/profile/controllers/porfile_image_controller.dart';
import 'package:pet_donation/app/modules/profile/controllers/profile_controller.dart';
import 'package:pet_donation/app/modules/profile/views/chnage_password.dart';
import 'package:pet_donation/app/uitilies/app_colors.dart';
import 'package:pet_donation/app/uitilies/app_images.dart';

import '../../../common widget/custom_app_bar_widget.dart';
import '../../../common widget/custom_dropdown_controller.dart';
import '../../../common widget/menue_item.dart';

class NotificationView extends StatefulWidget {
  const NotificationView({super.key});

  @override
  State<NotificationView> createState() => _NotificationViewState();
}

class _NotificationViewState extends State<NotificationView> {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      appBar: const CommonAppBar(
        title: 'Setting',
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
                SizedBox(height: screenHeight * 0.2),
                CustomText(text: 'Today',fontWeight: FontWeight.w500,fontSize: 16.sp,),
                Gap(4.h),
                NotificationItem(
                  title: 'Today',
                  message: 'SOS Gyvūnai Shelter sent you a new message ',
                  time: '11.00 AM',
                  message1: 'regarding your adoption application',
                ),
                Gap(16.h),

                CustomText(text: 'Yesterday',fontWeight: FontWeight.w500,fontSize: 16.sp,),
                Gap(4.h),
                NotificationItem(
                  title: 'Today',
                  message: 'SOS Gyvūnai Shelter sent you a new message ',
                  time: '11.00 AM',
                  message1: 'regarding your adoption application',
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
