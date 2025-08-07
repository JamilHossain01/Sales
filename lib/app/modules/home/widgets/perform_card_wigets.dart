
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wolf_pack/app/common%20widget/custom%20text/custom_text_widget.dart';
import 'package:wolf_pack/app/uitilies/app_colors.dart';

class PerformerCard extends StatelessWidget {
  final int rank;
  final String name;
  final String earnings;
  final Color rankColor;
  final Color? backroundColor;

  const PerformerCard({
    super.key,
    required this.rank,
    required this.name,
    required this.earnings,
    required this.rankColor,  this.backroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10.h),
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color:backroundColor,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              CustomText(
                text: '#$rank',
                fontSize: 14.sp,
                color: rankColor,
                fontWeight: FontWeight.w500,
              ),
              const SizedBox(width: 10),
              CustomText(
                text: name,
                fontSize: 14.sp,
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ],
          ),
          CustomText(
            text: earnings,
            fontSize: 14.sp,
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ],
      ),
    );
  }
}
