import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import 'package:get/get.dart';
import 'package:pet_donation/app/common%20widget/custom_button.dart';
import 'package:pet_donation/app/common%20widget/successfull_view.dart';
import 'package:pet_donation/app/modules/dashboard/views/dashboard_view.dart';
import 'package:pet_donation/app/uitilies/app_colors.dart';

import '../../../common widget/custom text/custom_text_widget.dart';
import '../../../common widget/gradient.dart';
import '../../../uitilies/app_images.dart';
import '../controllers/pet_survey_controller.dart';

class PetSurveyView extends GetView<PetSurveyController> {
  const PetSurveyView({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery
        .of(context)
        .size
        .height;

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
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: screenHeight * 0.1),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Image Section
                      Container(
                        height: 200.h,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.r),

                          image: DecorationImage(
                            image: AssetImage(AppImages.pet4),
                            // Replace with your image path
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      // Form Section
                      Gap(10.h),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Header Text
// Inside the main widget, replace this block:
                          Container(
                            decoration: BoxDecoration(
                              color: Color(0XFFFAFAFA),
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: 10.h,
                                  decoration: BoxDecoration(
                                    color: AppColors.mainColor,
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(8.r),
                                        topRight: Radius.circular(8.r)),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment
                                        .start,
                                    children: [
                                      CustomText(
                                        text: 'Foster Applicant Form',
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black87,
                                      ),
                                      CustomText(
                                        text: 'If you are ready to welcome a new foster child into  ',
                                        fontSize: 12.sp,
                                        color: Colors.black87,
                                      ),
                                      CustomText(
                                        text: 'your,home please fill out the questionnaire in detail.',
                                        fontSize: 12.sp,
                                        color: Colors.black87,
                                      ),
                                      Gap(8.h),
                                      CustomText(
                                        text: 'We will contact the selected candidates within a ',
                                        fontSize: 12.sp,
                                        color: Colors.black87,
                                      ),
                                      CustomText(
                                        text: 'few days and invite them to meet in person. ',
                                        fontSize: 12.sp,
                                        color: Colors.black87,
                                      ),
                                      Gap(8.h),
                                      CustomText(
                                        text: 'So, please spend 5 minutes of your valuable time.',
                                        fontSize: 12.sp,
                                        color: Colors.black87,
                                      ),
                                    ],
                                  ),
                                ),
                                Divider(color: Color(0XFFE8E8E8)),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8),
                                  child: CustomText(
                                    text: '* indicates required questions',
                                    fontSize: 12.sp,
                                    color: Colors.red,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Gap(10.h),

                          // Removed SizedBox(height: 16.h),

                          // Removed SizedBox(height: 16.h),


                          Gap(8.h),

                          _buildFormField(
                            label: '2. Link to social networks, if you use them',
                            hint: 'Your answer',
                          ),
                          Gap(8.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomText(
                                text: "Clear Form",
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500,
                                color: Color(0XFF484848),
                              ),
                              SizedBox(
                                width: 150,
                                child: CustomButton(title: 'Submit', onTap: () {
                                  Get.to(() =>
                                      CustomSuccessScreen(title: 'Submitted!',
                                          message: 'You response has been recorded. If you get shortlisted, you will be invited and you ll be able to bring the pet you selected.',
                                          onContinue: (){
                                        Get.to(DashboardView());
                                          }),);
                                }),
                              )

                            ],
                          )


                        ],
                      ),
                    ],
                  ),

                  // Placeholder logo

                ],
              ),
            ),
          ),

        ],
      ),
    );
  }

  Widget _buildFormField({required String label, required String hint}) {
    return Container(

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Column(

        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 10.h,
            decoration: BoxDecoration(
              color: AppColors.mainColor,
              borderRadius: BorderRadius.only(topLeft: Radius.circular(8.r),
                  topRight: Radius.circular(8.r)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Column(
              children: [
                CustomText(
                  text: label,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: label.contains('*') ? Colors.teal : Colors.black87,
                ),


              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [

                TextField(
                  decoration: InputDecoration(
                    hintText: hint,
                    hintStyle: TextStyle(fontSize: 12.sp, color: Colors.grey),
                    border: InputBorder.none,
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


