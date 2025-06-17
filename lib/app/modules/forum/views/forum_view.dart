
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:pet_donation/app/common%20widget/gradient.dart';
import 'package:pet_donation/app/modules/forum/controllers/forum_controller.dart';

import '../../../common widget/custom text/custom_text_widget.dart';
import '../../../common widget/custom_app_bar_widget.dart';

class ForumView extends GetView<ForumController> {
  const ForumView({super.key});
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar:   CommonAppBar(
        title: 'Forum',
        showBackButton: false,


      ),
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

                Center(child: CustomText(text: 'Up coming',fontWeight: FontWeight.w600,color: Colors.black,fontSize: 20.sp,)),
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
