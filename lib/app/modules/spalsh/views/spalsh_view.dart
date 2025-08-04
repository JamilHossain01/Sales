import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_donation/app/routes/app_pages.dart';
import 'package:pet_donation/app/uitilies/app_images.dart';

import '../controllers/spalsh_controller.dart';

class SpalshView extends GetView<SpalshController> {
  const SpalshView({super.key});

  @override
  Widget build(BuildContext context) {
    // Navigate after 2 seconds once the widget is built
    Future.delayed(const Duration(seconds: 2), () {
      if (Get.isRegistered<SpalshController>()) {
        // Use Get.offNamed to remove splash screen from navigation stack
        Get.offNamed(Routes.ONBOARDING); // Replace with your next route name
      }
    });

    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: SizedBox(
          child: Image.asset(
            AppImages.spalsh,
            height: 428,
            width: double.infinity,
          ),
        ),
      ),
    );
  }
}
