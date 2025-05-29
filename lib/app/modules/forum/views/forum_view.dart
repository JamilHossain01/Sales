
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pet_donation/app/common%20widget/custom_button.dart';
import 'package:pet_donation/app/common%20widget/gradient.dart';
import 'package:pet_donation/app/modules/forum/controllers/forum_controller.dart';
import 'package:pet_donation/app/routes/app_pages.dart';
import 'package:pet_donation/app/uitilies/app_images.dart';

import '../../../common widget/custom text/custom_text_widget.dart';
import '../../../uitilies/app_colors.dart';

class ForumView extends GetView<ForumController> {
  const ForumView({super.key});
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

                CustomText(text: 'Enable Location',fontWeight: FontWeight.w600,color: Colors.black,fontSize: 20.sp,),
                const SizedBox(height: 50),
                // Placeholder logo

              ],
            ),
          ),
        ],
      ),
    );
  }
}
