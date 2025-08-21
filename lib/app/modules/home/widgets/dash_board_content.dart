import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import 'package:wolf_pack/app/common%20widget/custom%20text/custom_text_widget.dart';
import 'package:wolf_pack/app/modules/home/controllers/my_clients_controller.dart';
import 'package:wolf_pack/app/modules/sales/views/sales_screen.dart';
import 'package:wolf_pack/app/modules/home/widgets/perform_card_wigets.dart';
import 'package:wolf_pack/app/modules/home/widgets/rececnt_deatils_widgets.dart';
import 'package:wolf_pack/app/modules/home/widgets/start_progreeesed.dart';
import 'package:wolf_pack/app/modules/home/widgets/stat_card_wigets.dart';
import 'package:wolf_pack/app/modules/home/widgets/target_widgets.dart';
import 'package:wolf_pack/app/modules/open_deal/views/new_deal_view.dart';
import 'package:wolf_pack/app/modules/sales/views/sales_view.dart';
import 'package:wolf_pack/app/uitilies/app_colors.dart';
import 'package:wolf_pack/app/uitilies/app_images.dart';
import 'package:wolf_pack/app/uitilies/custom_loader.dart';
import '../../../common widget/common_listview_builder.dart';
import '../../../common widget/custom_header_widgets.dart';
import '../../../uitilies/date_time_formate.dart';
import '../../badges/controllers/badges_controller.dart';
import '../../badges/widgets/next_achive_widgets.dart';
import '../../leader_board/controllers/leader_board_controller.dart';
import '../../leader_board/controllers/next_achevement_controller.dart';
import '../../profile/controllers/get_myProfile_controller.dart';
import '../../view_details/views/view_details_view.dart';
import '../model/badget_model_data.dart';
import 'badge_card_widgets.dart';
import 'leader_board_widgets.dart';

class DashboardContent extends StatelessWidget {
  DashboardContent({super.key});

  final GetMyProfileController profileController =
      Get.put(GetMyProfileController());
  final MyClientGetController dealController = Get.put(MyClientGetController());
  final LeaderBoardController controller = Get.put(LeaderBoardController());
  final BadgesController _controller = Get.put(BadgesController());
  final BadgesController _badgesController = Get.put(BadgesController());
  final GetMyProfileController _profileController = Get.put(GetMyProfileController());
  final NextAchievementGetController nextController = Get.put(NextAchievementGetController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (profileController.isLoading.value || dealController.isLoading.value) {
        return CustomLoader();
      }
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
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
              children: [
                StatProgressCard(
                  primaryValue:
                      '€${profileController.profileData.value.data?.salesCount ?? "N/A"}',
                  label: 'Total Sales',
                  subValue:
                      '€${profileController.profileData.value.data?.salesCount ?? "N/A"} ${"Target"}',
                  progressValue: 0.4,
                ),
                StatProgressCard(
                  primaryValue:
                      '€${profileController.profileData.value.data?.monthlyTarget ?? "N/A"}',
                  label: 'Target',
                  subValue:
                      '€${profileController.profileData.value.data?.salesCount ?? "N/A"} ${"% "} ${"Complete"}',
                  progressValue: 0.7,
                ),
              ],
            ),

            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                StatCard(
                  primaryValue:
                      '€${profileController.profileData.value.data?.avgDealAmount?? "N/A"}',
                  label: 'Avg. Deal Size',
                  subValue: '',
                  color: Colors.amber,
                ),
                StatCard(
                  primaryValue:
                      '€${profileController.profileData.value.data?.commission ?? "N/A"}',
                  label: 'Commission',
                  subValue: '',
                  color: Colors.amber,
                ),
              ],
            ),

            const SizedBox(height: 20),
            TargetProgressCard(
              title: 'Monthly Target',
              progressValue: ((profileController
                  .profileData.value.data?.monthlyTargetPercentage ?? 0)
                  .toDouble() /
                  100), // ✅ divide by 100
              achievedText:
              'Achieved: €${profileController.profileData.value.data?.salesCount ?? "N/A"} '
                  'of €${profileController.profileData.value.data?.monthlyTarget ?? "N/A"}',
              percentageLabel:
              '${profileController.profileData.value.data?.monthlyTargetPercentage ?? "N/A"}%',
              // footerMessage: "You're halfway there! 🎉",
            ),


            const SizedBox(height: 20),

            /// Leaderboard
            Obx(() {
              if (controller.isLoading.value) {
                return  Center(child: CustomLoader());
              }

              final data = controller.leaderBoardData.value.data;

              if (data == null || data.leaderBoard.isEmpty) {
                return const Center(child: Text("No leaderboard data found"));
              }

              final top3 = data.leaderBoard.take(3).toList();

              return LeaderboardCard(
                rank: '#${profileController.profileData.value.data?.rank.toString() ?? 'N/A'}',
                // league: 'Global Leaderboard',
                // leagueName: profileController.profileData.value.data?.league?.name ?? 'N/A',

                performers: top3.asMap().entries.map((entry) {
                  final index = entry.key;
                  final performer = entry.value;

                  // Apply special style for the 1st performer
                  final isFirst = index == 0;

                  return PerformerCard(
                    backroundColor: isFirst
                        ? Color(0xFF00D1FF).withOpacity(0.13)
                        : const Color(0xFFFF7D00).withOpacity(0.13),
                    rank: index + 1,
                    name: performer.name ?? 'N/A',
                    earnings: '€${performer.salesCount ?? '0'}',
                    rankColor: AppColors.orangeColor,
                  );
                }).toList(),

                motivationLine1: "You're in Jupiler League. Keep pushing for",
                motivationLine2: "Europa League! 🏅",
              );
            }),

            const SizedBox(height: 20),

            HeaderWidgets(title: 'Badge Milestone', subTitle: 'View All'),
            const SizedBox(height: 10),

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
            SizedBox(height: 15.h),

            HeaderWidgets(
              title: 'Recent Deals',
              subTitle: 'View All',
              onSubTitleTap: () => Get.to(() => SalesScreen()),
            ),
            SizedBox(height: 10.h),
            ReusableListView(
              isLoading: dealController.isLoading,
              dataList: RxList(dealController.dealData.value.data?.data ?? []),
              onRetry: () => dealController.fetchMyProfile(),
              itemBuilder: (context, client) {
                return RecentDetails(
                  color: const Color(0xFF16A34A),
                  tagLabel: (client.closer?.status ?? '').toUpperCase() ==
                          'CLOSED'
                      ? 'Closed'
                      : (client.closer?.status ?? '').toUpperCase() == 'OPEN'
                          ? 'Open'
                          : (client.closer?.status ?? '').toUpperCase() == 'NEW'
                              ? 'New'
                              : "New",
                  companyName: client.name ?? 'N/A',
                  startDate:
                      DateUtil.formatTimeAgo(client.createdAt?.toLocal()),
                  endDate: DateUtil.formatTimeAgo(client.updatedAt?.toLocal()),
                  revenueTarget: '€${client.revenueTarget ?? 0}',
                  revenueClosed: '€${client.closer?.amount ?? 0}',
                  commissionEarned: '€${client.commissionRate ?? 0}',
                  onViewDetailsTap: () {
                    Get.to(() => NewDealView(clientId: client.id ?? ''));
                  },
                );
              },
            )
          ],
        ),
      );
    });
  }
}
