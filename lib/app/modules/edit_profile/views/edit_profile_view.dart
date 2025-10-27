import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

// ✅ Only import the correct ProfileImageController
import 'package:wolf_pack/app/modules/home/controllers/image_controller.dart';

import 'package:wolf_pack/app/modules/onboarding/widgets/row_button_widgets.dart';
import 'package:wolf_pack/app/uitilies/app_colors.dart';
import 'package:wolf_pack/app/uitilies/app_images.dart';

import '../../../common_widget/custom text/custom_text_widget.dart';
import '../../../common_widget/custom_app_bar_widget.dart';
import '../../../common_widget/custom_text_filed.dart';
import '../controllers/edit_profile_controller.dart';
import '../controllers/edite_prifile_controller_sp.dart';

class EditProfileView extends GetView<EditProfileController> {
  EditProfileView({super.key});

  // ✅ Only use 1 controller
  final EditProfileImageController
  _imageController = Get.put(EditProfileImageController

    ());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar:CommonAppBar(title: 'Edit Profile'),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Profile Image Picker with Edit Icon
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
              Gap(20.h),
        
              CustomText(
                text: 'Name',
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
                color: AppColors.white.withOpacity(0.8),
                // customize style as needed
              ),
              Gap(5.h),

              CustomTextField(hintText: 'Full Name', showObscure: false,),
              Gap(10.h), CustomText(
                text: 'Email address',
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
                color: AppColors.white.withOpacity(0.8),
                // customize style as needed
              ),
              CustomTextField(hintText: 'Email', showObscure: false,),
              Gap(10.h), CustomText(
                text: 'Phone Number',
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
                color: AppColors.white.withOpacity(0.8),
                // customize style as needed
              ),
              Gap(5.h),

              CustomTextField(hintText: 'Phone Number', showObscure: false,),
              Gap(10.h), CustomText(
                text: 'About Yourself',
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
                color: AppColors.white.withOpacity(0.8),
                // customize style as needed
              ),
              Gap(5.h),

              CustomTextField(hintText: 'Enter your bio', showObscure: false,maxLines: 5,),
              Gap(10.h),
              RowButtonWidgets(),
            ],
          ),
        ),
      ),
    );
  }
}
