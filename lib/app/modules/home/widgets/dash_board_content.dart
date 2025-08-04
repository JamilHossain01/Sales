import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import 'package:pet_donation/app/common%20widget/custom%20text/custom_text_widget.dart';
import 'package:pet_donation/app/modules/home/widgets/perform_card_wigets.dart';
import 'package:pet_donation/app/modules/home/widgets/rececnt_deatils_widgets.dart';
import 'package:pet_donation/app/modules/home/widgets/start_progreeesed.dart';
import 'package:pet_donation/app/modules/home/widgets/stat_card_wigets.dart';
import 'package:pet_donation/app/modules/home/widgets/target_widgets.dart';
import 'package:pet_donation/app/modules/open_deal/views/open_deal_view.dart';
import 'package:pet_donation/app/uitilies/app_colors.dart';
import 'package:pet_donation/app/uitilies/app_images.dart';
import '../../../common widget/custom_header_widgets.dart';
import '../../profile/controllers/get_myProfile_controller.dart';
import '../../view_details/views/view_details_view.dart';
import '../model/badget_model_data.dart';
import 'badge_card_widgets.dart';
import 'leader_board_widgets.dart';


class DashboardContent extends StatelessWidget {
   DashboardContent({super.key});
  final GetMyProfileController profileController = Get.put(GetMyProfileController());


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child:
      Column(
        children: [
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(
                        text: 'Performance Overview',
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w700,
                        color: Colors.white.withOpacity(0.72),
                      ),
                      // Gap(44.w),
                      // DropdownButton<String>(
                      //   value: 'This Month',
                      //   items: <String>['This Month', 'Last Month'].map((String value) {
                      //     return DropdownMenuItem<String>(
                      //       value: value,
                      //       child: CustomText(
                      //         text: value,
                      //         fontSize: 10.sp,
                      //
                      //         color: Colors.white,
                      //       ),
                      //     );
                      //   }).toList(),
                      //   onChanged: (_) {},
                      //   dropdownColor: const Color(0xFF2D2D2D),
                      // ),
                    ],
                  ),
                ],
              ),
            ],
          ),

          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children:  [
              StatProgressCard(
                primaryValue: '€${profileController.profileData.value.data?.salesCount ?? "N/A"}',
                label: 'Total Sales',
                subValue: '€${profileController.profileData.value.data?.salesCount ?? "N/A"} ${"Target"}',
                progressValue: 0.4,
              ),
              StatProgressCard(
                primaryValue: '€${profileController.profileData.value.data?.salesCount ?? "N/A"}',
                label: 'Target',
                subValue: '€${profileController.profileData.value.data?.salesCount ?? "N/A"} ${"% "} ${"Complete"}',

                progressValue: 0.7,
              ),
            ],
          ),

          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children:  [
              StatCard(
                primaryValue: '€${profileController.profileData.value.data?.dealCount ?? "N/A"}',
                label: 'Avg. Deal Size',
                subValue: '',
                color: Colors.amber,
              ),
              StatCard(
                primaryValue: '€${profileController.profileData.value.data?.commission ?? "N/A"}',
                label: 'Commission',
                subValue: '',
                color: Colors.amber,
              ),
            ],
          ),

          const SizedBox(height: 20),
          TargetProgressCard(
            title: 'Monthly Target',
            progressValue: (profileController.profileData.value.data?.monthlyTargetPercentage ?? 0).toDouble(),
            achievedText: 'Achieved: €${profileController.profileData.value.data?.salesCount ?? "N/A"} '
                'of €${profileController.profileData.value.data?.monthlyTarget ?? "N/A"}',
            percentageLabel: '${profileController.profileData.value.data?.salesCount ?? "N/A"}%',
            footerMessage: "You're halfway there! 🎉",
          ),

          const SizedBox(height: 20),

          /// Leaderboard
          LeaderboardCard(
            rank: '#15',
            league: 'Global Leaderboard',
            leagueName: 'Jupiler league',
            performers: [
              PerformerCard(
                backroundColor: const Color(0xFF00D1FF).withOpacity(0.13),
                rank: 4,
                name: 'Jami',
                earnings: '€1,000',
                rankColor: AppColors.orangeColor,
              ),
              PerformerCard(
                backroundColor: const Color(0xFFFF7D00).withOpacity(0.13),
                rank: 4,
                name: 'Jami',
                earnings: '€4500',
                rankColor: AppColors.white,
              ),
              PerformerCard(
                backroundColor: const Color(0xFFFF7D00).withOpacity(0.13),
                rank: 4,
                name: 'Jami',
                earnings: '€4500',
                rankColor: AppColors.white,
              ),
            ],
            motivationLine1: "You're in Jupiler League. Keep pushing for",
            motivationLine2: "Europa League! 🏅",
          ),
          const SizedBox(height: 20),

          HeaderWidgets(title: 'Badge Milestone', subTitle: 'View All'),
          const SizedBox(height: 10),

          BadgeProgressCard(
            title: 'Your Upcoming Badge',
            badgeLabel: 'First 10K Month',
            progressText: "You've closed €${profileController.profileData.value.data?.salesCount ?? 0} "
                "of €${profileController.profileData.value.data?.monthlyTarget ?? 0} ${"to earn this badge"}",

            targetCard: TargetProgressCard(
              title: 'Monthly Target',
              progressValue: (profileController.profileData.value.data?.monthlyTargetPercentage ?? 0).toDouble(),
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
          SizedBox(height: 15.h),


          HeaderWidgets(title: 'Recent Deals', subTitle: 'View All'),
          SizedBox(height: 10.h),

          RecentDetails(
            color: Color(0xFF16A34A),
            tagLabel: 'New',
            companyName: 'TechSavy Solutions Ltd.',
            startDate: '28 May, 2025',
            endDate: 'N/A',
            revenueTarget: '€10,000',
            revenueClosed: '€0.00',
            commissionEarned: '€0.00',
            onViewDetailsTap: () {
              Get.to(()=>OpenDealView());
              print('View Details tapped');
            },
          ),
          RecentDetails(
color: Color(0xFF0094B5),
            tagLabel: 'Open',
            companyName: 'TechSavy Solutions Ltd.',
            startDate: '28 May, 2025',
            endDate: 'N/A',
            revenueTarget: '€10,000',
            revenueClosed: '€0.00',
            commissionEarned: '€0.00',
            onViewDetailsTap: () {
              Get.to(()=>ViewDetailsView());

              print('View Details tapped');
            },
          ),
        ],
      ),
    );
  }
}
