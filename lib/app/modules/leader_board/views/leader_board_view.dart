import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:wolf_pack/app/common%20widget/custom%20text/custom_text_widget.dart';
import 'package:wolf_pack/app/common%20widget/nodata_wisgets.dart';
import 'package:wolf_pack/app/modules/home/widgets/target_widgets.dart';
import 'package:wolf_pack/app/modules/leader_board/controllers/all_prize_winner.dart';
import 'package:wolf_pack/app/modules/leader_board/widgets/month_league_widgets.dart';
import 'package:wolf_pack/app/uitilies/app_colors.dart';
import 'package:wolf_pack/app/uitilies/app_images.dart';
import 'package:wolf_pack/app/uitilies/custom_loader.dart';

import '../../../common widget/custom_button.dart';
import '../../home/controllers/my_clients_controller.dart';
import '../../profile/controllers/get_myProfile_controller.dart';
import '../controllers/leader_board_controller.dart';
import '../controllers/top_perfomer_controller.dart';
import '../widgets/leader_board_card.dart';
import '../widgets/new_leader_board_card.dart';
import '../widgets/prizw_badge.dart';

class LeaderBoardView extends GetView<LeaderBoardController> {
  LeaderBoardView({super.key});

  final LeaderBoardController controller = Get.put(LeaderBoardController());
  final MyClientGetController dealController = Get.put(MyClientGetController());
  final RxBool isLiveRankingActive = true.obs;
  final GetMyProfileController profileController =
  Get.put(GetMyProfileController());
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (dealController.isLoading.value || controller.isLoading.value) {
        return Center(child: CustomLoader());
      }

      final leaderBoardData = controller.leaderBoardData.value.data;
      final dealData = dealController.dealData.value.data?.data ?? [];

      if (leaderBoardData == null) {
        return Center(child: Text("No leaderboard data available"));
      }

      final topPerformers = leaderBoardData.leaderBoard.take(10).toList();
      final otherPerformers = leaderBoardData.leaderBoard.skip(10).toList();
      final visibleOthers = otherPerformers.take(controller.othersVisibleCount.value).toList();

      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // MonthWithLeagueMenu(),
              // Gap(20.h),

              // Toggle Buttons
              Row(
                children: [
                  Expanded(
                    child: CustomButton(
                      isGradient: false,
                      buttonColor: isLiveRankingActive.value
                          ? const Color(0XFFFCB806).withOpacity(0.30)
                          : const Color(0XFFFCB806).withOpacity(0.15),
                      titleColor: isLiveRankingActive.value
                          ? Colors.white
                          : AppColors.textGray,
                      title: 'Live Ranking',
                      onTap: () {
                        isLiveRankingActive.value = true;
                      },
                    ),
                  ),
                  SizedBox(width: 20),
                  Expanded(
                    child: CustomButton(
                      isGradient: false,
                      buttonColor: !isLiveRankingActive.value
                          ? const Color(0XFFFCB806).withOpacity(0.30)
                          : const Color(0XFFFCB806).withOpacity(0.15),
                      titleColor: !isLiveRankingActive.value
                          ? Colors.white
                          : AppColors.textGray,
                      title: 'Prize',
                      onTap: () {
                        isLiveRankingActive.value = false;
                      },
                    ),
                  ),
                ],
              ),
              Gap(20.h),

