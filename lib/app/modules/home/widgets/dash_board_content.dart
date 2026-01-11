import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:wolf_pack/app/modules/home/controllers/my_clients_controller.dart';
import 'package:wolf_pack/app/modules/home/widgets/hall_of_fram_widget.dart';
import 'package:wolf_pack/app/modules/home/widgets/perform_card_wigets.dart';
import 'package:wolf_pack/app/modules/home/widgets/rececnt_deatils_widgets.dart';
import 'package:wolf_pack/app/modules/leader_board/controllers/leader_board_controller.dart';
import 'package:wolf_pack/app/modules/leader_board/views/leader_board_view.dart';
import 'package:wolf_pack/app/modules/profile/controllers/get_myProfile_controller.dart';
import 'package:wolf_pack/app/modules/badges/controllers/badges_controller.dart';
import 'package:wolf_pack/app/modules/leader_board/controllers/next_achevement_controller.dart';
import 'package:wolf_pack/app/modules/leader_board/controllers/quater_prize_controller.dart';
import 'package:wolf_pack/app/modules/leader_board/controllers/prizew_winner_model.dart';
import 'package:wolf_pack/app/modules/leader_board/controllers/top_perfomer_controller.dart';
import 'package:wolf_pack/app/modules/leader_board/controllers/all_prize_winner.dart';
import 'package:wolf_pack/app/modules/leader_board/widgets/prizw_badge.dart';
import 'package:wolf_pack/app/uitilies/custom_loader.dart';
import '../../../common_widget/common_listview_builder.dart';
import '../../../common_widget/custom_header_widgets.dart';
import '../../../common_widget/custom text/custom_text_widget.dart';
import '../../../common_widget/custom_button.dart';
import '../../../common_widget/nodata_wisgets.dart';
import '../../../common_widget/custom_calender.dart';
import '../../../uitilies/app_colors.dart';
import '../../../uitilies/app_images.dart';
import '../../../uitilies/date_time_formate.dart';
import '../../badges/widgets/next_achive_widgets.dart';
import '../../leader_board/controllers/leader_borad_get.dart';
import '../../leader_board/widgets/new_leader_board_card.dart';
import '../../leader_board/widgets/price_tabs.dart';
import '../../leader_board/widgets/quater_prize_widgets.dart';
import '../../sales/views/sales_screen.dart';
import '../../open_deal/views/new_deal_view.dart';
import '../../open_deal/views/open_deal_view.dart';
import '../../closed_deal/views/closed_deal_view.dart';
import '../../sales/views/sales_view.dart';
import '../controllers/allDeals_controller.dart';
import '../model/all_closed_model.dart';
import '../model/badget_model_data.dart';
import '../widgets/stat_card_wigets.dart';
import '../widgets/target_widgets.dart';
import '../widgets/badge_card_widgets.dart';
import '../widgets/leader_board_widgets.dart';
import '../../view_details/views/view_details_view.dart';
import '../model/all_my_cleints_model.dart';

class DashboardContent extends StatefulWidget {
  DashboardContent({super.key});

  @override
  State<DashboardContent> createState() => _DashboardContentState();
}

class _DashboardContentState extends State<DashboardContent> {
  final GetMyProfileController profileController = Get.put(GetMyProfileController());
  final MyClientGetController dealController = Get.put(MyClientGetController());
  // final LeaderBoardController controller = Get.put(LeaderBoardController());
  final BadgesController _badgesController = Get.put(BadgesController());
  final NextAchievementGetController nextController = Get.put(NextAchievementGetController());
  final AllPrizeWinnerController monthController = Get.put(AllPrizeWinnerController());
  final AllQuaterPrizeWinnersController quarterController = Get.put(AllQuaterPrizeWinnersController());
  final TopPerformersGetController topPerformersGetController = Get.put(TopPerformersGetController());
  final AllPrizeWinnersController allPrizeWinnersController = Get.put(AllPrizeWinnersController());
  final RxBool isLiveRankingActive = true.obs;
  final leaderBoardController = Get.put(LeaderBoardGetController());

  // Format currency with proper decimals
  String _formatCurrencyDropDecimals(dynamic value) {
    if (value == null) return '0';
    double v;
    if (value is String) {
      v = double.tryParse(value) ?? 0.0;
    } else if (value is num) {
      v = value.toDouble();
    } else {
      return '0';
    }
    final intInt = v.truncate();
    return NumberFormat.decimalPattern().format(intInt);
  }

