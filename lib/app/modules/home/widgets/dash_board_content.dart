import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:wolf_pack/app/common%20widget/custom%20text/custom_text_widget.dart';
import 'package:wolf_pack/app/modules/home/controllers/my_clients_controller.dart';
import 'package:wolf_pack/app/modules/home/widgets/perform_card_wigets.dart';
import 'package:wolf_pack/app/modules/home/widgets/rececnt_deatils_widgets.dart';
import 'package:wolf_pack/app/modules/leader_board/controllers/leader_board_controller.dart';
import 'package:wolf_pack/app/modules/profile/controllers/get_myProfile_controller.dart';
import 'package:wolf_pack/app/modules/badges/controllers/badges_controller.dart';
import 'package:wolf_pack/app/modules/leader_board/controllers/next_achevement_controller.dart';
import 'package:wolf_pack/app/modules/leader_board/controllers/quater_prize_controller.dart';
import 'package:wolf_pack/app/modules/leader_board/modell/prizew_winner_model.dart';
import 'package:wolf_pack/app/uitilies/custom_loader.dart';
import '../../../uitilies/app_colors.dart';
import '../../../uitilies/app_images.dart';
import '../../badges/widgets/next_achive_widgets.dart';
import '../../leader_board/widgets/new_leader_board_card.dart';
import '../../leader_board/widgets/price_tabs.dart';
import '../../leader_board/widgets/quater_prize_widgets.dart';
import '../../leader_board/controllers/leader_board_controller.dart';
import '../../sales/views/sales_screen.dart';
import '../../open_deal/views/new_deal_view.dart';
import '../../../common widget/common_listview_builder.dart';
import '../../../common widget/custom_header_widgets.dart';
import '../../../uitilies/date_time_formate.dart';
import '../model/badget_model_data.dart';
import '../widgets/stat_card_wigets.dart';
import '../widgets/target_widgets.dart';
import '../widgets/badge_card_widgets.dart';
import '../widgets/leader_board_widgets.dart';
import '../../view_details/views/view_details_view.dart';

class DashboardContent extends StatelessWidget {
  DashboardContent({super.key});

  final GetMyProfileController profileController =
  Get.put(GetMyProfileController());
  final MyClientGetController dealController = Get.put(MyClientGetController());
  final LeaderBoardController controller = Get.put(LeaderBoardController());
  final BadgesController _badgesController = Get.put(BadgesController());
  final NextAchievementGetController nextController =
  Get.put(NextAchievementGetController());
  final AllPrizeWinnerController monthController =
  Get.put(AllPrizeWinnerController());
  final AllQuaterPrizeWinnersController quarterController =
  Get.put(AllQuaterPrizeWinnersController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (profileController.isLoading.value || dealController.isLoading.value) {
        return CustomLoader();
      }

      return SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              /// ---------- Performance ----------
              Text(
                "Performance Overview",
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700,
                  color: Colors.white.withOpacity(0.8),
                ),
              ),
              SizedBox(height: 10.h),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  StatCard(
                    primaryValue:
                    "€${profileController.profileData.value.data?.salesCount ??
                        0}",
                    label: "Total Sales",
                    color: AppColors.orangeColor,
                    subValue: "",
                  ),
                  StatCard(
                    primaryValue:
                    "€${profileController.profileData.value.data
                        ?.monthlyTarget ?? 0}",
                    label: "Target",
                    color: AppColors.orangeColor,
                    subValue: "",
                  ),
                ],
              ),

              SizedBox(height: 20.h),

              TargetProgressCard(
                title: "Monthly Target",
                progressValue: ((profileController.profileData.value.data
                    ?.monthlyTargetPercentage ??
                    0) /
                    100)
                    .toDouble(),
                achievedText:
                'Achieved: €${profileController.profileData.value.data
                    ?.salesCount ?? "N/A"} of €${profileController.profileData
                    .value.data?.monthlyTarget ?? "N/A"}',
                percentageLabel:
                '${profileController.profileData.value.data
                    ?.monthlyTargetPercentage ?? "N/A"}%',
              ),

              SizedBox(height: 20.h),

              /// ---------- Leaderboard ----------
              Obx(() {
                if (controller.isLoading.value) {
                  return Center(child: CustomLoader());
                }

                final data = controller.leaderBoardData.value.data;
                if (data == null || data.leaderBoard.isEmpty) {
                  return const Center(child: Text("No leaderboard data found"));
                }

                final top3 = data.leaderBoard.take(3).toList();

                return LeaderboardCard(
                  rank:
                  '#${profileController.profileData.value.data?.rank ?? "N/A"}',
                  performers: top3
                      .asMap()
                      .entries
                      .map((entry) {
                    final index = entry.key;
                    final performer = entry.value;
                    return PerformerCard(
                      backroundColor: index == 0
                          ? Colors.blueAccent.withOpacity(0.15)
                          : Colors.orangeAccent.withOpacity(0.15),
                      rank: index + 1,
                      name: performer.name ?? 'N/A',
                      earnings: '€${performer.salesCount ?? '0'}',
                      rankColor: AppColors.orangeColor,
                    );
                  }).toList(),
                  motivationLine1:
                  "You're in Jupiler League. Keep pushing for Europa League! 🏅",
                  motivationLine2: "",
                );
              }),

              SizedBox(height: 20.h),

              /// ---------- Monthly & Quarter Tabs ----------
              PrizeTabsWidget(
                monthController: monthController,
                quarterController: quarterController,
              ),

              SizedBox(height: 20.h),
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

              /// ---------- Recent Deals ----------
              HeaderWidgets(
                title: "Recent Deals",
                subTitle: "View All",
                onSubTitleTap: () => Get.to(() => SalesScreen()),
              ),
              SizedBox(height: 10.h),
              ReusableListView(
                isLoading: dealController.isLoading,
                dataList:
                RxList(dealController.dealData.value.data?.data ?? []),
                onRetry: () => dealController.fetchMyProfile(),
                itemBuilder: (context, client) {
                  if (client.closer == null) return const SizedBox.shrink();
                  return RecentDetails(
                    color: const Color(0xFFE12728),
                    tagLabel:
                    (client.closer?.status ?? '').toUpperCase() == 'CLOSED'
                        ? 'Closed'
                        : (client.closer?.status ?? '').toUpperCase() ==
                        'OPEN'
                        ? 'Open'
                        : 'New',
                    companyName: client.name ?? 'N/A',
                    startDate:
                    DateUtil.formatTimeAgo(client.createdAt?.toLocal()),
                    endDate:
                    DateUtil.formatTimeAgo(client.updatedAt?.toLocal()),
                    revenueTarget: '€${client.revenueTarget ?? 0}',
                    revenueClosed: '€${client.closer?.amount ?? 0}',
                    commissionEarned: '€${client.commissionRate ?? 0}',
                    onViewDetailsTap: () =>
                        Get.to(() => NewDealView(clientId: client.id ?? '')),
                  );
                },
              ),
            ],
          ),
        ),
      );
    });
  }
}
