import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_donation/app/routes/app_pages.dart';
import 'package:pet_donation/app/uitilies/app_images.dart';

class OnboardingController extends GetxController {
  final pageController = PageController();
  var currentPage = 0.obs;

  final List<_OnboardPageData> pages = [
    _OnboardPageData(
      imageAsset: AppImages.image,
      title: 'Find Your Perfect Pet',
      subtitle:
          'Browse adoptable cats and dogs near you with detailed profiles and photos',
      buttonText: 'Next',
    ),
    _OnboardPageData(
      imageAsset: AppImages.image1,
      title: 'Connect with Shelters',
      subtitle:
          'Shelters manage listings and review applications to find the perfect matches',
      buttonText: 'Next',
    ),
    _OnboardPageData(
      imageAsset: AppImages.image2,
      title: 'Manage Your Pet Journey',
      subtitle:
          'Find veterinarians, pet shops, and hotels to keep your furry friend happy and healthy.',
      buttonText: 'Get Started',
    ),
  ];

  void nextPage() {
    if (currentPage.value < pages.length - 1) {
      pageController.nextPage(
          duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
    } else {
      Get.toNamed(Routes.LOG_IN);
      print('Onboarding finished');
    }
  }

  void onPageChanged(int index) {
    currentPage.value = index;
  }
}

class _OnboardPageData {
  final String imageAsset;
  final String title;
  final String subtitle;
  final String buttonText;

  _OnboardPageData({
    required this.imageAsset,
    required this.title,
    required this.subtitle,
    required this.buttonText,
  });
}
