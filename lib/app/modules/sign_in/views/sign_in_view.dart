import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:wolf_pack/app/modules/profile/views/forget_password_view.dart';
import 'package:wolf_pack/app/uitilies/app_colors.dart';
import 'package:wolf_pack/app/uitilies/app_images.dart';
import '../../../common_widget/custom text/custom_text_widget.dart';
import '../../../common_widget/custom_button.dart';
import '../../../common_widget/custom_text_filed.dart';
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

  @override
  void initState() {
    super.initState();
    _loadSavedEmail();
  }

  void _loadSavedEmail() {
    final savedEmail = signInController.getSavedEmail();
    if (savedEmail != null && savedEmail.isNotEmpty) {
      emailController.text = savedEmail;
    }
  }

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
              // Logo
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

              // Title
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomText(
                    text: 'Sign in ',
                    color: Colors.white,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                  ),
                  CustomText(
                    text: 'and build your sales empire',
                    color: AppColors.orangeColor,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ],
              ),

              Gap(30.h),

              // Email Field
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

              // Password Field
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

              // Remember Me & Forgot Password
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Obx(() => Checkbox(
                        value: signInController.rememberMe.value,
                        onChanged: (value) {
                          signInController.toggleRememberMe();
                        },
                        activeColor: const Color(0xFF00D1FF),
                        checkColor: Colors.black,
                        side: BorderSide(color: AppColors.blue),
                      )),
                      CustomText(
                        text: 'Remember Me',
                        fontSize: 14.sp,
                        color: AppColors.blue,
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.to(() => ForgetPasswordView());
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

              // Login Button
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
