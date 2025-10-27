import 'dart:async';
import 'package:get/get.dart';
import '../../../routes/app_pages.dart';
import '../../../uitilies/api/app_constant.dart';
import '../../../uitilies/api/local_storage.dart';



import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../routes/app_pages.dart';
import '../../../uitilies/api/app_constant.dart';
import '../../../uitilies/api/local_storage.dart';

class SplashController extends GetxController {
  final opacity = 0.0.obs;
  final StorageService _storageService = Get.put(StorageService());
  late final Timer _fadeTimer;
  Timer? _navigationTimer;

  @override
  void onInit() {
    super.onInit();
    _startFadeAnimation();
    _startNavigationCheck();
  }

  void _startFadeAnimation() {
    const fadeDuration = Duration(milliseconds: 500);
    _fadeTimer = Timer.periodic(fadeDuration, (timer) {
      if (opacity.value < 1.0) {
        opacity.value += 0.5;
      } else {
        _fadeTimer.cancel();
      }
    });
  }

  void _startNavigationCheck() {
    _navigationTimer = Timer(const Duration(seconds: 3), () async {
      await _navigateBasedOnAuth();
    });
  }

  Future<void> _navigateBasedOnAuth() async {
    final accessToken = _storageService.read<String>(AppConstant.accessToken);
    final role = _storageService.read<String>(AppConstant.role);

    debugPrint("🔑 Splash -> AccessToken: $accessToken");
    debugPrint("👤 Splash -> Role: $role");

    if (accessToken == null || accessToken.isEmpty) {
      debugPrint("❌ No token found, going to SIGN_IN");
      Get.offAllNamed(Routes.ONBOARDING);
      return;
    }

    switch (role) {
      case 'USER':
        debugPrint("✅ Role USER, going to DASHBOARD");
        Get.offAllNamed(Routes.DASHBOARD);
        break;
      case 'ADMIN':
        debugPrint("✅ Role ADMIN, going to DASHBOARD");
        Get.offAllNamed(Routes.ONBOARDING);
        break;
      case 'BUYER':
        debugPrint("✅ Role BUYER, going to ONBOARDING");
        Get.offAllNamed(Routes.ONBOARDING);
        break;
      default:
        debugPrint("⚠️ Unknown role, going to SIGN_IN");
        Get.offAllNamed(Routes.ONBOARDING);
    }
  }

  @override
  void onClose() {
    _fadeTimer.cancel();
    _navigationTimer?.cancel();
    super.onClose();
  }
}
