import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LeaderBoardCard extends StatelessWidget {
  final String trophyImage;
  final String rank;
  final String name;
  final String amount;
  final String deals;
  final String league;
  final Color trophyColor;

  const LeaderBoardCard({
    super.key,
    required this.trophyImage,
    required this.rank,
    required this.name,
    required this.amount,
    required this.deals,
    required this.league,
    required this.trophyColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.09),
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
                  Image.asset(
                    trophyImage,
                    width: 22.w,
                    height: 20.h,
                  ),
                  SizedBox(width: 8.w),
                  Text(
                    rank,
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 20.sp,
                      color: trophyColor,
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Text(
                    name,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 18.sp,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 50.w),
            child: Row(
              children: [
                Text(
                  amount,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16.sp,
                    color: Colors.white,
                  ),
                ),
                SizedBox(width: 10.w),
                Text(
                  deals,
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 14.sp,
                    color: Colors.white.withOpacity(0.72),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 50.w),
            child: Text(
              league,
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 14.sp,
                color: trophyColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
