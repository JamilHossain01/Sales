import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pet_donation/app/common%20widget/custom_app_bar_widget.dart';
import 'package:pet_donation/app/common%20widget/nodata_wisgets.dart';
import 'package:pet_donation/app/modules/home/controllers/image_controller.dart';
import 'package:pet_donation/app/common%20widget/custom%20text/custom_text_widget.dart';
import 'package:pet_donation/app/modules/onboarding/widgets/row_button_widgets.dart';
import 'package:pet_donation/app/modules/profile/views/edite_profile.dart';
import 'package:pet_donation/app/uitilies/app_colors.dart';
import 'package:pet_donation/app/uitilies/app_images.dart';
import 'package:pet_donation/app/uitilies/custom_loader.dart';

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
      appBar: CommonAppBar(title: 'Profile'),
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
                  return Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      CircleAvatar(
                        backgroundColor: AppColors.orangeColor,
                        radius: 55.r,
                        backgroundImage: _imageController.selectedImagePath.value.isEmpty
                            ? const AssetImage(AppImages.profile)
                            : FileImage(File(_imageController.selectedImagePath.value)) as ImageProvider,
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
