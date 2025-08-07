import 'dart:async';

import 'package:get/get.dart';

import '../../../routes/app_pages.dart';
import '../../../uitilies/api/app_constant.dart';
import '../../../uitilies/api/local_storage.dart';

class SpalshController extends GetxController {
  final opacity = 0.0.obs;
  final StorageService _storageService = Get.find<StorageService>();
  late final Timer _fadeTimer;
  late final Timer _navigationTimer;

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
    _navigationTimer = Timer(const Duration(seconds: 2), _navigateBasedOnAuth);
  }

  void _navigateBasedOnAuth() {
    final accessToken = _storageService.read<String>(AppConstant.accessToken);
    final role = _storageService.read<String>(AppConstant.role);

    if (accessToken == null || role == null) {
      Get.offAllNamed(Routes.SIGN_IN);
      return;
    }

    switch (role) {
      case 'USER':
        Get.offAllNamed(Routes.DASHBOARD);
        break;
      default:
        Get.offAllNamed(Routes.SIGN_IN);
    }
  }

  @override
  void onClose() {
    _fadeTimer.cancel();
    _navigationTimer.cancel();
    super.onClose();
  }
}
