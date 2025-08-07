import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:wolf_pack/app/modules/home/model/badget_model_data.dart';
import 'package:wolf_pack/app/modules/home/widgets/badge_card_widgets.dart';
import 'package:wolf_pack/app/modules/home/widgets/target_widgets.dart';
import 'package:wolf_pack/app/uitilies/app_images.dart';

import '../../profile/controllers/get_myProfile_controller.dart';
import '../controllers/badges_controller.dart';

class BadgesView extends GetView<BadgesController> {
  const BadgesView({super.key});

  @override
  Widget build(BuildContext context) {
    final BadgesController controller = Get.put(BadgesController());
    final GetMyProfileController profileController = Get.put(GetMyProfileController());

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child:
      Obx(() {
        final badgesData = controller.badgesData.value.data;
        if (badgesData == null) {
          return const Center(child: CircularProgressIndicator());
        }

        // Build navButtons list from API data
        final navButtons = badgesData.data.map((badge) {
          return NavButtonData(
            label: badge.name ?? 'N/A',
            assetPath: badge.icon ?? '',  // Use iconPath from API
            color: Colors.white.withOpacity(0.08),
            textColor: const Color(0xFFFFB400),
          );
        }).toList();

        return BadgeProgressCard(
          iconPath: badgesData.upComingBadge?.icon ?? '',
          title: 'Your Upcoming Badge',
          badgeLabel: badgesData.upComingBadge?.name ?? 'N/A',
          progressText:
          "You've closed €${profileController.profileData.value.data?.salesCount ?? 0} "
              "of €${profileController.profileData.value.data?.monthlyTarget ?? 0} to earn this badge",
          targetCard: TargetProgressCard(
            title: 'Monthly Target',
            progressValue: (badgesData.progressToNext ?? 0).toDouble(),
            achievedText: 'Achieved: €5,000 of €10,000',
            percentageLabel: (badgesData.progressToNext ?? 50).toString(),
            footerMessage: "You're halfway there! 🎉",
          ),
          navButtons: navButtons,
        );
      }),
    );
  }
}
