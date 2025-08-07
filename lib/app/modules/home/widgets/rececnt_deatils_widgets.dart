import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wolf_pack/app/common%20widget/custom_button.dart';
import 'package:wolf_pack/app/uitilies/app_images.dart';

import '../../../common widget/custom text/custom_text_widget.dart';
import '../../../uitilies/app_colors.dart';

class RecentDetails extends StatelessWidget {
  final String tagLabel;
  final String companyName;
  final String startDate;
  final String endDate;
  final String revenueTarget;
  final String revenueClosed;
  final String commissionEarned;
  final Color? color;

  final VoidCallback onViewDetailsTap;

  const RecentDetails({
    Key? key,
    required this.tagLabel,
    required this.companyName,
    required this.startDate,
    required this.endDate,
    required this.revenueTarget,
    required this.revenueClosed,
    required this.commissionEarned,
    required this.onViewDetailsTap, this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 10.h),
      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      decoration: BoxDecoration(
        color: Color(0xFFFFFFFF).withOpacity(0.09),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 100.w
            ,
            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(50.r),
            ),
            child: CustomText(
              text: tagLabel,
              fontSize: 12.sp,
              fontWeight: FontWeight.w400,
              color: AppColors.white,
            ),
          ),
          SizedBox(height: 8.h),
          CustomText(
            text: companyName,
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.white,
          ),
          SizedBox(height: 8.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _rowText(text: 'Start Date -', text1: startDate),
              _rowText(text: 'Ending date -', text1: endDate),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _rowText(text: 'Revenue Target - ', text1: revenueTarget),
              _rowText(text: 'Revenue Closed -', text1: revenueClosed),
            ],
          ),
          _rowText(text: 'Commission Earned - $commissionEarned', text1: ''),
          SizedBox(height: 12.h),
          CustomButton(
            leftIcon:Icon(Icons.remove_red_eye_outlined,color: AppColors.white,),
            // buttonColor: AppColors.orangeColor.withOpacity(0.05),
            border: Border.all(color: AppColors.white, width: 0.25),
            title: 'View Details',
            onTap: onViewDetailsTap,
          ),
        ],
      ),
    );
  }

  Widget _rowText({required String text, required String text1}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomText(
            text: text,
            fontSize: 12.sp,
            fontWeight: FontWeight.w400,
            color: AppColors.white,
          ),
          CustomText(
            text: text1,
            fontSize: 12.sp,
            fontWeight: FontWeight.w400,
            color: AppColors.white,
          ),
        ],
      ),
    );
  }
}
