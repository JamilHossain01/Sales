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
import 'package:pet_donation/app/modules/profile/controllers/porfile_image_controller.dart';
import 'package:pet_donation/app/modules/profile/controllers/profile_controller.dart';
import 'package:pet_donation/app/uitilies/app_colors.dart';
import 'package:pet_donation/app/uitilies/app_images.dart';

import '../../../common widget/custom_app_bar_widget.dart';
import '../../../common widget/custom_dropdown_controller.dart';

class EditeProfileView extends StatefulWidget {
  const EditeProfileView({super.key});

  @override
  State<EditeProfileView> createState() => _EditeProfileViewState();
}

class _EditeProfileViewState extends State<EditeProfileView> {
  String? selectedBreed;

  final List<String> breedItems = [
    'Labrador',
    'German Shepherd',
    'Golden Retriever',
    'Bulldog',
  ];

  final ProfileImageController _imageController = Get.put(ProfileImageController());

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      appBar: const CommonAppBar(
        title: 'Edit Profile',
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
                SizedBox(height: screenHeight * 0.1),
                const SizedBox(height: 50),
                Center(
                  child: Obx(() {
                    return Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        CircleAvatar(
                          radius: 50,
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
                              color: AppColors.mainColor,
                              border: Border.all(color: Colors.white, width: 2),
                            ),
                            child: const Icon(Icons.camera_alt, color: Colors.black),
                          ),
                        ),
                      ],
                    );
                  }),
                ),
                const SizedBox(height: 10),
                Center(
                  child: CustomText(
                    text: 'Change profile picture',
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.mainColor,
                  ),
                ),
                const SizedBox(height: 30),

                CustomText(
                  text: 'Full Name',
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
                Gap(4.h),
                const CustomTextField(
                  hintText: 'Full name',
                  showObscure: false,
                ),

                const SizedBox(height: 12),

                CustomText(
                  text: 'Breed',
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
                Gap(4.h),

                SizedBox(
                  width: double.infinity,
                  height: 45.h,
                  child: CustomDropdown(
                    borderColor: AppColors.borderColor,
                    focusedBorderColor: AppColors.borderColor,

                    value: selectedBreed,
                    hint: 'Select Breed',
                    items: breedItems,
                    onChanged: (value) {
                      setState(() {
                        selectedBreed = value;
                      });
                    },
                  ),
                ),

                const SizedBox(height: 12),

                CustomText(
                  text: 'Email',
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
                Gap(4.h),

                const CustomTextField(
                  hintText: 'Email',
                  showObscure: false,
                ),

                const SizedBox(height: 12),

                CustomText(
                  text: 'Location',
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
                Gap(4.h),

                const CustomTextField(

                  hintText: 'Location',
                  showObscure: false,
                ),
                Gap(40.h),

                CustomButton(title: 'Save', onTap: (){})
              ],
            ),
          ),
        ],
      ),
    );
  }
}
