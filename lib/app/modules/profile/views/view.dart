import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wolf_pack/app/common%20widget/custom_app_bar_widget.dart';
import 'package:wolf_pack/app/common%20widget/nodata_wisgets.dart';
import 'package:wolf_pack/app/modules/home/controllers/image_controller.dart';
import 'package:wolf_pack/app/common%20widget/custom%20text/custom_text_widget.dart';
import 'package:wolf_pack/app/modules/onboarding/widgets/row_button_widgets.dart';
import 'package:wolf_pack/app/modules/profile/views/edite_profile.dart';
import 'package:wolf_pack/app/uitilies/app_colors.dart';
import 'package:wolf_pack/app/uitilies/app_images.dart';
import 'package:wolf_pack/app/uitilies/custom_loader.dart';

import '../../../common widget/custom_button.dart';
import '../../edit_profile/controllers/edit_profile_controller.dart';
import '../../edit_profile/controllers/edite_prifile_controller_sp.dart';
import '../../pet_profile/views/edit_pet_profile.dart';
import '../../pet_profile/widgets/infow_row_widgets.dart';
import '../controllers/get_myProfile_controller.dart';

class ProfilePage extends GetView<EditProfileController> {
  ProfilePage({super.key});

  final EditProfileImageController _imageController =
  Get.put(EditProfileImageController());
  final GetMyProfileController profileController =
  Get.put(GetMyProfileController());

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: CommonAppBar(title: 'Profile',showBackButton: false,),
      body: Obx(() {
        if (profileController.isLoading.value) {
          return  Center(child: CustomLoader());
        }

        if (profileController.profileData == null) {
          return const Center(child: NoDataWidget(text: 'No profile data found'));
        }

        return SingleChildScrollView(
          padding: EdgeInsets.all(16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
              Gap(40.h),
              Container(
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.09),
                  border: Border.all(color: AppColors.orangeColor),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 16, top: 16, bottom: 16),
                  child: Column(
                    children: [
                      InfoRow(
                        title: 'Name',
                        value: profileController.profileData.value.data?.name ?? "N/A",
                        iconBgColor: AppColors.borderColor,
                      ),
                      Gap(12.h),
                      InfoRow(
                        title: 'Email address',
                        value: profileController.profileData.value.data?.email ?? "N/A",
                        iconBgColor: AppColors.borderColor,
                      ),
                      Gap(12.h),
                      InfoRow(
                        title: 'Phone Number',
                        value: profileController.profileData.value.data?.phoneNumber ?? "N/A",
                        iconBgColor: AppColors.borderColor,
                      ),
                      Gap(12.h),
                      InfoRow(
                        title: 'About Yourself',
                        value: profileController.profileData.value.data?.about ?? "N/A",
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
                  final data = profileController.profileData.value.data;
                  if (data != null) {
                    Get.to(() => EditProfileView(
                      name: data.name ?? '',
                      email: data.email ?? '',
                      phone: data.phoneNumber ?? '',
                      about: data.about ?? '',
                    ));
                  } else {
                    Get.snackbar('Error', 'Profile data is not available');
                  }
                },
              ),
            ],
          ),
        );
      }),
    );
  }}
