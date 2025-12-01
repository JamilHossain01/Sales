import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:wolf_pack/app/modules/home/widgets/perform_card_wigets.dart';
import 'package:wolf_pack/app/uitilies/app_images.dart';

import '../../../common_widget/custom text/custom_text_widget.dart';
import '../../../common_widget/custom_header_widgets.dart';
import '../../../uitilies/app_colors.dart';

class LeaderboardCard extends StatelessWidget {
  final String rank;
  // final String league;
  // final String leagueName;
  final List<PerformerCard> performers;
  final String motivationLine1;
  final String motivationLine2;

  const LeaderboardCard({
    Key? key,
    required this.rank,
    // required this.league,
    // required this.leagueName,
    required this.performers,
    required this.motivationLine1,
    required this.motivationLine2,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: AppColors.white.withOpacity(0.09),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(
                text: 'Your Rank',
                fontWeight: FontWeight.w500,
                fontSize: 14.sp,
                color: AppColors.white,
              ),
              Container(
                child: Image.asset(
                  AppImages.leaderboards,
                  height: 20.h,
                  width: 20.w,
                  color: AppColors.orangeColor,
                ),
              ),
            ],
          ),
          CustomText(
            text: rank,
            fontWeight: FontWeight.w500,
            fontSize: 40.sp,
            color: AppColors.orangeColor,
          ),
          // CustomText(
          //   text: league,
          //   fontWeight: FontWeight.w400,
          //   fontSize: 14.sp,
          //   color: AppColors.white,
          // ),
          // CustomText(
          //   text: leagueName,
          //   fontWeight: FontWeight.w400,
          //   fontSize: 12.sp,
          //   color: Color(0xFF00D1FF),
          // ),
          // HeaderWidgets(title: 'Hall of Fame', subTitle: 'View All'),
          ...performers,
          Container(
            width: double.infinity,
            margin: EdgeInsets.only(bottom: 10.h),
            padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [],
            ),
          ),
        ],
      ),
    );
  }
}
