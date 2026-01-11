import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:wolf_pack/app/modules/badges/views/badges_view.dart';

import 'package:wolf_pack/app/modules/home/widgets/customConainerLinaer.dart';
import 'package:wolf_pack/app/modules/home/widgets/profile_header_card.dart';
import 'package:wolf_pack/app/modules/leader_board/views/leader_board_view.dart';
import 'package:wolf_pack/app/modules/profile/controllers/get_myProfile_controller.dart';
import 'package:wolf_pack/app/modules/sales/views/sales_view.dart';
import 'package:wolf_pack/app/uitilies/app_images.dart';

import '../../../uitilies/custom_loader.dart';
import '../../profile/controllers/porfile_image_controller.dart';
import '../../sales/views/sales_screen.dart';
import '../controllers/home_controller.dart';
import '../controllers/nav_controller.dart';
import '../widgets/dash_board_content.dart';
import '../widgets/nav_button_wigets.dart';
import '../widgets/nav_item.dart';


class HomeView extends GetView<HomeController> {
  HomeView({super.key});

  final HomeImageController _imageController = Get.find();
  final NavController _navController = Get.put(NavController());
  final GetMyProfileController profileController = Get.put(GetMyProfileController());

  final List<NavItem> navItems = [
    NavItem(
      label: 'Dashboards',
      iconPath: AppImages.dashboard,
      content: DashboardContent(),
    ),
    NavItem(
      label: 'Sales',
      iconPath: AppImages.sales,
      content: SalesContent(),
    ),
    NavItem(
      label: 'Leaderboards',
      iconPath: AppImages.leaderboards,
      content: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: LeaderBoardView(),
      ),
    ),
    NavItem(
      label: 'Achievements',
      iconPath: AppImages.badges,
      content: BadgesView(),
    ),
  ];

  // Pull-to-refresh method
  Future<void> _refreshContent() async {
    await profileController.fetchMyProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
      extendBody: true,
      body: Obx(() {
        if (profileController.isLoading.value) {
          return CustomLoader();
        }

        return RefreshIndicator(
          color: Colors.amber, // Optional: change refresh indicator color
          onRefresh: _refreshContent,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(), // ensures refresh works even if content is small
            child: Column(
              children: [
                CustomGradientContainer(
                  child: ProfileHeaderCard(
                    username:
                    profileController.profileData.value.data?.name ?? "N/A",
                    rankText:
                    "Global Rank: ${profileController.profileData.value.data?.rank.toString() ?? "N/A"}",
                  ),
                ),
                navItems[_navController.activeTabIndex.value].content,
              ],
            ),
          ),
        );
      }),
    );
  }
}
