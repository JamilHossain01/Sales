import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import 'package:wolf_pack/app/common%20widget/custom%20text/custom_text_widget.dart';
import 'package:wolf_pack/app/modules/home/widgets/customConainerLinaer.dart';
import 'package:wolf_pack/app/modules/home/widgets/dash_board_content.dart';
import 'package:wolf_pack/app/uitilies/app_colors.dart';
import 'package:wolf_pack/app/uitilies/app_images.dart';
import 'package:wolf_pack/app/modules/profile/controllers/porfile_image_controller.dart';
import '../controllers/nav_controller.dart';
import 'leauge_conatainer.dart';
import 'nav_button_wigets.dart';
import 'nav_item.dart'; // <-- This was missing before

class ProfileHeaderCard extends StatelessWidget {
  final String username;
  final String leagueText;
  final String rankText;

  ProfileHeaderCard({
    super.key,
    required this.username,
    required this.leagueText,
    required this.rankText,
  });

  final HomeImageController _imageController = Get.put(HomeImageController());
  final NavController _navController = Get.put(NavController());

  final List<NavItem> navItems = [
    NavItem(
      label: 'Dashboard',
      iconPath: AppImages.dashboard,
      content: DashboardContent(),
    ),
    NavItem(
      label: 'Sales',
      iconPath: AppImages.sales,
      content: CustomText(text: "This is Sales UI", color: Colors.white),
    ),
    NavItem(
      label: 'Leaderboards',
      iconPath: AppImages.leaderboards,
      content: CustomText(text: "This is Leaderboards UI", color: Colors.white),
    ),
    NavItem(
      label: 'Badges',
      iconPath: AppImages.badges,
      content: CustomText(text: "This is Badges UI", color: Colors.white),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 40.h),
        Center(
          child: Obx(() {
            return Stack(
              alignment: Alignment.bottomRight,
              children: [
                CircleAvatar(
                  backgroundColor: AppColors.orangeColor,
                  radius: 55.r,
                  backgroundImage:
                  _imageController.selectedImagePath.value.isEmpty
                      ? const AssetImage(AppImages.profile)
                      : FileImage(File(_imageController.selectedImagePath.value))
                  as ImageProvider,
                ),
                GestureDetector(
                  onTap: () async {
                    final source = await showModalBottomSheet<ImageSource>(
                      context: context,
                      builder: (_) => SafeArea(
                        child: Wrap(
                          children: [
                            ListTile(
                              leading: const Icon(Icons.camera_alt),
                              title: const Text('Camera'),
                              onTap: () => Navigator.pop(context, ImageSource.camera),
                            ),
                            ListTile(
                              leading: const Icon(Icons.photo_library),
                              title: const Text('Gallery'),
                              onTap: () => Navigator.pop(context, ImageSource.gallery),
                            ),
                          ],
                        ),
                      ),
                    );
                    if (source != null) {
                      await _imageController.pickImage(source);
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.orangeColor,
                    ),
                    child: Image.asset(
                      AppImages.edit,
                      height: 20.h,
                      width: 20.w,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            );
          }),
        ),
        SizedBox(height: 20.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 160.w,
                child: LeagueContainer(
                  text: leagueText,
                  imagePath: AppImages.trophy,
                  textColor: AppColors.orangeColor,
                ),
              ),
              SizedBox(
                width: 160.w,
                child: LeagueContainer(
                  text: rankText,
                  imagePath: AppImages.medal,
                  textColor: AppColors.orangeColor,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 16.h),
        CustomText(
          text: username,
          fontSize: 18.sp,
          fontWeight: FontWeight.w700,
          color: Colors.white,
        ),
        SizedBox(height: 20.h),

        /// Nav Button Row
        Obx(() => Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(navItems.length, (index) {
            final item = navItems[index];
            return NavButton(
              label: item.label,
              iconPath: item.iconPath,
              isActive: _navController.activeTabIndex.value == index,
              onTap: () => _navController.changeTab(index),
            );
          }),
        )),

        SizedBox(height: 20.h),

        /// Show Active Content
      ],
    );
  }
}
