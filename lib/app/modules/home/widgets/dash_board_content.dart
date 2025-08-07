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
import '../../leader_board/controllers/leader_board_controller.dart';
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
              progressValue: (profileController
                          .profileData.value.data?.monthlyTargetPercentage ??
                      0)
                  .toDouble(),
              achievedText:
                  'Achieved: €${profileController.profileData.value.data?.salesCount ?? "N/A"} '
                  'of €${profileController.profileData.value.data?.monthlyTarget ?? "N/A"}',
              percentageLabel:
                  '${profileController.profileData.value.data?.monthlyTargetPercentage ?? "N/A"}%',
              footerMessage: "You're halfway there! 🎉",
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
                league: 'Global Leaderboard',
                leagueName: profileController.profileData.value.data?.league?.name ?? 'N/A',

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
              final badgesData = _controller.badgesData.value.data;
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
                              : "Unknown",
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
