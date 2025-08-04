
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pet_donation/app/common%20widget/custom%20text/custom_text_widget.dart';
import 'package:pet_donation/app/modules/badges/views/badges_view.dart';

import 'package:pet_donation/app/modules/home/widgets/customConainerLinaer.dart';
import 'package:pet_donation/app/modules/home/widgets/profile_header_card.dart';
import 'package:pet_donation/app/modules/leader_board/views/leader_board_view.dart';
import 'package:pet_donation/app/modules/sales/views/sales_view.dart';
import 'package:pet_donation/app/uitilies/app_images.dart';

import '../../profile/controllers/porfile_image_controller.dart';
import '../controllers/home_controller.dart';
import '../controllers/nav_controller.dart';
import '../widgets/dash_board_content.dart';
import '../widgets/nav_button_wigets.dart';
import '../widgets/nav_item.dart';

class HomeView extends GetView<HomeController> {
  HomeView({super.key});

  final HomeImageController _imageController = Get.find(); // Use Get.find() if already put before
  final NavController _navController = Get.put(NavController());

  final List<NavItem> navItems = [
    NavItem(
      label: 'Dashboard',
      iconPath: AppImages.dashboard,
      content: DashboardContent(),
    ),
    NavItem(
      label: 'Sales',
      iconPath: AppImages.sales,
      content:SalesView(),
    ),
    NavItem(
      label: 'Leaderboards',
      iconPath: AppImages.leaderboards,
      content: LeaderBoardView(),
    ),
    NavItem(
      label: 'Badges',
      iconPath: AppImages.badges,
      content:BadgesView(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        child: Column(
          children: [
            CustomGradientContainer(
              child: ProfileHeaderCard(
                username: "Alex Thompson",
                leagueText: "Silver League",
                rankText: "Global Rank: #35",
              ),
            ),

            /// Show Active Content
            Obx(() => navItems[_navController.activeTabIndex.value].content),
          ],
        ),
      ),
    );
  }
}