  // Get color for status
  Color _getStatusColor(String status) {
    switch (status.toUpperCase()) {
      case 'NEW':
        return const Color(0xFF16A34A);
      case 'OPEN':
        return Color(0Xff0094B5);
      case 'CLOSED':
        return const Color(0xFFE12728);
      default:
        return Colors.grey;
    }
  }
  String _formatCurrency(dynamic value) {
    if (value == null) return '0';
    double v = value is String ? double.tryParse(value) ?? 0.0 : value.toDouble();
    return NumberFormat.decimalPattern().format(v.truncate());
  }
  @override
  void initState() {
    super.initState();
    // profileController.fetchMyProfile();
    // dealController.fetchMyProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (profileController.isLoading.value || dealController.isLoading.value) {
        return CustomLoader();
      }

      final dataList = topPerformersGetController.topPerformersData.value.data;
      final dayData = dataList.firstWhereOrNull((item) => item.label == 'Most_revenue_in_day')?.value;
      final weekData = dataList.firstWhereOrNull((item) => item.label == 'Most_revenue_in_week')?.value;
      final monthData = dataList.firstWhereOrNull((item) => item.label == 'Most_revenue_in_month')?.value;
      final quarterData = dataList.firstWhereOrNull((item) => item.label == 'Most_revenue_in_quarter')?.value;
      final yearData = dataList.firstWhereOrNull((item) => item.label == 'Most_revenue_in_year')?.value;

