
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';


import 'package:wolf_pack/app/modules/profile/views/chnage_password.dart';
import 'package:wolf_pack/app/modules/profile/views/privacy_policy.dart';
import 'package:wolf_pack/app/modules/setting/views/contact_support_view.dart';
import 'package:wolf_pack/app/modules/setting/views/terms_of_use_view.dart';
import 'package:wolf_pack/app/uitilies/app_colors.dart';
import 'package:wolf_pack/app/uitilies/app_images.dart';

import '../../../common_widget/custom_app_bar_widget.dart';
import '../../../common_widget/menue_item.dart';
import '../../../common_widget/show_alert_dialog.dart';
import '../../../uitilies/api/app_constant.dart';
import '../../../uitilies/api/local_storage.dart';
import '../../setting/views/privacy_policy_view.dart';
import '../controllers/get_myProfile_controller.dart';
import '../controllers/porfile_image_controller.dart';
import 'all_client_view.dart';

class SettingView extends StatefulWidget {
  const SettingView({super.key});

  @override
  State<SettingView> createState() => _SettingViewState();
}

class _SettingViewState extends State<SettingView> {
  static const String _staticUrl = 'https://wa.me/9715511750018@gmail.com';
  final GetMyProfileController profileController = Get.put(GetMyProfileController());
  final HomeImageController _imageController = Get.put(HomeImageController());
  final storage = Get.put(StorageService());

  Future<void> _launchURL() async {
    final Uri uri = Uri.parse(_staticUrl);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $_staticUrl');
    }
  }

  ImageProvider<Object> _getProfileImage() {
    final localImage = _imageController.selectedImagePath.value;
    final networkImage = profileController.profileData.value.data?.profilePicture ?? '';

    if (networkImage.isNotEmpty) {
      return CachedNetworkImageProvider(networkImage);
    } else if (localImage.isNotEmpty) {
      return FileImage(File(localImage));
    } else {
      return const AssetImage(AppImages.profile);
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: screenHeight * 0.1),
            Center(
              child: Obx(
                    () => CircleAvatar(
                  radius: 55.r,
                  backgroundColor: AppColors.orangeColor,
                  backgroundImage: _getProfileImage(),
                ),
              ),
            ),
            Gap(20.h),

            // ----------------- Menu Items -----------------
            MenuItem(
              icon: Icons.people_outline,
              // assetImagePath: AppImages.Unlock,
              backgroundColor: Colors.black,
              borderRadius: BorderRadius.circular(6.r),
              title: 'All Client',
              textColor: AppColors.white,
              onTap: () => Get.to(() => AllClientsScreen()),
            ),
            Gap(20.h),
            MenuItem(
              assetImagePath: AppImages.Unlock,
              backgroundColor: Colors.black,
              borderRadius: BorderRadius.circular(6.r),
              title: 'Changed Password',
              textColor: AppColors.white,
              onTap: () => Get.to(() => ChangedPasswordView()),
            ),
            Gap(20.h),
            MenuItem(
              assetImagePath: AppImages.callReceived,
              backgroundColor: Colors.black,
              borderRadius: BorderRadius.circular(6.r),
              title: 'Contact Support',
              textColor: AppColors.white,
              onTap: _launchURL,
            ),
            Gap(20.h),
            MenuItem(
              assetImagePath: AppImages.setting,
              backgroundColor: Colors.black,
              borderRadius: BorderRadius.circular(6.r),
              title: 'Privacy Policy',
              textColor: AppColors.white,
              onTap: () => Get.to(() => SPPrivacyPolicyView()),
            ),
            Gap(20.h),
            MenuItem(
              assetImagePath: AppImages.settingSP,
              backgroundColor: Colors.black,
              borderRadius: BorderRadius.circular(6.r),
              title: 'Terms of Use',
              textColor: AppColors.white,
              onTap: () => Get.to(() => SPTermsofUseView()),
            ),
            Gap(20.h),
            MenuItem(
              assetImagePath: AppImages.Logout,
              backgroundColor: Colors.black,
              borderRadius: BorderRadius.circular(6.r),
              title: 'Log Out',
              textColor: Colors.red,
              iconColors: Colors.red,
              onTap: () {
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (_) => SignOutDialog(
                    title: 'Do you want to Log Out?',
                    onConfirm: () => profileController.logout(),
                    onCancel: () => Navigator.pop(context),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
