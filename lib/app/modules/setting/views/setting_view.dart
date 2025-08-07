import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import 'package:get/get.dart';
import 'package:wolf_pack/app/common%20widget/custom_app_bar_widget.dart';
import 'package:wolf_pack/app/common%20widget/gradient.dart';
import 'package:wolf_pack/app/common%20widget/menue_item.dart';
import 'package:wolf_pack/app/common%20widget/show_alert_dialog.dart';
import 'package:wolf_pack/app/modules/profile/views/chnage_password.dart';
import 'package:wolf_pack/app/uitilies/app_images.dart';

import '../controllers/setting_controller.dart';

class SettingView extends GetView<SettingController> {
  const SettingView({super.key});
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

          ),

          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: screenHeight * 0.1),
                MenuItem(
                  assetImagePath: AppImages.setting1,
                  backgroundColor: Color(0XFFF8F8F8),
                  borderRadius: BorderRadius.circular(6.r),
                  title: 'Changed Password',
                  onTap: () {
                    Get.to(()=>ChangedPasswordView());
                  },
                ),
                Gap(20.h),
                MenuItem(
                  backgroundColor: Color(0XFFF8F8F8),
                  borderRadius: BorderRadius.circular(6.r),
                  assetImagePath: AppImages.delete,
                  title: 'Delete',
                  onTap: () {
                    showDialog(

                      context:context,
                      barrierDismissible: false,
                      builder: (_) => SignOutDialog(
                        title: 'Do you want to delete your profile?',
                        onConfirm: () {
                          // Sign out logic here
                        },
                        onCancel: () {
                          // Optional cancel logic
                        },
                      ),
                    );

                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
