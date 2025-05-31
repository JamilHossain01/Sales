import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_donation/app/uitilies/app_colors.dart';
import 'package:pet_donation/app/uitilies/app_images.dart';

import '../../explore/views/explore_view.dart';
import '../../home/views/home_view.dart';
import '../../pet_profile/views/pet_profile_view.dart';
import '../../profile/views/profile_view.dart';
import '../../services/views/services_view.dart';
import '../../forum/views/forum_view.dart';

import '../controllers/dashboard_controller.dart';

class DashboardView extends StatelessWidget {
  final DashboardController controller = Get.put(DashboardController());

  DashboardView({super.key});

  static final List<Widget> _pages = <Widget>[
    HomeView(),
    ExploreView(),
    ServicesView(),
    ForumView(),
    PetProfileView (),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => _pages[controller.selectedIndex.value]),
      bottomNavigationBar: Obx(() {

        final currentIndex = controller.selectedIndex.value;

        return BottomNavigationBar(
          backgroundColor: Color(0XFFFFFFFF),
          currentIndex: currentIndex,
          onTap: controller.changeIndex,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: AppColors.mainColor,          // Active label color
          unselectedItemColor: Color(0XFF999999), // Inactive label color
          items: [
            BottomNavigationBarItem(
              icon: Image.asset(
                currentIndex == 0 ?  AppImages.homeInactive:AppImages.homeActive ,
                width: 24,
                height: 24,
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                currentIndex == 1 ? AppImages.exploreInactives : AppImages.exploreInactive,
                width: 24,
                height: 24,
              ),
              label: 'Explore',
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                currentIndex == 2 ? AppImages.servicesActive : AppImages.servicesInactive,
                width: 24,
                height: 24,
              ),
              label: 'Services',
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                currentIndex == 3 ? AppImages.forumActive : AppImages.forumActive ,
                width: 24,
                height: 24,
              ),
              label: 'Forum',
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                currentIndex == 4 ?  AppImages.profileInactive:AppImages.profileActive,
                width: 24,
                height: 24,
              ),
              label: 'Profile',
            ),
          ],
        );
      }),
    );
  }
}
