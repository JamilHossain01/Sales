import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:pet_donation/app/common%20widget/custom_button.dart';
import 'package:pet_donation/app/modules/pet_survey/views/pet_survey_view.dart';

import '../../../common widget/custom text/custom_text_widget.dart';
import '../../../common widget/custom_app_bar_widget.dart';
import '../../../common widget/gradient.dart';
import '../../../uitilies/app_colors.dart';
import '../../../uitilies/app_images.dart';
import '../controllers/pet_profile_details_controller.dart';
import '../widgets/map_screen.dart';
import '../widgets/w_widgets.dart';

class PetProfileDetailsView extends GetView<PetProfileDetailsController> {
  PetProfileDetailsView({super.key});
  final PetProfileDetailsController controller = Get.put(PetProfileDetailsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
      CommonAppBar(
      title: 'Details',
      // trailing: RoundedHeartIconContainer(
      //   assetPath: AppImages.setting,
      //   containerHeight: 36,
      //   containerWidth: 36,
      //   backgroundColor: const Color(0xFFF3FFFA),
      //   size: 24,
      //   padding: 8,
      //   borderRadius: 12,
      //   borderColor: AppColors.borderColor,
      // ),
    ),
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true, // ✅ ensures gradient goes behind safe area
      body: Obx(() {
        final pet = controller.serviceDetail.value;
        final screenHeight = MediaQuery.of(context).size.height;

        return Column(
          children: [
            Stack(
                children: [
                  /// ✅ Gradient at the back
                  Positioned.fill(
                    child: Column(
                      children: [
                        GradientContainer(
                          height: screenHeight * 0.2,
                          width: double.infinity,
                        ),
                      ],
                    ),
                  ),


              Padding(
                padding: const EdgeInsets.only(top: 100),
                child: SizedBox(
                  height: 300.h,
                  child: PageView.builder(
                    controller: controller.pageController,
                    onPageChanged: (i) => controller.currentPage.value = i,
                    itemCount: pet.images.length,
                    itemBuilder: (_, i) => Image.asset(
                      pet.images[i],
                      width: double.infinity,
                      height: 310,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 12.h,
                left: 0,
                right: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(pet.images.length, (i) {
                    return Obx(() {
                      final isActive = controller.currentPage.value == i;
                      return AnimatedContainer(
                        duration: const Duration(milliseconds: 250),
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        width: isActive ? 16 : 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: isActive ? Colors.white : Colors.white54,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      );
                    });
                  }),
                ),
              ),

            ]),

            // Content section
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  // Name & location
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        text: pet.title,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w500,
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Image.asset(AppImages.pin, height: 20.h, width: 20.w),
                          const SizedBox(width: 6),
                          CustomText(
                            text: pet.location,
                            fontSize: 14.sp,
                            color: Colors.grey[600]!,
                            fontWeight: FontWeight.w400,
                          ),
                        ],
                      ),
                    ],
                  ),
                  Gap(16.h),

                  // Attribute badges
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.r),
                      color: const Color(0XFFF5F6F7),
                    ),
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          text: 'Pet Attributes:',
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                        ),
                        Gap(8.h),
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: [
                            _attributeBadge(AppImages.maineCoon, 'Maine Coon'),
                            _attributeBadge(AppImages.pet4, 'Male'),
                            _attributeBadge(AppImages.vaccinated, 'Vaccinated'),
                            _attributeBadge(AppImages.chips, 'Chipped'),
                            _attributeBadge(AppImages.neutered, 'Neutered'),
                            _attributeBadge(AppImages.kg, '3.0 kg'),
                            _attributeBadge(AppImages.kg, '3 y 5 mo'),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Gap(20.h),

                  // Description
                  CustomText(
                      textAlign: TextAlign.start,
                      text: 'Description', fontSize: 14.sp, fontWeight: FontWeight.w500),
                  Gap(8.h),
                  CustomText(
                    textAlign: TextAlign.start,
                    text: pet.description,
                    fontSize: 12.sp,
                    color: AppColors.textGray,
                  ),
                  Gap(20.h),

                  // Shelter Info
                  _shelterCard(
                    name: "SOS Gyvūnai",
                    location: "Vilnius, Lithuania",
                    phone: "+370 83 398 26",
                    email: "info@sos-gyvunai.lt",
                    website: "sos-gyvunai.lt",
                    imageLeftUrl: AppImages.pet4,
                    imageRightUrl: AppImages.pet2,
                  ),

                  Gap(20.h),
                  CustomButton(title: 'Take me home', onTap: (){
                    Get.to(()=>PetSurveyView());
                  },imagePath:  AppImages.pLegs,)


                ]),
              ),
            ),
            // MapScreen(),

          ],
        );
      }),
    );
  }

  Widget _attributeBadge(String iconPath, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(iconPath, width: 20, height: 20),
          const SizedBox(width: 6),
          CustomText(text: label, fontSize: 13.sp),
        ],
      ),
    );
  }

  Widget _shelterCard({
    required String name,
    required String location,
    required String phone,
    required String email,
    required String website,
    required String imageLeftUrl,
    required String imageRightUrl,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            offset: Offset(0, 2),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Top image row (two images side-by-side)
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            child: Row(
              children: [
                Expanded(
                  child: Image.asset(imageLeftUrl, height: 180, fit: BoxFit.cover),
                ),
                Expanded(
                  child: Image.asset(imageRightUrl, height: 180, fit: BoxFit.cover),
                ),
              ],
            ),
          ),

          /// Info content
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(text: name, fontSize: 18.sp, fontWeight: FontWeight.bold),
                Gap(16.h),
                Row(
                  children: [
                    Expanded(child: _shelterInfoRow(Icons.location_on, location)),
                    Gap(12.w),
                    Expanded(child: _shelterInfoRow(Icons.phone, phone)),
                  ],
                ),
                Gap(12.h),
                Row(
                  children: [
                    Expanded(child: _shelterInfoRow(Icons.send, email)),
                    Gap(12.w),
                    Expanded(child: _shelterInfoRow(Icons.language, website)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _shelterInfoRow(IconData icon, String text) {
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.mainColor,
          ),
          padding: const EdgeInsets.all(8),
          child: Icon(icon, size: 15, color: Colors.white),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: CustomText(
            text: text,
            fontSize: 10.sp,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }
}
