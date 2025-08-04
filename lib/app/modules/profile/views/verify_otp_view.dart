import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:pet_donation/app/common%20widget/custom_button.dart';
import 'package:pet_donation/app/common%20widget/custom_opt_field.dart';
import 'package:pet_donation/app/common%20widget/gradient.dart';
import 'package:pet_donation/app/uitilies/app_colors.dart';
import 'package:pet_donation/app/uitilies/app_images.dart';
import '../../../common widget/custom text/custom_text_widget.dart';
import '../../../common widget/custom_app_bar_widget.dart';
import '../controllers/resend_controller.dart';
import '../controllers/verify_otp_controller.dart';

class VerifyOtpView extends StatelessWidget {
  final String email;

  const VerifyOtpView({Key? key, required this.email}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController _otpController = TextEditingController();
    final screenHeight = MediaQuery.of(context).size.height;
    final ResendEmailController resendController = Get.put(ResendEmailController());
    final VerifyOtpController _controller = Get.put(VerifyOtpController());

    return Scaffold(
      appBar: CommonAppBar(title: 'Verify Account'),
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [


              Gap(30.h),
              CustomText(
                text: 'Enter your verification Code',
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
                color: AppColors.white.withOpacity(0.8),
              ),
              Gap(10.h),
              Center(
                child: CustomText(
                  text: email.toString(),
                  fontWeight: FontWeight.w500,
                  fontSize: 18.sp,
                  color: Colors.white,
                ),
              ),
              Gap(40.h),
              Center(
                child: CustomOtpWidget(
                  borderRadius: 100,
                  borderColor: const Color(0xFFECEEF1),
                  focusedBorderColor: AppColors.orangeColor,
                  numberOfFields: 6,
                  fieldWidth: MediaQuery.of(context).size.width / 10,
                  controller: _otpController,
                ),
              ),
              Gap(40.h),
              Center(
                child: CustomText(
                  text: 'Didn’t receive OTP?'.tr,
                  fontWeight: FontWeight.w500,
                  fontSize: 12.sp,
                  color: AppColors.white.withOpacity(0.8),
                ),
              ),
              GestureDetector(
                onTap: () {
                  resendController.resendEmail(email: email);
                },
                child: Center(
                  child: CustomText(
                    text: 'Resend Code'.tr,
                    fontWeight: FontWeight.w500,
                    fontSize: 12.sp,
                    color: AppColors.mainColor,
                  ),
                ),
              ),
              Gap(40.h),
              Obx(
                    () => CustomButton(
                  isLoading: _controller.isLoading.value,
                  title: 'Verify'.tr,
                  isGradient: false,
                  buttonColor: AppColors.orangeColor,
                  rightIcon: Icon(Icons.arrow_forward, color: Colors.white),
                  onTap: _controller.isLoading.value
                      ? null
                      : () {
                    _controller.verifyOtp(_otpController.text);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}