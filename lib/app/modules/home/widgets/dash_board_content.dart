import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:gap/gap.dart';

import 'package:wolf_pack/app/modules/home/controllers/my_clients_controller.dart';
import 'package:wolf_pack/app/modules/home/widgets/perform_card_wigets.dart';
import 'package:wolf_pack/app/modules/home/widgets/rececnt_deatils_widgets.dart';
import 'package:wolf_pack/app/modules/leader_board/controllers/leader_board_controller.dart';
import 'package:wolf_pack/app/modules/profile/controllers/get_myProfile_controller.dart';
import 'package:wolf_pack/app/modules/badges/controllers/badges_controller.dart';
import 'package:wolf_pack/app/modules/leader_board/controllers/next_achevement_controller.dart';
import 'package:wolf_pack/app/modules/leader_board/controllers/quater_prize_controller.dart';
import 'package:wolf_pack/app/modules/leader_board/modell/prizew_winner_model.dart';
import 'package:wolf_pack/app/modules/leader_board/controllers/top_perfomer_controller.dart';
import 'package:wolf_pack/app/modules/leader_board/controllers/all_prize_winner.dart';
import 'package:wolf_pack/app/modules/leader_board/widgets/prizw_badge.dart';
import 'package:wolf_pack/app/uitilies/custom_loader.dart';
import '../../../common_widget/common_listview_builder.dart';
import '../../../common_widget/custom_header_widgets.dart';
import '../../../common_widget/custom text/custom_text_widget.dart';
import '../../../common_widget/custom_button.dart';
import '../../../common_widget/nodata_wisgets.dart';
import '../../../uitilies/app_colors.dart';
import '../../../uitilies/app_images.dart';
import '../../../uitilies/date_time_formate.dart';
import '../../badges/widgets/next_achive_widgets.dart';
import '../../leader_board/widgets/new_leader_board_card.dart';
import '../../leader_board/widgets/price_tabs.dart';
import '../../leader_board/widgets/quater_prize_widgets.dart';
import '../../sales/views/sales_screen.dart';
import '../../open_deal/views/new_deal_view.dart';
import '../model/badget_model_data.dart';
import '../widgets/stat_card_wigets.dart';
import '../widgets/target_widgets.dart';
import '../widgets/badge_card_widgets.dart';
import '../widgets/leader_board_widgets.dart';
import '../../view_details/views/view_details_view.dart';

class DashboardContent extends StatelessWidget {
  DashboardContent({super.key});

