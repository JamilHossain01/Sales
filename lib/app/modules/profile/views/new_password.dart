import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:pet_donation/app/common%20widget/custom_button.dart';
import 'package:pet_donation/app/common%20widget/custom_text_filed.dart';
import 'package:pet_donation/app/uitilies/app_colors.dart';
import '../../../common widget/custom text/custom_text_widget.dart';
import '../../../common widget/custom_app_bar_widget.dart';
import '../controllers/new_paasword_controller.dart';

class MakeNewPassword extends StatefulWidget {
  const MakeNewPassword({Key? key}) : super(key: key);

  @override
  State<MakeNewPassword> createState() => _MakeNewPasswordState();
}

class _MakeNewPasswordState extends State<MakeNewPassword> {
  late final TextEditingController _newPasswordController;
  late final TextEditingController _confirmPasswordController;
  final NewPasswordController passwordController = Get.put(NewPasswordController());

  @override
  void initState() {
    super.initState();
    _newPasswordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(title: 'New Password'),
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
                text: 'New Password'.tr,
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
                color: AppColors.white.withOpacity(0.8),
              ),
              Gap(4.h),
              CustomTextField(
                controller: _newPasswordController,
                hintText: 'Enter new password'.tr,
                showObscure: true,
              ),
              Gap(16.h),
              CustomText(
                text: 'Confirm Password'.tr,
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
                color: AppColors.white.withOpacity(0.8),
              ),
              Gap(4.h),
              CustomTextField(
                controller: _confirmPasswordController,
                hintText: 'Confirm your password'.tr,
                showObscure: true,
              ),
              Gap(40.h),
              Obx(() => CustomButton(
                isLoading: passwordController.isLoading.value,
                title: 'Reset Password'.tr,
                isGradient: false,
                buttonColor: AppColors.orangeColor,
                rightIcon: Icon(Icons.arrow_forward, color: Colors.white),
                onTap: () async {
                  await passwordController.setNewPassword(
                    password: _newPasswordController.text,
                    confirmPassword: _confirmPasswordController.text,
                  );
                },
              )),
            ],
          ),
        ),
      ),
    );
  }
}