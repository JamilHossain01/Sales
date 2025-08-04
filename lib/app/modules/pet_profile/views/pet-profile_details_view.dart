// import 'dart:io';
//
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:gap/gap.dart';
// import 'package:get/get.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:pet_donation/app/common%20widget/custom_button.dart';
// import 'package:pet_donation/app/common%20widget/gradient.dart';
// import 'package:pet_donation/app/common%20widget/custom_app_bar_widget.dart';
// import 'package:pet_donation/app/modules/pet_profile/views/edit_pet_profile.dart';
// import 'package:pet_donation/app/modules/profile/controllers/porfile_image_controller.dart';
// import 'package:pet_donation/app/uitilies/app_colors.dart';
// import 'package:pet_donation/app/uitilies/app_images.dart';
//
// import '../../../common widget/custom text/custom_text_widget.dart';
// import '../widgets/infow_row_widgets.dart';
//
// class PetdetaielsProfileView extends StatefulWidget {
//   const PetdetaielsProfileView({super.key});
//
//   @override
//   State<PetdetaielsProfileView> createState() => _PetdetaielsProfileViewState();
// }
//
// class _PetdetaielsProfileViewState extends State<PetdetaielsProfileView> {
//   final HomeImageController _imageController =
//       Get.put(HomeImageController());
//
//   final _formKey = GlobalKey<FormState>();
//
//   final TextEditingController fullNameController = TextEditingController();
//   final TextEditingController chipNumberController = TextEditingController();
//   final TextEditingController breedController = TextEditingController();
//   String? selectedGender;
//   final List<String> genderItems = ['Male', 'Female', 'Other'];
//   DateTime? selectedDate;
//
//   @override
//   void dispose() {
//     fullNameController.dispose();
//     chipNumberController.dispose();
//     breedController.dispose();
//     super.dispose();
//   }
//
//   Future<void> _selectDate(BuildContext context) async {
//     final DateTime today = DateTime.now();
//     final DateTime initialDate = selectedDate ?? DateTime(2021, 1, 1);
//
//     final DateTime? picked = await showDatePicker(
//       context: context,
//       initialDate: initialDate,
//       firstDate: DateTime(2000),
//       lastDate: today,
//     );
//     if (picked != null && picked != selectedDate) {
//       setState(() {
//         selectedDate = picked;
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final screenHeight = MediaQuery.of(context).size.height;
//
//     return Scaffold(
//       backgroundColor: Colors.white,
//       extendBodyBehindAppBar: true,
//       appBar: const CommonAppBar(
//         title: 'Pet Profile',
//       ),
//       body: Stack(children: [
//         GradientContainer(
//
//         ),
//         Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: SingleChildScrollView(
//             child: Form(
//               key: _formKey,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   SizedBox(height: screenHeight * 0.1),
//                   Center(
//                     child: Obx(() {
//                       return Stack(
//                         alignment: Alignment.bottomRight,
//                         children: [
//                           CircleAvatar(
//                             radius: 50,
//                             backgroundImage:
//                                 _imageController.selectedImagePath.value.isEmpty
//                                     ? const AssetImage(AppImages.profile)
//                                     : FileImage(File(_imageController
//                                         .selectedImagePath
//                                         .value)) as ImageProvider,
//                           ),
//                           GestureDetector(
//                             onTap: () async {
//                               final source =
//                                   await showModalBottomSheet<ImageSource>(
//                                 context: context,
//                                 builder: (_) => SafeArea(
//                                   child: Wrap(
//                                     children: [
//                                       ListTile(
//                                         leading: const Icon(Icons.camera_alt),
//                                         title: const Text('Camera'),
//                                         onTap: () => Navigator.pop(
//                                             context, ImageSource.camera),
//                                       ),
//                                       ListTile(
//                                         leading:
//                                             const Icon(Icons.photo_library),
//                                         title: const Text('Gallery'),
//                                         onTap: () => Navigator.pop(
//                                             context, ImageSource.gallery),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               );
//                               if (source != null) {
//                                 await _imageController.pickImage(source);
//                               }
//                             },
//                             child: Container(
//                               padding: const EdgeInsets.all(8),
//                               decoration: BoxDecoration(
//                                 shape: BoxShape.circle,
//                                 color: AppColors.mainColor,
//                                 border:
//                                     Border.all(color: Colors.white, width: 2),
//                               ),
//                               child: const Icon(Icons.camera_alt,
//                                   color: Colors.black),
//                             ),
//                           ),
//                         ],
//                       );
//                     }),
//                   ),
//                   const SizedBox(height: 8),
//                   Center(
//                     child: CustomText(
//                       text: 'Rina',
//                       fontSize: 12.sp,
//                       fontWeight: FontWeight.w500,
//                       color: AppColors.mainColor,
//                     ),
//                   ),
//                   Gap(4.h),
//                   Gap(40.h),
//                   Container(
//                     decoration: BoxDecoration(
//                         border: Border.all(color: AppColors.borderColor),
//                         borderRadius: BorderRadius.circular(12.r)),
//                     child: Padding(
//                       padding:
//                           const EdgeInsets.only(left: 16, top: 16, bottom: 16),
//                       child: Column(
//                         children: [
//                           InfoRow(
//                             title: 'Chip number',
//                             value: '981020000150444',
//                             assetPath: AppImages.chips,
//                             iconBgColor: AppColors.borderColor,
//                           ),
//                           Gap(12.h),
//                           InfoRow(
//                             title: 'Breed',
//                             value: 'Bichon frise',
//                             assetPath: AppImages.breed,
//                             iconBgColor: AppColors.borderColor,
//                           ),
//                           Gap(12.h),
//                           InfoRow(
//                             title: 'Gender',
//                             value: 'Male',
//                             assetPath: AppImages.genders,
//                             iconBgColor: AppColors.borderColor,
//                           ),
//                           Gap(12.h),
//                           InfoRow(
//                             title: 'Age',
//                             value: '2 years 5 months',
//                             assetPath: AppImages.ages,
//                             iconBgColor: AppColors.borderColor,
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                   Gap(4.h),
//                   Gap(40.h),
//                   CustomButton(
//                     imagePath: AppImages.edit,
//                     border: Border.all(color: AppColors.mainColor),
//                     isGradient: false,titleColor: AppColors.mainColor,
//                     title: 'Edit Profile',
//                     onTap: () {
//                       Get.to(() => EditePetProfileView());
//                       // if (_formKey.currentState!.validate()) {
//                       //   if (selectedGender == null) {
//                       //     Get.snackbar('Error', 'Please select gender',
//                       //         snackPosition: SnackPosition.BOTTOM);
//                       //     return;
//                       //   }
//                       //   if (selectedDate == null) {
//                       //     Get.snackbar('Error', 'Please select date of birth',
//                       //         snackPosition: SnackPosition.BOTTOM);
//                       //     return;
//                       //   }
//                       //   // Proceed with save logic here
//                       // }
//                     },
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         )
//       ]),
//     );
//   }
// }
