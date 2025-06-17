import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pet_donation/app/common%20widget/gradient.dart';
import 'package:pet_donation/app/common%20widget/heart_conatiner.dart';
import 'package:pet_donation/app/modules/services/controllers/services_controller.dart';
import 'package:pet_donation/app/modules/services/views/veterinary_view.dart';
import '../../../common widget/common_search_bar.dart';
import '../../../common widget/custom text/custom_text_widget.dart';
import '../../../common widget/custom_app_bar_widget.dart';
import 'grooming.dart';

class ServicesView extends GetView<ServicesController> {
  const ServicesView({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      appBar:  CommonAppBar(
        title: 'Services',
        showBackButton: false,




      ),
      body: Stack(
        children: [
          // Top gradient
          GradientContainer(

          ),

          // Main content
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: screenHeight * 0.1),
                  CommonSearchbar(),

                  const SizedBox(height: 50),

                  // Menu Items
                  _buildMenuItem('assets/images/veterinary.png', 'Veterinary', () {
                    Get.to(()=>VeterinaryView());
                  }),
                  _buildMenuItem('assets/images/grooming.png', 'Grooming', () {
                    Get.to(()=>GroomingView());
                  }),
                  _buildMenuItem('assets/images/pet_stories.png', 'Online Pet Stores', () {}),
                  _buildMenuItem('assets/images/pet_stories.png', 'Pet Stores', () {}),
                  _buildMenuItem('assets/images/pet_hotels.png', 'Pet Hotels', () {}),

                  _buildMenuItem('assets/images/0thers.png', 'Others', () {}),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
  Widget _buildMenuItem(String imageAsset, String title, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 12.h),
        padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 12.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            RoundedHeartIconContainer(
              assetPath: imageAsset,
              containerHeight: 40.h,
              containerWidth: 40.h,
              size: 24.w,
              padding: 10,
              backgroundColor: const Color(0xFFF2F2F2),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                    text: title,
                    fontWeight: FontWeight.w500,
                    fontSize: 14.sp,
                    color: Colors.black,
                  ),
                  const Icon(Icons.arrow_forward_ios, size: 16),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

}
