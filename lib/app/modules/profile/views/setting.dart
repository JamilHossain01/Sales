
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:wolf_pack/app/common%20widget/gradient.dart';
import 'package:wolf_pack/app/common%20widget/show_alert_dialog.dart';
import 'package:wolf_pack/app/modules/profile/views/chnage_password.dart';
import 'package:wolf_pack/app/modules/profile/views/privacy_policy.dart';
import 'package:wolf_pack/app/modules/setting/views/contact_support_view.dart';
import 'package:wolf_pack/app/modules/setting/views/terms_of_use_view.dart';
import 'package:wolf_pack/app/uitilies/app_colors.dart';
import 'package:wolf_pack/app/uitilies/app_images.dart';

import '../../../common widget/custom_app_bar_widget.dart';
import '../../../common widget/menue_item.dart';
import '../../setting/views/privacy_policy_view.dart';
import '../controllers/get_myProfile_controller.dart';
import '../controllers/porfile_image_controller.dart';

class SettingView extends StatefulWidget {

  const SettingView({super.key});

  @override
  State<SettingView> createState() => _SettingViewState();
}

class _SettingViewState extends State<SettingView> {
  static const String _staticUrl = 'https://wa.me/9715511750018@gmail.com';
  final GetMyProfileController profileController =
  Get.put(GetMyProfileController());
  final HomeImageController _imageController = Get.put(HomeImageController());



  Future<void> _launchURL() async {
    final Uri uri = Uri.parse(_staticUrl);

    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $_staticUrl');
    }
  }
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
      appBar: const CommonAppBar(
        title: 'Setting',
        showBackButton: false,
      ),
      body:          Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: screenHeight * 0.1),
            Center(
              child: Obx(() {
                final localImage = _imageController.selectedImagePath.value;
                final networkImage = profileController.profileData.value.data?.profilePicture ?? '';

                if (networkImage.isNotEmpty) {
                  return CachedNetworkImage(
                    imageUrl: networkImage,
                    imageBuilder: (context, imageProvider) => CircleAvatar(
                      radius: 55.r,
                      backgroundColor: AppColors.orangeColor,
                      backgroundImage: imageProvider,
                    ),
                    placeholder: (context, url) => CircleAvatar(
                      radius: 55.r,
                      backgroundColor: AppColors.orangeColor,
                      backgroundImage: localImage.isNotEmpty
                          ? FileImage(File(localImage))
                          : const AssetImage(AppImages.profile)
                      as ImageProvider,
                    ),
                    errorWidget: (context, url, error) => CircleAvatar(
                      radius: 55.r,
                      backgroundColor: AppColors.orangeColor,
                      backgroundImage: localImage.isNotEmpty
                          ? FileImage(File(localImage))
                          : const AssetImage(AppImages.profile)
                      as ImageProvider,
                    ),
                  );
                } else if (localImage.isNotEmpty) {
                  return CircleAvatar(
                    radius: 55.r,
                    backgroundColor: AppColors.orangeColor,
                    backgroundImage: FileImage(File(localImage)),
                  );
                } else {
                  return  CircleAvatar(
                    radius: 55,
                    backgroundColor: AppColors.orangeColor,
                    backgroundImage: AssetImage(AppImages.profile),
                  );
                }
              }),
            ),
            Gap(20.h),
            MenuItem(
              assetImagePath: AppImages.Unlock,
              backgroundColor: Colors.black,
              borderRadius: BorderRadius.circular(6.r),
              title: 'Changed Password',
              textColor: AppColors.white,

              onTap: () {
                Get.to(()=>ChangedPasswordView());
              },
            ),
            Gap(20.h),
            MenuItem(
              assetImagePath: AppImages.callReceived,
              backgroundColor: Colors.black,
              borderRadius: BorderRadius.circular(6.r),
              title: 'Contact Support',
              textColor: AppColors.white,

              onTap: () {
                _launchURL();

              },
            ),  Gap(20.h),
            MenuItem(
              assetImagePath: AppImages.setting,
              backgroundColor: Colors.black,
              borderRadius: BorderRadius.circular(6.r),
              title: 'Privacy Policy',
              textColor: AppColors.white,

              onTap: () {
                Get.to(()=>SPPrivacyPolicyView());
              },
            ),  Gap(20.h),
            MenuItem(
              assetImagePath: AppImages.settingSP,
              backgroundColor: Colors.black,
              borderRadius: BorderRadius.circular(6.r),
              title: 'Terms of Use',
              textColor: AppColors.white,

              onTap: () {
                Get.to(()=>SPTermsofUseView());
              },
            ),  Gap(20.h),
            MenuItem(
              assetImagePath: AppImages.Logout,
              backgroundColor: Colors.black,
              borderRadius: BorderRadius.circular(6.r),
              title: 'Log Out',
              textColor: Colors.red,
              iconColors: Colors.red,

              onTap: () {
                showDialog(

                  context:context,
                  barrierDismissible: false,
                  builder: (_) => SignOutDialog(
                    title: 'Do you want to your Log Out profile?',
                    onConfirm: () {
                      // Sign out logic here
                    },
                    onCancel: () {
                      // Optional cancel logic
                    },
                  ),
                );              },
            ),
          ],
        ),
      ));

  }
}
