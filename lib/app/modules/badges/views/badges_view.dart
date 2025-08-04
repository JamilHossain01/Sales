import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:pet_donation/app/modules/home/model/badget_model_data.dart';
import 'package:pet_donation/app/modules/home/widgets/badge_card_widgets.dart';
import 'package:pet_donation/app/modules/home/widgets/target_widgets.dart';
import 'package:pet_donation/app/uitilies/app_images.dart';

import '../controllers/badges_controller.dart';

class BadgesView extends GetView<BadgesController> {
  const BadgesView({super.key});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          BadgeProgressCard(
            title: 'Your Upcoming Badge',
            badgeLabel: 'First 10K Month',
            progressText: "You've closed €6,000 of €10,000 to earn this badge",
            targetCard: TargetProgressCard(
              title: 'Monthly Target',
              progressValue: 0.5,
              achievedText: 'Achieved: €5,000 of €10,000',
              percentageLabel: '50%',
              footerMessage: "You're halfway there! 🎉",
            ),
            navButtons: [
              NavButtonData(
                label: 'Closer of\nThe Week',
                assetPath: AppImages.milestone,
                color: Colors.white.withOpacity(0.090),
                textColor: Color(0xFFFFB400), // Highlight first one!
              ),
              NavButtonData(

                label: 'First 10K \nMonth',
                assetPath: AppImages.milestone,
                color: Colors.white.withOpacity(0.080),
                textColor: Color(0xFFFFB400).withOpacity(0.80), // Highlight first one!

              ),
              NavButtonData(
                label: '10 Deals \nClosed',
                assetPath: AppImages.milestone,
                color: Colors.white.withOpacity(0.070),
                textColor: Color(0xFFFFB400).withOpacity(0.70),// Highlight first one!

              ),
              NavButtonData(
                label: 'First 50K \nMonth',
                assetPath: AppImages.milestone,
                color: Colors.white.withOpacity(0.060),
                textColor: Color(0xFFFFB400).withOpacity(0.60), // Highlight first one!

              ),
            ],
          ),

        ],
      ),
    );
  }
}
