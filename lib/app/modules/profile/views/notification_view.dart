
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import 'package:pet_donation/app/common%20widget/gradient.dart';
import 'package:pet_donation/app/common%20widget/custom%20text/custom_text_widget.dart';
import 'package:pet_donation/app/common%20widget/noitification_item.dart';
import 'package:pet_donation/app/common%20widget/top_bar.dart';

import '../../../common widget/custom_app_bar_widget.dart';

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
        title: 'Notifications',
      ),
      body: Stack(
        children: [
          // Top gradient fading softly to white

          GradientC(
            child: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              title: const Text('Settings'),
              centerTitle: true,
              leading: const BackButton(color: Colors.black),
            ),
          ),



          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: screenHeight * 0.1),
                CustomText(text: 'Today',fontWeight: FontWeight.w500,fontSize: 16.sp,),
                Gap(4.h),
                NotificationItem(
                  title: 'Today',
                  message: 'SOS Gyvūnai Shelter sent you a new message regarding your adoption application ',
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
