import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import 'package:get/get.dart';
import 'package:pet_donation/app/common widget/common_search_bar.dart';
import 'package:pet_donation/app/common widget/custom text/custom_text_widget.dart';
import 'package:pet_donation/app/common widget/gradient.dart';
import 'package:pet_donation/app/common widget/heart_conatiner.dart';
import 'package:pet_donation/app/modules/dashboard/views/dashboard_view.dart';
import 'package:pet_donation/app/modules/explore/controllers/explore_controller.dart';
import 'package:pet_donation/app/modules/explore/views/filter_view.dart';
import 'package:pet_donation/app/modules/pet_profile_details/views/pet_profile_details_view.dart';
import 'package:pet_donation/app/uitilies/app_colors.dart';
import 'package:pet_donation/app/uitilies/app_images.dart';

import '../../../common widget/custom_app_bar_widget.dart';
import '../../../common widget/grid_item_card.dart';

class ExploreView extends GetView<ExploreController> {
  const ExploreView({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final items = [
      ItemCard(
        gender: 'Male',
        name: 'Mini',
        age: 2,
        onTap: () {
          Get.to(() => PetProfileDetailsView());
        },
      ),
      ItemCard(
        gender: 'Female',
        name: 'Bella',
        age: 3,
        onTap: () {
          Get.to(() => PetProfileDetailsView());
        },
      ),
      ItemCard(
        gender: 'Male',
        name: 'Charlie',
        age: 1,
        onTap: () {
          Get.to(() => PetProfileDetailsView());
        },
      ),
      ItemCard(gender: 'Female', name: 'Luna', age: 4,onTap: () {
        Get.to(() => PetProfileDetailsView());
      },),
      ItemCard(gender: 'Male', name: 'Max', age: 2,onTap: () {
        Get.to(() => PetProfileDetailsView());
      },),
      ItemCard(gender: 'Female', name: 'Lucy', age: 5,onTap: () {
        Get.to(() => PetProfileDetailsView());
      },),
      ItemCard(gender: 'Male', name: 'Rocky', age: 3,onTap: () {
        Get.to(() => PetProfileDetailsView());
      },),
      ItemCard(gender: 'Female', name: 'Daisy', age: 2,onTap: () {
        Get.to(() => PetProfileDetailsView());
      },),
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      appBar: CommonAppBar(
        title: 'Explore',
        showBackButton: false,
      ),
      body: Stack(
        children: [
          // Top gradient fading softly to white
          GradientContainer(
            height: screenHeight * 0.2,
            width: double.infinity,
          ),
          // UI elements over the gradient
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: screenHeight * 0.05),
                const SizedBox(height: 30),
                Row(
                  children: [
                    Expanded(child: CommonSearchbar()),
                    RoundedHeartIconContainer(
                      assetPath: AppImages.heart,
                      backgroundColor: Colors.white,
                      containerHeight: 40,
                      containerWidth: 40,
                      size: 50,
                      padding: 10,
                      borderColor: AppColors.borderColor,
                    ),
                    Gap(5.w),
                    RoundedHeartIconContainer(
                      onTap: () {
                        Get.to(FilterView());
                      },
                      assetPath: AppImages.setting,
                      containerHeight: 40,
                      containerWidth: 40,
                      backgroundColor: const Color(0xFFF3FFFA),
                      size: 40,
                      padding: 10,
                      borderColor: AppColors.borderColor,
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Expanded(
                  child: GridView.count(
                    padding: EdgeInsets.zero,
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 0.7,
                    children: items,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
