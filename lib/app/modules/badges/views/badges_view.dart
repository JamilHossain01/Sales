import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wolf_pack/app/modules/home/model/badget_model_data.dart';
import 'package:wolf_pack/app/modules/home/widgets/badge_card_widgets.dart';
import 'package:wolf_pack/app/modules/home/widgets/target_widgets.dart';
import 'package:wolf_pack/app/uitilies/app_images.dart';
import '../../leader_board/controllers/next_achevement_controller.dart';
import '../../profile/controllers/get_myProfile_controller.dart';
import '../controllers/badges_controller.dart';
import '../widgets/next_achive_widgets.dart';

class BadgesView extends GetView<BadgesController> {
  const BadgesView({super.key});

  @override
  Widget build(BuildContext context) {
    final BadgesController controller = Get.put(BadgesController());
    final GetMyProfileController profileController = Get.put(GetMyProfileController());
    final NextAchievementGetController nextController = Get.put(NextAchievementGetController());

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child:
      Obx(() {
        if (profileController.isLoading.value || nextController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        final profileData = profileController.profileData.value.data;
        if (profileData == null) {
          return const Center(child: Text("No profile data available"));
        }

        final achievements = profileData.myAchievements ?? [];
        final salesCount = profileData.salesCount ?? 0;
        final monthlyTarget = profileData.monthlyTarget ?? 0;

        final navButtons = achievements.map((myAch) {
          return NavButtonData(
            label: myAch.achievement?.name ?? "N/A",
            assetPath: AppImages.milestone,
            color: Colors.white.withOpacity(0.08),
            textColor: const Color(0xFFFFB400),
          );
        }).toList();

        /// Build horizontal list of next achievements dynamically
        Widget nextAchievementsWidget = nextController.nextAchievementsData.value.data.isEmpty
            ? const Center(
          child: Text(
            "No Next Achievements",
            style: TextStyle(color: Colors.white),
          ),
        )
            : SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: nextController.nextAchievementsData.value.data.map((datum) {
              return Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: NextAchievementCard(
                  title: datum.name ?? "N/A",
                  iconUrl: AppImages.milestone, // Replace with specific icon if available
                  bgColor: Colors.white.withOpacity(0.08),
                  textColor: const Color(0xFFFFB400),
                ),
              );
            }).toList(),
          ),
        );

        return BadgeProgressCard(
          iconPath: AppImages.milestone,
          title: 'Your Upcoming Badge',

          progressText:
          "Your upcoming achievement",
          targetCard: nextAchievementsWidget,
          navButtons: navButtons,
        );
      }),
    );
  }
}
