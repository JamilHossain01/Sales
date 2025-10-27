import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../../common_widget/custom text/custom_text_widget.dart';
import '../../../common_widget/custom_app_bar_widget.dart';
import '../../../common_widget/custom_button.dart';
import '../../../common_widget/custom_text_filed.dart';
import '../../../uitilies/app_colors.dart';
import '../../sign_in/views/otp_view.dart';
import '../controllers/forget_password_controller.dart';
import 'verify_otp_view.dart';

class ForgetPasswordView extends StatefulWidget {
  const ForgetPasswordView({Key? key}) : super(key: key);

  @override
  State<ForgetPasswordView> createState() => _ForgetPasswordViewState();
}

class _ForgetPasswordViewState extends State<ForgetPasswordView> {
  late final TextEditingController _emailController;
  late final ForgotPasswordController _forgotPasswordController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _forgotPasswordController = Get.put(ForgotPasswordController());
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(title: 'Verify Account'),
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              Gap(100.h),
              CustomText(
                text: 'Email address'.tr,
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
                color: AppColors.white.withOpacity(0.8),
              ),
              Gap(4.h),
              CustomTextField(
                controller: _emailController,
                hintText: 'Enter email'.tr,
                showObscure: false,
              ),
              Gap(40.h),
              Obx(() => CustomButton(
                isLoading: _forgotPasswordController.isLoading.value,
                title: 'Send Code'.tr,
                isGradient: false,
                buttonColor: AppColors.orangeColor,
                rightIcon: Icon(Icons.arrow_forward, color: Colors.white),
                onTap: () async {
                  try {
                    await _forgotPasswordController.forgotPass(
                      email: _emailController.text,
                    );
                    Get.back();
                    Get.to(() => VerifyOtpView(
                      email: _emailController.text,
                    ));
                  } catch (e) {
                    Get.snackbar('Error', 'Something went wrong'.tr);
                    print("Error: $e");
                  }
                },
              )),
            ],
          ),
        ),
      ),
    );
  }
}