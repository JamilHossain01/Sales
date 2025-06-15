import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pet_donation/app/common%20widget/custom%20text/custom_text_widget.dart';
import 'package:pet_donation/app/common%20widget/custom_button.dart';
import 'package:pet_donation/app/common%20widget/gradient.dart';
import 'package:pet_donation/app/routes/app_pages.dart';
import 'package:pet_donation/app/uitilies/app_colors.dart';
import 'package:pet_donation/app/uitilies/app_images.dart';

import '../controllers/log_in_controller.dart';

class LogInView extends GetView<LogInController> {
  const LogInView({super.key});

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

                RichText(
                  text: TextSpan(
                    style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: 24.sp,
                      fontWeight: FontWeight.w600
                    ),
                    children: [
                      TextSpan(text: 'Welcome to '),
                      TextSpan(
                        text: 'AMIPETA',
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.bold,
                          color: AppColors.mainColor,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                // Placeholder logo
                Container(
                  height: 150,
                  width: 150,
                  child:Image.asset(AppImages.logo)
                ),
                const SizedBox(height: 10),

                const SizedBox(height: 40),
                CustomButton(title: 'Log In', onTap: (){
                  Get.toNamed(Routes.SIGN_IN);

                }),
                const SizedBox(height: 20),
                CustomButton( isGradient: false, titleColor: AppColors.mainColor,
                    border: Border.all(color: AppColors.mainColor),
                    title: 'Create an Account', onTap: (){
                  Get.toNamed(Routes.SIGNUP);
                    }),
                Gap(10.h),


                CustomText(text: 'By signing up you confirm that you have read & agree',fontSize: 12.sp,),
                Gap(5.h),
                RichText(
                  text: TextSpan(
                    style: GoogleFonts.poppins(
                        color: Colors.black,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600
                    ),
                    children: [
                      TextSpan(text: 'to the our '),
                      TextSpan(
                        text: 'Privacy Policy',
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.bold,
                          color: AppColors.mainColor,
                        ),
                      ),TextSpan(text: 'and'),
                      TextSpan(
                        text: 'Terms & conditions',
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.bold,
                          color: AppColors.mainColor,
                        ),
                      ),
                    ],
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
