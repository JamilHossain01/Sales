// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
//
// import 'package:get/get.dart';
// import 'package:wolf_pack/app/common%20widget/custom_app_bar_widget.dart';
// import 'package:wolf_pack/app/common%20widget/custom_button.dart';
// import 'package:wolf_pack/app/common%20widget/gradient.dart';
// import 'package:wolf_pack/app/modules/pet_profile/views/add_pet_profile.dart';
// import 'package:wolf_pack/app/uitilies/app_images.dart';
//
// import '../../../common widget/custom text/custom_text_widget.dart';
// import '../../../uitilies/app_colors.dart';
// import '../controllers/pet_profile_controller.dart';
//
// class PetProfileView extends GetView<PetProfileController> {
//   const PetProfileView({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final screenHeight = MediaQuery.of(context).size.height;
//
//     return Scaffold(
//       backgroundColor: Colors.white,
//       extendBodyBehindAppBar: true,
//       appBar: CommonAppBar(
//         title: 'My Pets',
//         showBackButton: false,
//       ),
//       body: Stack(
//         children: [
//           // Top gradient fading softly to white
//           GradientContainer(
//
//           ),
//
//           Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//
//                 ClipOval(
//                   child: Container(
//                       height: 120.h,
//                       width: 120.w,
//                       child: Image.asset(
//                         AppImages.pet1,
//                         fit: BoxFit.cover,
//                       )),
//                 ),
//                 const SizedBox(height: 30),
//
//                 CustomText(
//                   text: "Let's meet your furry friend!",
//                   fontWeight: FontWeight.w600,
//                   color: Colors.black,
//                   fontSize: 20.sp,
//                 ),
//
//                 const SizedBox(height: 10),
//                 CustomText(
//                   text: "You haven't added any pet profiles. Tap",
//                   fontSize: 12.sp,
//                   color: AppColors.textGray,
//                 ),
//                 CustomText(
//                   text: 'the button below to add your furry friend',
//                   fontSize: 12.sp,
//                   color: AppColors.textGray,
//                 ),
//
//                 const SizedBox(height: 40),
//                 CustomButton(
//                     title: 'Add Your Pet',
//                     onTap: () {
//                       Get.to(() => AddPetProfileView());
//                     }),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
