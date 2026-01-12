import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import 'package:wolf_pack/app/modules/onboarding/widgets/row_button_widgets.dart';
import 'package:wolf_pack/app/modules/profile/views/edite_profile.dart';
import 'package:wolf_pack/app/uitilies/app_colors.dart';
import 'package:wolf_pack/app/uitilies/app_images.dart';
import 'package:wolf_pack/app/uitilies/custom_loader.dart';

import '../../../common_widget/custom_app_bar_widget.dart';
import '../../../common_widget/custom_button.dart';
import '../../../common_widget/nodata_wisgets.dart';
import '../../edit_profile/controllers/edit_profile_controller.dart';
import '../../edit_profile/controllers/edite_prifile_controller_sp.dart';
import '../../pet_profile/views/edit_pet_profile.dart';
import '../../pet_profile/widgets/infow_row_widgets.dart';
import '../controllers/get_myProfile_controller.dart';




class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});

  final EditProfileImageController _imageController =
  Get.put(EditProfileImageController());

  final GetMyProfileController profileController =
  Get.put(GetMyProfileController()); // 🔥 Loader fix

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: CommonAppBar(title: 'Profile', showBackButton: true),
      body: Obx(() {
        if (profileController.isLoading.value) {
          return  CustomLoader();
        }

        if (profileController.profileData.value.data == null) {
          return const Center(
              child: NoDataWidget(text: 'No profile data found'));
        }

        final data = profileController.profileData.value.data!;
        return RefreshIndicator(
          onRefresh: profileController.refreshProfile,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: EdgeInsets.all(16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Obx(() {
                    final localImage = _imageController.selectedImagePath.value;
                    final networkImage = data.profilePicture ?? '';

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
                          backgroundImage: const AssetImage(AppImages.profile),
                        ),
                        errorWidget: (context, url, error) => CircleAvatar(
                          radius: 55.r,
                          backgroundColor: AppColors.orangeColor,
                          backgroundImage: const AssetImage(AppImages.profile),
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
                Gap(40.h),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.09),
                    border: Border.all(color: AppColors.orangeColor),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        InfoRow(
                          title: 'Name',
                          value: data.name ?? "N/A",
                          iconBgColor: AppColors.borderColor,
                        ),
                        Gap(12.h),
                        InfoRow(
                          title: 'Email address',
                          value: data.email ?? "N/A",
                          iconBgColor: AppColors.borderColor,
                        ),
                        Gap(12.h),
                        InfoRow(
                          title: 'Phone Number',
                          value: data.phoneNumber ?? "N/A",
                          iconBgColor: AppColors.borderColor,
                        ),
                        Gap(12.h),
                        InfoRow(
                          title: 'About Yourself',
                          value: data.about ?? "N/A",
                          iconBgColor: AppColors.borderColor,
                        ),
                      ],
                    ),
                  ),
                ),
                Gap(40.h),
                CustomButton(
                  imagePath: AppImages.edit,
                  border: Border.all(color: AppColors.orangeColor),
                  buttonColor: AppColors.orangeColor,
                  isGradient: false,
                  titleColor: AppColors.white,
                  title: 'Edit Profile',
                  onTap: () {
                    Get.to(() => EditProfileView(
                      name: data.name ?? '',
                      email: data.email ?? '',
                      phone: data.phoneNumber ?? '',
                      about: data.about ?? '',
                      profileImage: data.profilePicture ?? '',
                    ));
                  },
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
