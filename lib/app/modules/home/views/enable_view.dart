import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:wolf_pack/app/common%20widget/custom_button.dart';
import 'package:wolf_pack/app/common%20widget/gradient.dart';
import 'package:wolf_pack/app/routes/app_pages.dart';
import 'package:wolf_pack/app/uitilies/app_images.dart';

import '../../../common widget/custom text/custom_text_widget.dart';
import '../../../uitilies/app_colors.dart';
import '../controllers/home_controller.dart';

class EnableView extends GetView<HomeController> {
  const EnableView({super.key});
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      body:
      Stack(
        children: [
          // Top gradient fading softly to white
          GradientContainer(

          ),


          // UI elements over the gradient
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: screenHeight * 0.1),

                CustomText(text: 'Enable Location',fontWeight: FontWeight.w600,color: Colors.black,fontSize: 20.sp,),
                const SizedBox(height: 50),
                // Placeholder logo
                Container(
                    height: 214.h,
                    width: 214.w,
                    child:Image.asset(AppImages.map)
                ),
                const SizedBox(height: 30),

                CustomText(text: 'Location',fontWeight: FontWeight.w600,color: Colors.black,fontSize: 20.sp,),

                const SizedBox(height: 10),
                CustomText(text: 'Your location services are switched off. Please',fontSize: 12.sp,color: AppColors.textGray,),
                CustomText(text: 'enable location, to help us serve better.',fontSize: 12.sp,color: AppColors.textGray,),


                const SizedBox(height: 40),
                CustomButton(title: 'Enable Location', onTap: (){
                  Get.toNamed(Routes.SIGN_IN);

                }),

              ],
            ),
          ),
        ],
      ),
    );
  }
}