              // Content based on toggle selection
              isLiveRankingActive.value
                  ? _buildLiveRankingContent( )
                  : _buildPrizeContent(dealData, leaderBoardData),
            ],
          ),
        ),
      );
    });
  }

  Widget _buildLiveRankingContent() {
    final TopPerformersGetController topPerformersGetController = Get.put(TopPerformersGetController());

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Live Rankings Title
        CustomText(
          text: 'Live Rankings',
          fontWeight: FontWeight.w600,
          fontSize: 18.sp,
          color: AppColors.white,
        ),

        TargetProgressCard(
          title: 'Progress',
          progressValue: ((profileController
              .profileData.value.data?.monthlyTargetPercentage ?? 0)
              .toDouble() /
              100), // ✅ divide by 100
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

          // If topPerformers is null or empty, show loader
          if (topPerformers == null || topPerformers.isEmpty) {
            return Center(
              child: CustomLoader(),  // ✅ use your custom loader here
            );
          }

          return ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),  // for embedding in parent scroll
            itemCount: topPerformers.length,
            itemBuilder: (context, index) {
              final performer = topPerformers[index];

              // Check if the value or its properties are null before rendering
              if (performer.value == null || performer.value?.name == null || performer.value?.name?.isEmpty == true) {
                return Container();  // If value or name is null, don't show the card
              }

              return NewLeaderBoardCard(
                profileImage: performer.value?.profilePicture,
                totalAmount: '\$${performer.value?.totalAmount.toString() ?? "0"}',
                name: performer.value?.name ?? "Unknown",  // Use "Unknown" if name is null
                value: performer.label?.replaceAll('_', ' ') ?? "",  // Fallback to empty string if label is null
              );
            },
          );
        }),
      ],
    );
  }

  Widget _buildPrizeContent(List<dynamic> dealData, dynamic leaderBoardData) {
    return Column(
      children: [
        Gap(20.h),
        // _buildCompetitionBanner(),
        // Gap(20.h),

        // Top Prize Section
        _buildTopPrizeSection(),


        Gap(20.h),

        PrizeAndBadgeSection(),

        // Progress card
      ],
    );
  }


  Widget _buildTopPrizeSection() {
    final AllPrizeWinnersController controller = Get.put(AllPrizeWinnersController());

    return Obx(() {
      if (controller.isLoading.value) {
        return Center(child: CircularProgressIndicator());
      }

      if (controller.userPrizeWinnerList.value.data.isEmpty) {
        return NoDataWidget(text: 'No winners found');
      }

      // Get and sort all winners by position
      final allWinners = controller.userPrizeWinnerList.value.data
        ..sort((a, b) => (a.position ?? 0).compareTo(b.position ?? 0));

      // Take top 3 winners
      final topWinners = allWinners.take(3).toList();

      return Container(
        padding: EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.orangeColor),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              const Color(0xFFFCB806).withOpacity(0.50),
              const Color(0xFFFCB806),
            ],
            stops: [0.0, 1.0],
          ),
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: [
            BoxShadow(
              color: const Color(0x29000000),
              offset: const Offset(0, 4),
              blurRadius: 13,
              spreadRadius: 0,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(child: Image.asset(AppImages.king,height: 24.h,width: 27.w,),),

                SizedBox(width: 8),
                Flexible(
                  child: CustomText(
                    text: 'Top ${topWinners.length} Potential Closers — Prizes',
                    fontWeight: FontWeight.w500,
                    color: AppColors.white,
                    fontSize: 16.0,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.0),
            // Dynamic layout based on number of winners
            LayoutBuilder(
              builder: (context, constraints) {
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
                            topWinners.length == 3 ? i == 1 : false, // Highlight middle only if 3 winners
                          ),
                        ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      );
    });
  }

  Widget _buildTopPrizeCard(String name, String prize, String rank, String imagePath, bool isFirst) {
    return Column(
      children: [
        ClipOval(
          child: Container(
            padding: EdgeInsets.all(1),
            decoration: BoxDecoration(
              color: AppColors.orangeColor,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: CircleAvatar(
              radius: 30.0,
              child: imagePath.startsWith('http')
                  ? CachedNetworkImage(
                imageUrl: imagePath,
                imageBuilder: (context, imageProvider) => Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                placeholder: (context, url) => CircularProgressIndicator(),
                errorWidget: (context, url, error) => Icon(Icons.person),
              )
                  : CircleAvatar(
                backgroundImage: AssetImage(imagePath),
              ),
            ),
          ),
        ),
        SizedBox(height: 10.0),
        Container(
          height: 70.0,
          width: 100.0,
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.orangeColor),
            color: isFirst ? const Color(0xFFFCB806) : const Color(0xFFFF7D00),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomText(
                text: name,
                fontWeight: FontWeight.w500,
                color: AppColors.white,
                fontSize: 16.0,
              ),
              CustomText(
                text: prize,
                fontWeight: FontWeight.w700,
                color: AppColors.white,
                fontSize: 16.0,
              ),
              CustomText(
                text: rank,
                fontWeight: FontWeight.w400,
                color: AppColors.white.withOpacity(0.72),
                fontSize: 12.0,
              ),
            ],
          ),
        ),
      ],
    );
  }


  Widget _buildYourRankSection() {

    final GetMyProfileController profileController =
    Get.put(GetMyProfileController());
    // final yourDeal = dealData.isNotEmpty ? dealData[0] : null;

    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.orangeColor),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            const Color(0xFFFCB806).withOpacity(0.07),
            const Color(0xFFFCB806).withOpacity(0.07),
          ],
          stops: [0.0, 1.0],
        ),
        borderRadius: BorderRadius.circular(8.r),
        boxShadow: [
          BoxShadow(
            color: const Color(0x29000000),
            offset: const Offset(0, 4),
            blurRadius: 13,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Rank and Name Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  CustomText(
                    text: profileController.profileData.value.data?.rank.toString()?? "N/A",
                    fontWeight: FontWeight.w700,
                    color: AppColors.orangeColor,
                    fontSize: 20.sp,
                  ),
                  Gap(10.w),
                  CustomText(
                    text:   profileController.profileData.value.data?.name ?? "N/A",
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
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  child: CustomText(
                    text: 'Your Rank',
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                    fontSize: 14.sp,
                  ),
                ),
              ),
            ],
          ),

          Gap(10.h),

          // Prize Amount and Deals info
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50),
            child: Row(
              children: [
                CustomText(
                  text: "€${profileController.profileData.value.data?.salesCount.toString() ?? "N/A"}",
                  fontWeight: FontWeight.w500,
                  color: AppColors.white,
                  fontSize: 16.sp,
                ),
                Gap(10.w),
                CustomText(
                  text: ' ${profileController.profileData.value.data?.dealCount.toString() ?? "N/A"}Deals',
                  fontWeight: FontWeight.w400,
                  color: AppColors.white.withOpacity(0.72),
                  fontSize: 14.sp,
                ),
              ],
            ),
          ),

          Gap(8.h),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50),
            child: CustomText(
              text: 'Silver League',
              fontWeight: FontWeight.w700,
              color: AppColors.orangeColor,
              fontSize: 14.sp,
            ),
          ),
        ],
      ),
    );
  }


  Widget _buildCompetitionBanner() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFF2A1B6A), // Dark purple
            Color(0xFF4A2A8A), // Lighter purple
          ],
          stops: [0.0, 1.0],
        ),
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            offset: Offset(0, 2),
            blurRadius: 4.0,
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.access_time, // Clock icon
            color: Colors.white,
            size: 20.0,
          ),
          SizedBox(width: 8.0),
          Text(
            'Competition ends July: ',
            style: TextStyle(
              fontSize: 16.0,
              color: Colors.white,
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(width: 4.0),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
            decoration: BoxDecoration(
              color: Color(0xFF6A3E9A).withOpacity(0.8), // Slightly lighter purple for highlight
              borderRadius: BorderRadius.circular(4.0),
            ),
            child: Text(
              '12 Days Left',
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }



}