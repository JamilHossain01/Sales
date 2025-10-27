import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';


import '../../../common_widget/custom text/custom_text_widget.dart';
import '../../../common_widget/custom_app_bar_widget.dart';
import '../../../common_widget/custom_button.dart';
import '../../../common_widget/custom_text_filed.dart';
import '../../../uitilies/app_colors.dart';
import '../controllers/contact_support_controller.dart';

class ContactSupportView extends StatefulWidget {
  ContactSupportView({super.key});

  @override
  State<ContactSupportView> createState() => _ContactSupportViewState();
}

class _ContactSupportViewState extends State<ContactSupportView> {
  bool isChecked = false;

  // Define TextEditingControllers for each field
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController messageController = TextEditingController();
  final SupportController controller = Get.put(SupportController());


  @override
  void dispose() {
    // Clean up controllers when the widget is disposed
    nameController.dispose();
    emailController.dispose();
    messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
      appBar: const CommonAppBar(
        title: 'Contact Support',
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: screenHeight * 0.1),

            /// Name
            CustomText(
              text: 'Name',
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
              color: Colors.white.withOpacity(0.70),
            ),
            Gap(5.h),
            CustomTextField(
              controller: nameController, // Attach controller
              hintText: 'Enter your Name',
              showObscure: false,
              fillColor: Colors.white.withOpacity(0.090),
            ),

            Gap(12.h),

            /// Email Address
            CustomText(
              text: 'Email Address',
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
              color: Colors.white.withOpacity(0.70),
            ),
            Gap(5.h),
            CustomTextField(
              controller: emailController, // Attach controller
              hintText: 'Enter your email address',
              showObscure: false,
              fillColor: Colors.white.withOpacity(0.090),
            ),

            Gap(12.h),

            /// Message
            CustomText(
              text: 'Message',
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
              color: Colors.white.withOpacity(0.70),
            ),
            Gap(5.h),
            CustomTextField(
              controller: messageController, // Attach controller
              maxLines: 5,
              hintText: 'Enter your message here....',
              showObscure: false,
              fillColor: Colors.white.withOpacity(0.090),
            ),

            Gap(20.h),

            Obx(() => CustomButton(
              isLoading:controller.isLoading.value,
              isGradient: false,
              buttonColor: AppColors.orangeColor,
              rightIcon: Icon(
                Icons.arrow_forward,
                color: AppColors.white,
              ),
              title: 'Submit',
              onTap: controller.isLoading.value
                  ? null
                  : () async {
                await controller.supportMessageSend(
                  name: nameController.text,
                  email: emailController.text,
                  message: messageController.text,
                  controller: nameController, // Pass one controller (as per original code)
                );
              },
            )),
          ],
        ),
      ),
    );
  }
}