      // Extract top performers by label
      final Map<String, dynamic> hallData = {};
      if (dataList != null) {
        for (var item in dataList) {
          if (item.label != null && item.value != null) {
            hallData[item.label!] = [item.value!]; // wrap in list
          }
        }
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
                    primaryValue: "€${NumberFormat("#,##0").format(profileController.profileData.value.data?.thisMonthSales ?? 0)}",
                    label: "Total Sales",
                    color: AppColors.orangeColor,
                    subValue: "",
                  ),
                  StatCard(
                    primaryValue: "€${NumberFormat("#,##0").format(profileController.profileData.value.data?.monthlyTarget ?? 0)}",
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
                achievedText: 'Achieved: €${profileController.profileData.value.data?.thisMonthSales ?? "N/A"} of €${profileController.profileData.value.data?.monthlyTarget ?? "N/A"}',
                percentageLabel: '${(profileController.profileData.value.data?.monthlyTargetPercentage ?? 0).toStringAsFixed(2)}%',
              ),
              /// ---------- Leaderboard ----------
              LeaderBoardView(),
              SizedBox(height: 8.h),
              CustomText(
                text: 'Hall of Fame',
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
              ...hallData.entries.map((entry) {
                return buildHallOfFameSection(
                  timePeriod: entry.key.replaceAll('_', ' '),
                  data: entry.value.first,
                  emptyText: 'No ${entry.key.replaceAll('_', ' ').toLowerCase()} data found',
                );
              }).toList(),



              /// ---- your rank -----------
              SizedBox(height: 16.h),
              Obx(() {
                // final controller = Get.find<LeaderBoardGetController>();

                if (leaderBoardController.isLoading.value) {
                  return  Center(child: CustomLoader());
                }

                if (leaderBoardController.rawData.isEmpty) {
                  return const Center(
                    child: Text(
                      "No leaderboard data available",
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  );
                }

                // Get top 3 sorted by totalRevenue
                final top3 = leaderBoardController.sortedUsers.take(3).toList();

                if (top3.isEmpty) {
                  return const Center(child: Text("No top performers yet"));
                }

                // Your current user's rank (optional - if you have this info)
                final myRank = "#${profileController.profileData.value.data?.rank ?? '—'}";

                return LeaderboardCard(
                  rank: myRank,
                  performers: top3.asMap().entries.map((entry) {
                    final index = entry.key;
                    final user = entry.value;

                    final bgColor = switch (index) {
                      0 => Colors.blueAccent.withOpacity(0.18),
                      1 => Colors.amber.withOpacity(0.18),
                      2 => Colors.orangeAccent.withOpacity(0.18),
                      _ => Colors.grey.withOpacity(0.12),
                    };

                    // ✅ Proper currency formatting
                    final num revenue = user.totalRevenue ?? 0;
                    final earnings = NumberFormat.currency(
                      symbol: '€',
                      decimalDigits: 0,
                    ).format(revenue);

                    return PerformerCard(
                      backroundColor: bgColor,
                      rank: index + 1,
                      name: user.name ?? 'Unknown',
                      earnings: earnings,
                      rankColor: AppColors.orangeColor,
                    );
                  }).toList(),
                  motivationLine1: "You're doing great!",
                  motivationLine2: "Keep pushing to reach the top! 🔥",
                );

              }),              SizedBox(height: 20.h),
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
              SizedBox(height: 16.h),
              Obx(() {
                final AllDealController allDealController = Get.put(AllDealController());

                // 🔹 Show shimmer while loading
                if (allDealController.isLoading.value) {
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: 20.h),
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: 4,
                      itemBuilder: (context, index) => RecentDetails(
                        color: Colors.grey.shade800,
                        tagLabel: 'Loading',
                        companyName: 'Loading...',
                        assignDate: 'Loading...',
                        offer: '0',
                        commissionRate: '0',
                        onViewDetailsTap: null,
                      ),
                    ),
                  );
                }

                // 🔹 List from API
                final deals = allDealController.myClosedAllClientData.value?.data ?? [];

                // 🔹 Filter closed deals
                final closedDeals = deals.where((d) {
                  return (d.status ?? '').toLowerCase() == 'closed';
                }).toList();

                // 🔹 Sort by dealDate (latest first)
                closedDeals.sort((a, b) {
                  final dateA = a.dealDate ?? DateTime(1970);
                  final dateB = b.dealDate ?? DateTime(1970);
                  return dateB.compareTo(dateA);
                });

                // 🔹 Pick only the latest 3
                final latestThree = closedDeals.take(3).toList();

                // 🔹 No closed deals
                if (latestThree.isEmpty) {
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: 40.h),
                    child: Center(
                      child: Text(
                        "No closed deals yet",
                        style: TextStyle(color: Colors.white70, fontSize: 16.sp),
                      ),
                    ),
                  );
                }

                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 20.h),
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: latestThree.length,
                    itemBuilder: (context, index) {
                      final deal = latestThree[index];

                      final companyName = deal.userClient?.client?.name;
                      final offer =  deal.userClient?.client?.offer;
                      final commissionPercent = deal.userClient?.client?.commissionRate ?? 0;
                      final offerAmount = deal.amount ?? 0;

                      final commissionAmount = (offerAmount * commissionPercent / 100);        final assignDate = deal.createdAt != null
                          ? DateFormat('yyyy-MM-dd hh:mm a').format(deal.createdAt!)
                          : null;
                      final clientId = deal.id ?? '';

                      final userName = deal.userClient?.client?.name;
                      final profileImage = deal.user?.profilePicture;
                      final cashCollected = deal.cashCollected != null ? _formatCurrency(deal.cashCollected) : null;
                      final amount = deal.amount !=null ? _formatCurrency(deal.amount) : null;
                      final commission = commissionAmount != null ? _formatCurrency(commissionAmount) : null;

                      return RecentDetails(
                        onViewDetailsTap: null,
                        color: Colors.red,
                        tagLabel: "CLOSED",

                        assignDate: assignDate,
                        offer: offer,
                        amount:amount ,
                        commissionRate: commission,
                        userName: userName,
                        profileImage: profileImage,
                        cashCollected: cashCollected,
                      );
                    },
                  ),
                );
              }),
              Gap(20.h),

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
          achievedText: 'Achieved: €${profileController.profileData.value.data?.salesCount ?? "N/A"} '
              'of €${profileController.profileData.value.data?.monthlyTarget ?? "N/A"}',
          percentageLabel: '${profileController.profileData.value.data?.monthlyTargetPercentage ?? "N/A"}%',
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
                totalAmount: '€${performer.value?.totalAmount ?? 0}',
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
                          '€${topWinners[i].prize?.name ?? 'Prize'}',
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
Widget buildHallOfFameSection({
  required String timePeriod,
  required dynamic data,
  required String emptyText,
}) {
  if (data == null) return const SizedBox.shrink();

  final num totalRevenue = data.totalRevenue ?? 0;
  final num dealAmount = data.totalAmount ?? 0;
  final num dealsClosed = data.totalDealCount ?? 0;

  final NumberFormat currencyFormat =
  NumberFormat.currency(symbol: '', decimalDigits: 0);

  return HallOfFameWidget(
    timePeriod: timePeriod,
    name: data.name ?? 'Unknown',
    imageUrl: data.profilePicture ?? '',

    /// ✅ formatted only at UI boundary
    commission: currencyFormat.format(totalRevenue),

    /// ✅ keep numeric
    dealAmount: currencyFormat.format(dealAmount),
    dealsClosed: dealsClosed,

    isNotEmty: true,
  );
}
