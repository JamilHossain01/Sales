// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:pet_donation/app/modules/pet_profile/views/pet-profile_details_view.dart';
//
// import '../../../common widget/custom_app_bar_widget.dart';
// import '../../../common widget/custom_button.dart';
// import '../../../common widget/gradient.dart';
// import '../../../uitilies/app_images.dart';
// import '../widgets/pet_profile_card.dart';
// import 'add_pet_profile.dart';
//
// class MyPetsView extends StatelessWidget {
//   const MyPetsView({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final screenHeight = MediaQuery.of(context).size.height;
//
//     return
//       Scaffold(
//         backgroundColor: Colors.white,
//         extendBodyBehindAppBar: true,
//         appBar: CommonAppBar(title: 'My Pets'),
//         body:
//         Stack(
//           children: [
//             // Top gradient fading softly to white
//             GradientContainer(
//
//             ),
//
//
//             // UI elements over the gradient
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 16),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   // SizedBox(height: screenHeight * 0.00),
//
//                   PetProfileCard(
//                     onTap: (){
//                       Get.to(()=>PetdetaielsProfileView());
//                     },
//                     petName: 'Kitty',
//                     breed: 'Maine Coon',
//                     gender: 'Male',
//                     age: '1.5 yrs',
//                     imagePath: AppImages.pet1,
//                   ),
//
//
//
//                   const SizedBox(height: 40),
//                   CustomButton(title: 'Add Another Pet', onTap: (){
//                     Get.to(()=>AddPetProfileView());
//
//                   }),
//
//                 ],
//               ),
//             ),
//           ],
//         ),
//       );
//   }
// }
