import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import 'package:get/get.dart';
import 'package:pet_donation/app/common widget/common_search_bar.dart';
import 'package:pet_donation/app/common widget/custom text/custom_text_widget.dart';
import 'package:pet_donation/app/common widget/gradient.dart';
import 'package:pet_donation/app/common widget/heart_conatiner.dart';
import 'package:pet_donation/app/modules/explore/controllers/explore_controller.dart';
import 'package:pet_donation/app/modules/explore/views/filter_view.dart';
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
      ItemCard(gender: 'Male', name: 'Mini', age: 2),
      ItemCard(gender: 'Female', name: 'Bella', age: 3),
      ItemCard(gender: 'Male', name: 'Charlie', age: 1),
      ItemCard(gender: 'Female', name: 'Luna', age: 4),
      ItemCard(gender: 'Male', name: 'Max', age: 2),
      ItemCard(gender: 'Female', name: 'Lucy', age: 5),
      ItemCard(gender: 'Male', name: 'Rocky', age: 3),
      ItemCard(gender: 'Female', name: 'Daisy', age: 2),
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      appBar:
      CommonAppBar(
        title: 'Explore',
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
                SizedBox(height: screenHeight * 0.1),
                // CustomText(
                //   text: 'Enable Location',
                //   fontWeight: FontWeight.w600,
                //   color: Colors.black,
                //   fontSize: 20.sp,
                // ),
                const SizedBox(height: 50),
                Row(
                  children: [
                    Expanded(child: CommonSearchbar()),
                    RoundedHeartIconContainer(
                      assetPath: AppImages.heart,
                      backgroundColor: Colors.white,
                      containerHeight: 50,
                      containerWidth: 50,
                      size: 50,
                      padding: 15,
                      borderRadius: 15,
                      borderColor: AppColors.borderColor,
                    ),
                    Gap(5.w),

                    RoundedHeartIconContainer(
                      onTap: (){
                        Get.to(FilterView());
                      },
                      assetPath: AppImages.setting,
                      containerHeight: 50,
                      containerWidth: 50,
                      backgroundColor: const Color(0xFFF3FFFA),
                      size: 40,
                      padding: 12,
                      borderRadius: 15,
                      borderColor: AppColors.borderColor,
                    ),
                  ],
                ),
                Expanded(
                  child: GridView.count(
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
