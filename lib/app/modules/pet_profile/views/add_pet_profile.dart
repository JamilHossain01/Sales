import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pet_donation/app/common%20widget/custom_button.dart';
import 'package:pet_donation/app/common%20widget/custom_dropdown_controller.dart';
import 'package:pet_donation/app/common%20widget/custom_text_filed.dart';
import 'package:pet_donation/app/common%20widget/gradient.dart';
import 'package:pet_donation/app/common%20widget/custom_app_bar_widget.dart';
import 'package:pet_donation/app/modules/pet_profile/views/my_pets_view.dart';
import 'package:pet_donation/app/modules/profile/controllers/porfile_image_controller.dart';
import 'package:pet_donation/app/uitilies/app_colors.dart';
import 'package:pet_donation/app/uitilies/app_images.dart';

import '../../../common widget/custom text/custom_text_widget.dart';

class AddPetProfileView extends StatefulWidget {
  const AddPetProfileView({super.key});

  @override
  State<AddPetProfileView> createState() => _AddPetProfileViewState();
}

class _AddPetProfileViewState extends State<AddPetProfileView> {
  final ProfileImageController _imageController = Get.put(ProfileImageController());

  final _formKey = GlobalKey<FormState>();

  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController chipNumberController = TextEditingController();
  final TextEditingController breedController = TextEditingController();
  String? selectedGender;
  final List<String> genderItems = ['Male', 'Female', 'Other'];
  DateTime? selectedDate;

  @override
  void dispose() {
    fullNameController.dispose();
    chipNumberController.dispose();
    breedController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime today = DateTime.now();
    final DateTime initialDate = selectedDate ?? DateTime(2021, 1, 1);

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(2000),
      lastDate: today,
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      appBar: const CommonAppBar(
        title: 'Add Pet Profile',
      ),
      body: Stack(
        children: [
          SizedBox(
            width: double.infinity,
            child: Image.asset(AppImages.gradients),
          ),
      Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: screenHeight * 0.1),
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
                const SizedBox(height: 8),
                Center(
                  child: CustomText(
                    text: 'Add profile picture',
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.mainColor,
                  ),
                ),
                const SizedBox(height: 24),
                CustomText(
                  text: 'Full Name',
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textFieldColor,
                ),
                Gap(4.h),
                CustomTextField(
                  controller: fullNameController,
                  hintText: 'Enter full name',
                  showObscure: false,
                  validator: (val) => val == null || val.isEmpty ? 'Please enter full name' : null,
                ),
                const SizedBox(height: 12),
                CustomText(
                  text: 'Chip number',
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textFieldColor,
                ),
                Gap(4.h),
                CustomTextField(
                  controller: chipNumberController,
                  hintText: 'Enter chip number',
                  keyboardType: TextInputType.number,
                  showObscure: false,
                  validator: (val) => val == null || val.isEmpty ? 'Please enter chip number' : null,
                ),
                const SizedBox(height: 12),
                CustomText(
                  text: 'Breed',
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textFieldColor,
                ),
                Gap(4.h),
                CustomTextField(
                  controller: breedController,
                  hintText: 'Enter breed',
                  showObscure: false,
                  validator: (val) => val == null || val.isEmpty ? 'Please enter breed' : null,
                ),
                const SizedBox(height: 12),
                CustomText(
                  text: 'Gender',
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textFieldColor,
                ),
                Gap(4.h),
                SizedBox(
                  height: 45.h,
                  child: CustomDropdown(
                    borderColor: AppColors.borderColor,
                    value: selectedGender,
                    hint: 'Select Gender',
                    items: genderItems,
                    onChanged: (val) {
                      setState(() {
                        selectedGender = val;
                      });
                    },
                  ),
                ),
                const SizedBox(height: 12),
                CustomText(
                  text: 'Date of Birth',
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textFieldColor,
                ),
                Gap(4.h),
                GestureDetector(
                  onTap: () => _selectDate(context),
                  child: AbsorbPointer(
                    child: CustomTextField(
                      hintText: selectedDate == null
                          ? 'Select date of birth'
                          : '${selectedDate!.year}-${selectedDate!.month.toString().padLeft(2, '0')}-${selectedDate!.day.toString().padLeft(2, '0')}',
                      showObscure: false,
                    ),
                  ),
                ),
                Gap(40.h),
                CustomButton(
                  title: 'Save',
                  onTap: () {
                    Get.to(()=>MyPetsView());
                    // if (_formKey.currentState!.validate()) {
                    //   if (selectedGender == null) {
                    //     Get.snackbar('Error', 'Please select gender',
                    //         snackPosition: SnackPosition.BOTTOM);
                    //     return;
                    //   }
                    //   if (selectedDate == null) {
                    //     Get.snackbar('Error', 'Please select date of birth',
                    //         snackPosition: SnackPosition.BOTTOM);
                    //     return;
                    //   }
                    //   // Proceed with save logic here
                    // }
                  },
                ),
              ],
            ),
          ),
        ),
      )]
      ),
    );

  }
}
