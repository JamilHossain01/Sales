import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:wolf_pack/app/modules/profile/controllers/get_myProfile_controller.dart';
import 'package:wolf_pack/app/modules/profile/controllers/porfile_image_controller.dart';
import 'package:wolf_pack/app/modules/profile/views/notification_view.dart';
import 'package:wolf_pack/app/uitilies/app_images.dart';
import '../../home/views/home_view.dart';
import '../../profile/views/setting.dart';
import '../controllers/dashboard_controller.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({Key? key}) : super(key: key);

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  final DashboardController controller = Get.put(DashboardController());

  final GetMyProfileController profileController =
  Get.put(GetMyProfileController());

  final HomeImageController homeImageController =
  Get.put(HomeImageController());

  final List<Widget> _pages = <Widget>[
    HomeView(),
    // ProfilePage(), // commented as requested
    SettingView(),
    NotificationView(),
  ];

  final List<Map<String, String>> navItems = [
    {
      'icon': AppImages.navHomeUnselected,
      'selectedIcon': AppImages.navHomeSelected,
      'label': 'Home',
    },
    // {
    //   'icon': AppImages.navExploreSelected,
    //   'selectedIcon': AppImages.navExploreUnselected,
    //   'label': 'Profile',
    // },
    {
      'icon': AppImages.navServiceSelected,
      'selectedIcon': AppImages.navServiceUnselected,
      'label': 'Setting',
    },
    {
      'icon': AppImages.navForumSelected,
      'selectedIcon': AppImages.navForumUnselected,
      'label': 'Notification',
    },
  ];

  @override
  void initState() {
    super.initState();
    profileController.fetchMyProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Obx(() => _pages[controller.selectedIndex.value]),
      bottomNavigationBar: Obx(() {
        final currentIndex = controller.selectedIndex.value;

        return SafeArea(
          child: Container(
            margin: const EdgeInsets.only(top: 8, left: 36, right: 36),
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: const Color(0xFF1C1C1E),
              borderRadius: BorderRadius.circular(60.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.5),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(navItems.length, (index) {
                final isSelected = index == currentIndex;
                final item = navItems[index];
                final iconPath =
                isSelected ? item['selectedIcon']! : item['icon']!;

                return GestureDetector(
                  onTap: () => controller.changeIndex(index),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: isSelected ? Colors.amber : Colors.transparent,
                      shape: BoxShape.circle,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset(
                          iconPath,
                          height: 20,
                          width: 19,
                        ),
                        if (isSelected)
                          Padding(
                            padding: const EdgeInsets.only(top: 4),
                            child: Text(
                              item['label']!,
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontSize: 8.sp,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                );
              }),
            ),
          ),
        );
      }),
    );
  }
}
