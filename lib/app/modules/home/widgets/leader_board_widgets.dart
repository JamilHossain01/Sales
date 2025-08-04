import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pet_donation/app/common%20widget/custom%20text/custom_text_widget.dart';
import 'package:pet_donation/app/common%20widget/custom_header_widgets.dart';
import 'package:pet_donation/app/modules/home/widgets/perform_card_wigets.dart';
import 'package:pet_donation/app/uitilies/app_images.dart';

import '../../../uitilies/app_colors.dart';

class LeaderboardCard extends StatelessWidget {
  final String rank;
  final String league;
  final String leagueName;
  final List<PerformerCard> performers;
  final String motivationLine1;
  final String motivationLine2;

  const LeaderboardCard({
    Key? key,
    required this.rank,
    required this.league,
    required this.leagueName,
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
                  color:  AppColors.orangeColor,

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
          CustomText(
            text: league,
            fontWeight: FontWeight.w400,
            fontSize: 14.sp,
            color: AppColors.white,
          ),
          CustomText(
            text: leagueName,
            fontWeight: FontWeight.w400,
            fontSize: 12.sp,
            color: Color(0xFF00D1FF),
          ),
          HeaderWidgets(title: 'Top Performers', subTitle: 'View All'),
          ...performers,
          Container(
            width: double.infinity,
            margin: EdgeInsets.only(bottom: 10.h),
            padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            decoration: BoxDecoration(
              color: Color(0xFF00D1FF).withOpacity(0.13),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomText(
                  text: motivationLine1,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF00D1FF),
                ),
                CustomText(
                  text: motivationLine2,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF00D1FF),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
