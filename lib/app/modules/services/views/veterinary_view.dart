import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:pet_donation/app/common%20widget/gradient.dart';
import 'package:pet_donation/app/common%20widget/heart_conatiner.dart';
import 'package:pet_donation/app/modules/services/controllers/services_controller.dart';
import 'package:pet_donation/app/uitilies/app_images.dart';
import '../../../common widget/common_search_bar.dart';
import '../../../common widget/custom text/custom_text_widget.dart';
import '../../../common widget/custom_app_bar_widget.dart';
import '../../../uitilies/app_colors.dart';
import '../../explore/views/filter_view.dart';
import '../widgets/filter.dart';
import '../widgets/pet_card.dart';

class VeterinaryView extends GetView<ServicesController> {
  const VeterinaryView({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      appBar: CommonAppBar(
        title: 'Veterinary',
        trailing:
        RoundedHeartIconContainer(
          onTap: () {
            Get.to(FilterView2());
          },
          assetPath: AppImages.setting,
          containerHeight: 35,
          containerWidth: 35,
          backgroundColor: const Color(0xFFF3FFFA),
          size: 40,
          padding: 10,
          borderColor: AppColors.borderColor,
        ),
      ),
      body: Stack(
        children: [
          // Top gradient
          GradientContainer(
            height: screenHeight * 0.2,
            width: double.infinity,
          ),
          // Main content
          Padding(
            padding: EdgeInsets.only(top: 100.h),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Search Bar

                  Gap(16.h),
                  // List of Pet24Cards
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    itemCount: 5, // Number of cards, adjust as needed
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.only(bottom: 16.h),
                        child: Pet24Card(
                          title: 'Pet24.lt',
                          icons: [
                            AppImages.cat1, AppImages.cat2, // Replace with your cat icon asset
                            // Replace with your dog icon asset
                          ],
                          description: 'Veterinary care, food, and products for pets.',
                          logoImage:  AppImages.baltukas,// New parameter for logo image
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}