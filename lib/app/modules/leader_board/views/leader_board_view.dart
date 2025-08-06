import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import 'package:get/get.dart';
import 'package:pet_donation/app/common%20widget/custom%20text/custom_text_widget.dart';
import 'package:pet_donation/app/modules/home/widgets/target_widgets.dart';
import 'package:pet_donation/app/modules/leader_board/widgets/month_league_widgets.dart';
import 'package:pet_donation/app/uitilies/app_colors.dart';
import 'package:pet_donation/app/uitilies/app_images.dart';

import '../../home/controllers/my_clients_controller.dart';
import '../controllers/leader_board_controller.dart';

class LeaderBoardView extends GetView<LeaderBoardController> {
   LeaderBoardView({super.key});
  final LeaderBoardController controller = Get.put(LeaderBoardController());
   final MyClientGetController dealController = Get.put(MyClientGetController());
  @override
  Widget build(BuildContext context) {
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
                          text: controller.leaderBoardData.value.data?.rank.toString() ?? "",
                          fontWeight: FontWeight.w700,
                          color: AppColors.orangeColor,
                          fontSize: 20.sp,
                        ),
                        Gap(10.w),
                        CustomText(
                          text:dealController.dealData.value.data?.data[0].name ??  'N/A',
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
                          ),                        Gap(10.w),

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
          CustomText(
            text: 'Top Performers',
            fontWeight: FontWeight.w400,
            color: AppColors.white.withOpacity(0.72),
            fontSize: 14.sp,
          ),
          Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: AppColors.white.withOpacity(0.090),

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
                        SizedBox(
                          child: Image.asset(AppImages.trophy,width: 22.w,height: 20.h
                            ,),
                        ),
                        CustomText(
                          text: '1',
                          fontWeight: FontWeight.w700,
                          color: AppColors.orangeColor,
                          fontSize: 20.sp,
                        ),
                        Gap(10.w),
                        CustomText(
                          text: 'Alex Thompson',
                          fontWeight: FontWeight.w500,
                          color: AppColors.white,
                          fontSize: 18.sp,
                        ),
                      ],
                    ),

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
                          ),                        Gap(10.w),

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
          Gap(10.h),

          Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: AppColors.white.withOpacity(0.090),

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
                        SizedBox(
                          child: Image.asset(AppImages.trophy,width: 22.w,height: 20.h
                            ,),
                        ),
                        CustomText(
                          text: '2',
                          fontWeight: FontWeight.w700,
                          color: AppColors.orangeColor,
                          fontSize: 20.sp,
                        ),
                        Gap(10.w),
                        CustomText(
                          text: 'Sarah johson',
                          fontWeight: FontWeight.w500,
                          color: AppColors.white,
                          fontSize: 18.sp,
                        ),
                      ],
                    ),

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
                          ),                        Gap(10.w),

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
          CustomText(
            text: 'Other Performers',
            fontWeight: FontWeight.w400,
            color: AppColors.white.withOpacity(0.72),
            fontSize: 14.sp,
          ),
          Gap(20.h),
          Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: AppColors.white.withOpacity(0.090),

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
                        SizedBox(
                          child: Image.asset(AppImages.trophy,width: 22.w,height: 20.h
                            ,),
                        ),
                        CustomText(
                          text: '3',
                          fontWeight: FontWeight.w700,
                          color: AppColors.orangeColor,
                          fontSize: 20.sp,
                        ),
                        Gap(10.w),
                        CustomText(
                          text: 'Mike Thompson',
                          fontWeight: FontWeight.w500,
                          color: AppColors.white,
                          fontSize: 18.sp,
                        ),
                      ],
                    ),

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
                          ),                        Gap(10.w),

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

        ],
      ),
    );
  }
}
