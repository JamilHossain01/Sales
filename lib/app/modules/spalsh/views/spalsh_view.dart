import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wolf_pack/app/routes/app_pages.dart';
import 'package:wolf_pack/app/uitilies/app_images.dart';

import '../controllers/spalsh_controller.dart';




class SpalshView extends GetView<SplashController> {
  const SpalshView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Obx(
              () => AnimatedOpacity(
            opacity: controller.opacity.value,
            duration: const Duration(milliseconds: 500),
            child: SizedBox(
              child: Image.asset(
                AppImages.spalsh,  // Splash image asset
                height: 428,
                width: double.infinity,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
