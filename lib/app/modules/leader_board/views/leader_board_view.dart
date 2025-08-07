import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import 'package:get/get.dart';
import 'package:wolf_pack/app/common%20widget/custom%20text/custom_text_widget.dart';
import 'package:wolf_pack/app/modules/home/widgets/target_widgets.dart';
import 'package:wolf_pack/app/modules/leader_board/widgets/month_league_widgets.dart';
import 'package:wolf_pack/app/uitilies/app_colors.dart';
import 'package:wolf_pack/app/uitilies/app_images.dart';
import 'package:wolf_pack/app/uitilies/custom_loader.dart';

import '../../home/controllers/my_clients_controller.dart';
import '../controllers/leader_board_controller.dart';
import '../widgets/leader_board_card.dart';

class LeaderBoardView extends GetView<LeaderBoardController> {
  LeaderBoardView({super.key});

  final LeaderBoardController controller = Get.put(LeaderBoardController());
  final MyClientGetController dealController = Get.put(MyClientGetController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (dealController.isLoading.value) {
        return Center(child: CustomLoader());
      }
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MonthWithLeagueMenu(),
            Gap(20.h),
            TargetProgressCard(
              title: 'Progress',
              progressValue: 0.5,
              achievedText: 'Achieved: €5,000 of €10,000',
              percentageLabel: '50%',
              footerMessage: "You're halfway there! 🎉",
              motivationLine1: "You're in Jupiler League. Keep pushing",
              motivationLine2: "forEuropa League! 🏅",
            ),
            Gap(20.h),
            Container(
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.orangeColor),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    const Color(0xFFFCB806).withOpacity(0.070),
                    const Color(0xFFFCB806).withOpacity(0.070),
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          CustomText(
                            text: controller.leaderBoardData.value.data?.rank
                                    .toString() ??
                                "",
                            fontWeight: FontWeight.w700,
                            color: AppColors.orangeColor,
                            fontSize: 20.sp,
                          ),
                          Gap(10.w),
                          CustomText(
                            text: dealController
                                    .dealData.value.data?.data[0].name ??
                                'N/A',
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
                            padding: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 10),
                            child: CustomText(
                              text: 'Your Rank',
                              fontWeight: FontWeight.w700,
                              color: Colors.black,
                              fontSize: 14.sp,
                            ),
                          ))
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            CustomText(
                              text: '\$4,200',
                              fontWeight: FontWeight.w500,
                              color: AppColors.white,
                              fontSize: 16.sp,
                            ),
                            Gap(10.w),
                            CustomText(
                              text: '6 Deals',
                              fontWeight: FontWeight.w400,
                              color: AppColors.white.withOpacity(0.72),
                              fontSize: 14.sp,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
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
            ),
            Gap(20.h),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// 🔹 Top Performers Title
                CustomText(
                  text: 'Top Performers',
                  fontWeight: FontWeight.w400,
                  color: AppColors.white.withOpacity(0.72),
                  fontSize: 14.sp,
                ),
                SizedBox(height: 6.h),

                /// 🔹 Leaderboard content
                Obx(() {
                  if (controller.isLoading.value) {
                    return Center(child: CustomLoader());
                  }

                  final data = controller.leaderBoardData.value.data;

                  if (data == null || data.leaderBoard.isEmpty) {
                    return const Center(
                        child: Text("No leaderboard data found"));
                  }

                  final top10 = data.leaderBoard.take(10).toList();
                  final others = data.leaderBoard.skip(10).toList();
                  final visibleOthers =
                      others.take(controller.othersVisibleCount.value).toList();

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// 🔸 Top 10 Performers
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: top10.length,
                        itemBuilder: (context, index) {
                          final item = top10[index];
                          return Padding(
                            padding: EdgeInsets.only(bottom: 8.h),
                            child: LeaderBoardCard(
                              trophyImage: AppImages.trophy,
                              rank: (index + 1).toString(),
                              name: item.name ?? 'N/A',
                              amount: '\$${item.salesCount ?? '0'}',
                              deals: '${item.salesCount ?? 0} Deals',
                              league: 'Silver League',
                              trophyColor: AppColors.orangeColor,
                            ),
                          );
                        },
                      ),

                      /// 🔹 Other Performers Title
                      if (others.isNotEmpty) ...[
                        SizedBox(height: 16.h),
                        CustomText(
                          text: 'Other Performers',
                          fontWeight: FontWeight.w400,
                          color: AppColors.white.withOpacity(0.72),
                          fontSize: 14.sp,
                        ),
                        SizedBox(height: 6.h),
                      ],

                      /// 👥 Visible Other Performers
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: visibleOthers.length,
                        itemBuilder: (context, index) {
                          final item = visibleOthers[index];
                          final rank =
                              index + 11; // since top 10 are already shown
                          return Padding(
                            padding: EdgeInsets.only(bottom: 8.h),
                            child: LeaderBoardCard(
                              trophyImage: AppImages.trophy,
                              rank: rank.toString(),
                              name: item.name ?? 'N/A',
                              amount: '\$${item.salesCount ?? '0'}',
                              deals: '${item.salesCount ?? 0} Deals',
                              league: 'Silver League',
                              trophyColor: AppColors.white.withOpacity(0.6),
                            ),
                          );
                        },
                      ),

                      /// 🔘 Load More Button
                      if (visibleOthers.length < others.length)
                        Center(
                          child: TextButton(
                            onPressed: controller.loadMoreOthers,
                            child: Text(
                              "Load More",
                              style: TextStyle(
                                color: AppColors.orangeColor,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                    ],
                  );
                }),
              ],
            )
          ],
        ),
      );
    });
  }
}