  final GetMyProfileController profileController = Get.put(GetMyProfileController());
  final MyClientGetController dealController = Get.put(MyClientGetController());
  final LeaderBoardController controller = Get.put(LeaderBoardController());
  final BadgesController _badgesController = Get.put(BadgesController());
  final NextAchievementGetController nextController = Get.put(NextAchievementGetController());
  final AllPrizeWinnerController monthController = Get.put(AllPrizeWinnerController());
  final AllQuaterPrizeWinnersController quarterController = Get.put(AllQuaterPrizeWinnersController());
  final TopPerformersGetController topPerformersGetController = Get.put(TopPerformersGetController());
  final AllPrizeWinnersController allPrizeWinnersController = Get.put(AllPrizeWinnersController());
  final RxBool isLiveRankingActive = true.obs;

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
                    primaryValue: "€${profileController.profileData.value.data?.salesCount ?? 0}",
                    label: "Total Sales",
                    color: AppColors.orangeColor,
                    subValue: "",
                  ),
                  StatCard(
                    primaryValue: "€${profileController.profileData.value.data?.monthlyTarget ?? 0}",
                    label: "Target",
                    color: AppColors.orangeColor,
                    subValue: "",
                  ),
                ],
              ),

              SizedBox(height: 20.h),

              TargetProgressCard(
                title: "Monthly Target",
                progressValue: ((profileController.profileData.value.data?.monthlyTargetPercentage ?? 0) / 100).toDouble(),
                achievedText:
                'Achieved: €${profileController.profileData.value.data?.salesCount ?? "N/A"} of €${profileController.profileData.value.data?.monthlyTarget ?? "N/A"}',
                percentageLabel: '${profileController.profileData.value.data?.monthlyTargetPercentage ?? "N/A"}%',
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
                  rank: '#${profileController.profileData.value.data?.rank ?? "N/A"}',
                  performers: top3.asMap().entries.map((entry) {
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
                  motivationLine1: '',
                  motivationLine2: '',
                );
              }),

              SizedBox(height: 20.h),

              /// ---------- Monthly & Quarter Tabs ----------
              PrizeTabsWidget(
                monthController: monthController,
                quarterController: quarterController,
              ),

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
                dataList: RxList(dealController.dealData.value.data?.data ?? []),
                onRetry: () => dealController.fetchMyProfile(),
                itemBuilder: (context, client) {
                  if (client.closer == null) return const SizedBox.shrink();
                  return RecentDetails(
                    color: const Color(0xFFE12728),
                    tagLabel: (client.closer?.status ?? '').toUpperCase() == 'CLOSED'
                        ? 'Closed'
                        : (client.closer?.status ?? '').toUpperCase() == 'OPEN'
                        ? 'Open'
                        : 'New',
                    companyName: client.name ?? 'N/A',
                    startDate: DateUtil.formatTimeAgo(client.createdAt?.toLocal()),
                    endDate: DateUtil.formatTimeAgo(client.updatedAt?.toLocal()),
                    revenueTarget: '€${client.revenueTarget ?? 0}',
                    revenueClosed: '€${client.closer?.amount ?? 0}',
                    commissionEarned: '€${client.commissionRate ?? 0}',
                    onViewDetailsTap: () => Get.to(() => NewDealView(clientId: client.id ?? '')),
                  );
                },
              ),

              /// ---------- LeaderBoard Section (Added Below) ----------
              Gap(20.h),
              Row(
                children: [
                  Expanded(
                    child: CustomButton(
                      isGradient: false,
                      buttonColor: isLiveRankingActive.value
                          ? const Color(0XFFFCB806).withOpacity(0.30)
                          : const Color(0XFFFCB806).withOpacity(0.15),
                      titleColor: isLiveRankingActive.value ? Colors.white : AppColors.textGray,
                      title: 'Live Ranking',
                      onTap: () => isLiveRankingActive.value = true,
                    ),
                  ),
                  SizedBox(width: 20),
                  Expanded(
                    child: CustomButton(
                      isGradient: false,
                      buttonColor: !isLiveRankingActive.value
                          ? const Color(0XFFFCB806).withOpacity(0.30)
                          : const Color(0XFFFCB806).withOpacity(0.15),
                      titleColor: !isLiveRankingActive.value ? Colors.white : AppColors.textGray,
                      title: 'Prize',
                      onTap: () => isLiveRankingActive.value = false,
                    ),
                  ),
                ],
              ),
              Gap(20.h),

              Obx(() {
                return isLiveRankingActive.value
                    ? _buildLiveRankingContent()
                    : _buildPrizeContent();
              }),
            ],
          ),
        ),
      );
    });
  }

  // ------------------ LIVE RANKING ------------------
  Widget _buildLiveRankingContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          text: 'Live Rankings',
          fontWeight: FontWeight.w600,
          fontSize: 18.sp,
          color: AppColors.white,
        ),
        Gap(12.h),
        TargetProgressCard(
          title: 'Progress',
          progressValue: (profileController.profileData.value.data?.monthlyTargetPercentage ?? 0) / 100,
          achievedText:
          'Achieved: €${profileController.profileData.value.data?.salesCount ?? "N/A"} '
              'of €${profileController.profileData.value.data?.monthlyTarget ?? "N/A"}',
          percentageLabel:
          '${profileController.profileData.value.data?.monthlyTargetPercentage ?? "N/A"}%',
          footerMessage: "You're halfway there! 🎉",
        ),
        Gap(12.h),
        _buildYourRankSection(),
        Gap(12.h),
        CustomText(
          text: 'Hall of Fame',
          fontWeight: FontWeight.w600,
          fontSize: 18.sp,
          color: AppColors.white,
        ),
        Obx(() {
          final topPerformers = topPerformersGetController.topPerformersData.value.data;

          if (topPerformers == null) {
            return Center(
              child: GestureDetector(
                onTap: () => topPerformersGetController.fetchTopPerformers(),
                child: NoDataWidget(text: 'No data available. Tap to retry.'),
              ),
            );
          }

          if (topPerformers.isEmpty) {
            return Center(child: CustomLoader());
          }

          return ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: topPerformers.length,
            itemBuilder: (context, index) {
              final performer = topPerformers[index];
              if (performer.value == null || performer.value?.name == null || performer.value?.name!.isEmpty == true) {
                return const SizedBox.shrink();
              }
              return NewLeaderBoardCard(
                profileImage: performer.value?.profilePicture ?? '',
                totalAmount: '\$${performer.value?.totalAmount ?? 0}',
                name: performer.value?.name ?? "Unknown",
                value: performer.label?.replaceAll('_', ' ') ?? "",
              );
            },
          );
        }),
      ],
    );
  }

  // ------------------ PRIZE TAB ------------------
  Widget _buildPrizeContent() {
    return Column(
      children: [
        Gap(20.h),
        _buildTopPrizeSection(),
        Gap(20.h),
        PrizeAndBadgeSection(),
      ],
    );
  }

  Widget _buildTopPrizeSection() {
    return Obx(() {
      if (allPrizeWinnersController.isLoading.value) {
        return Center(child: CircularProgressIndicator());
      }

      final winnersData = allPrizeWinnersController.userPrizeWinnerList.value.data;
      if (winnersData == null || winnersData.isEmpty) {
        return Center(
          child: GestureDetector(
            onTap: () => allPrizeWinnersController.fetchPrizeWinners(),
            child: NoDataWidget(text: 'No winners found. Tap to retry.'),
          ),
        );
      }

      final allWinners = winnersData..sort((a, b) => (a.position ?? 0).compareTo(b.position ?? 0));
      final topWinners = allWinners.take(3).toList();

      return Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.orangeColor),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFFCB806).withOpacity(0.5), Color(0xFFFCB806)],
          ),
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Color(0x29000000),
              offset: Offset(0, 4),
              blurRadius: 13,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomText(
              text: 'Top ${topWinners.length} Potential Closers — Prizes',
              fontWeight: FontWeight.w500,
              color: AppColors.white,
              fontSize: 16,
            ),
            SizedBox(height: 10),
            LayoutBuilder(builder: (context, constraints) {
              final cardWidth = constraints.maxWidth / 3 - 16;
              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    for (int i = 0; i < topWinners.length; i++)
                      Container(
                        width: cardWidth,
                        margin: EdgeInsets.symmetric(horizontal: 8),
                        child: _buildTopPrizeCard(
                          topWinners[i].user?.name ?? 'Unknown',
                          '\$${topWinners[i].prize?.name ?? 'Prize'}',
                          '#${topWinners[i].prize?.tierLevel ?? i + 1}',
                          topWinners[i].user?.profilePicture ?? AppImages.profile,
                          topWinners.length == 3 ? i == 1 : false,
                        ),
                      ),
                  ],
                ),
              );
            }),
          ],
        ),
      );
    });
  }

  Widget _buildTopPrizeCard(String name, String prize, String rank, String imagePath, bool isMiddle) {
    return Column(
      children: [
        ClipOval(
          child: Container(
            padding: EdgeInsets.all(1),
            decoration: BoxDecoration(
              color: AppColors.orangeColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: CircleAvatar(
              radius: isMiddle ? 35 : 30,
              child: imagePath.startsWith('http')
                  ? CachedNetworkImage(
                imageUrl: imagePath,
                imageBuilder: (context, imageProvider) => Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
                  ),
                ),
                placeholder: (context, url) => CircularProgressIndicator(),
                errorWidget: (context, url, error) => Icon(Icons.person),
              )
                  : CircleAvatar(backgroundImage: AssetImage(imagePath)),
            ),
          ),
        ),
        SizedBox(height: 10),
        Container(
          height: 70,
          width: 100,
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.orangeColor),
            color: isMiddle ? const Color(0xFFFCB806) : const Color(0xFFFF7D00),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomText(text: name, fontWeight: FontWeight.w500, color: AppColors.white, fontSize: 16),
              CustomText(text: prize, fontWeight: FontWeight.w700, color: AppColors.white, fontSize: 16),
              CustomText(text: rank, fontWeight: FontWeight.w400, color: AppColors.white.withOpacity(0.72), fontSize: 12),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildYourRankSection() {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.orangeColor),
        gradient: LinearGradient(
          colors: [Color(0xFFFCB806).withOpacity(0.07), Color(0xFFFCB806).withOpacity(0.07)],
        ),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  CustomText(
                    text: profileController.profileData.value.data?.rank.toString() ?? "N/A",
                    fontWeight: FontWeight.w700,
                    color: AppColors.orangeColor,
                    fontSize: 20.sp,
                  ),
                  Gap(10.w),
                  CustomText(
                    text: profileController.profileData.value.data?.name ?? "N/A",
                    fontWeight: FontWeight.w500,
                    color: AppColors.white,
                    fontSize: 18.sp,
                  ),
                ],
              ),
              Container(
                decoration: BoxDecoration(
                  color: AppColors.orangeColor,
                  borderRadius: BorderRadius.circular(50.r),
                ),
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                child: CustomText(
                  text: 'Your Rank',
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                  fontSize: 14.sp,
                ),
              ),
            ],
          ),
          Gap(10.h),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50),
            child: Row(
              children: [
                CustomText(
                  text: "€${profileController.profileData.value.data?.salesCount ?? "N/A"}",
                  fontWeight: FontWeight.w500,
                  color: AppColors.white,
                  fontSize: 16.sp,
                ),
                Gap(10.w),
                CustomText(
                  text: ' ${profileController.profileData.value.data?.dealCount ?? "N/A"} Deals',
                  fontWeight: FontWeight.w400,
                  color: AppColors.white.withOpacity(0.5),
                  fontSize: 14.sp,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
