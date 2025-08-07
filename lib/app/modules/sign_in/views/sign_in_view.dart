import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:wolf_pack/app/common%20widget/custom%20text/custom_text_widget.dart';
import 'package:wolf_pack/app/common%20widget/custom_button.dart';
import 'package:wolf_pack/app/modules/profile/views/forget_password_view.dart';
import 'package:wolf_pack/app/uitilies/app_colors.dart';
import 'package:wolf_pack/app/uitilies/app_images.dart';
import '../../../common widget/custom_text_filed.dart';
import '../controllers/log_in_controller.dart';

class SignInView extends StatefulWidget {
  const SignInView({super.key});

  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  final SignInController signInController = Get.put(SignInController());
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Image.asset(
                      AppImages.login1,
                      height: 280.h,
                      width: 200.w,
                      fit: BoxFit.cover,
                    ),
                    Image.asset(
                      AppImages.spLogo,
                      height: 100.h,
                      width: 200.w,
                    ),
                  ],
                ),
              ),
              Gap(20.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomText(
                    text: 'Sign in ',
                    color: Colors.white,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w700,
                  ),
                  CustomText(
                    text: 'and build your sales empire',
                    color: AppColors.orangeColor,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ],
              ),
              Gap(30.h),
              CustomText(
                text: 'Email address',
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
                color: AppColors.white.withOpacity(0.8),
              ),
              Gap(4.h),
              CustomTextField(
                controller: emailController,
                hintText: 'email',
                showObscure: false,
              ),
              Gap(10.h),
              CustomText(
                text: 'Password',
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
                color: AppColors.white.withOpacity(0.8),
              ),
              Gap(4.h),
              CustomTextField(
                controller: passwordController,
                hintText: 'password',
                showObscure: true,
              ),
              Gap(40.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Checkbox(
                        value: isChecked,
                        onChanged: (value) {
                          setState(() {
                            isChecked = value ?? false;
                          });
                        },
                        activeColor: const Color(0xFF00D1FF),
                        checkColor: Colors.black,
                        side: BorderSide(color: AppColors.blue),
                      ),
                      CustomText(
                        text: 'Remember Me',
                        fontSize: 14.sp,
                        color: AppColors.blue,
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.to(()=>ForgetPasswordView());
                    },
                    child: CustomText(
                      text: 'Forgot Password?',
                      fontSize: 14.sp,
                      color: AppColors.blue,
                    ),
                  ),
                ],
              ),
              Gap(40.h),
              Obx(() => CustomButton(
                title: signInController.isLoading.value ? 'Loading...' : 'Log In',
                isGradient: false,
                buttonColor: AppColors.orangeColor,
                rightIcon: Icon(Icons.arrow_forward, color: Colors.white),
                onTap: signInController.isLoading.value
                    ? null
                    : () {
                  signInController.login(
                    email: emailController.text.trim(),
                    password: passwordController.text.trim(),
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
