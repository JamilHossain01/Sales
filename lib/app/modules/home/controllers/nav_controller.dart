import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:wolf_pack/app/uitilies/app_images.dart';

import '../widgets/nav_item.dart';

class NavController extends GetxController {
  var activeTabIndex = 0.obs;

  /// 🔹 Flag to indicate controller is fully initialized
  var isReady = false.obs;

  // List of nav items with label, icon, and UI content
  final List<NavItem> navItems = [
    NavItem(
      label: 'Dashboard',
      iconPath: AppImages.dashboard,
      content: const Text(
        "This is Dashboard",
        style: TextStyle(color: Colors.white),
      ),
    ),
    NavItem(
      label: 'Sales',
      iconPath: AppImages.sales,
      content: const Text(
        "This is Sales UI",
        style: TextStyle(color: Colors.white),
      ),
    ),
    NavItem(
      label: 'Leaderboards',
      iconPath: AppImages.leaderboards,
      content: const Text(
        "This is Leaderboards UI",
        style: TextStyle(color: Colors.white),
      ),
    ),
    NavItem(
      label: 'Achievements',
      iconPath: AppImages.badges,
      content: const Text(
        "This is Badges UI",
        style: TextStyle(color: Colors.white),
      ),
    ),
  ];

  @override
  void onInit() {
    super.onInit();
    isReady.value = true;
  }

  void changeTab(int index) {
    activeTabIndex.value = index;
  }
}
