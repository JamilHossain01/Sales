import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wolf_pack/app/uitilies/app_images.dart';

import '../../../common_widget/custom text/custom_text_widget.dart';
import '../../../common_widget/custom_button.dart';
import '../../../uitilies/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wolf_pack/app/uitilies/app_images.dart';
import '../../../common_widget/custom text/custom_text_widget.dart';
import '../../../common_widget/custom_button.dart';
import '../../../uitilies/app_colors.dart';

// lib/app/modules/home/widgets/rececnt_deatils_widgets.dart

class RecentDetails extends StatelessWidget {
  final String tagLabel;
  final String companyName;
  final String assignDate;
  final String offer;
  final String commissionRate;
  final Color? color;
  final VoidCallback? onViewDetailsTap; // nullable

  const RecentDetails({
    Key? key,
    required this.tagLabel,
    required this.companyName,
    required this.assignDate,
    required this.offer,
    required this.commissionRate,
    this.color,
    this.onViewDetailsTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 10.h),
      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      decoration: BoxDecoration(
        color: const Color(0xFFFFFFFF).withOpacity(0.09),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Tag
          Container(
            width: 100.w,
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
            decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(50.r)),
            child: CustomText(text: tagLabel, fontSize: 12.sp, fontWeight: FontWeight.w400, color: AppColors.white),
          ),
          SizedBox(height: 8.h),
          CustomText(text: companyName, fontSize: 16.sp, fontWeight: FontWeight.w600, color: AppColors.white),
          SizedBox(height: 8.h),
          _rowText(text: 'Offer -', text1: offer),
          _rowText(text: 'Commission Rate -', text1: commissionRate),
          _rowText(text: 'Assign Date -', text1: assignDate),

          // বাটন শুধু তখনই দেখাবে যদি onViewDetailsTap না null হয়
          if (onViewDetailsTap != null) ...[
            SizedBox(height: 12.h),
            CustomButton(
              leftIcon:  Icon(Icons.remove_red_eye_outlined, color: AppColors.white),
              border: Border.all(color: AppColors.white, width: 0.25),
              title: 'View Details',
              onTap: onViewDetailsTap!,
            ),
          ],
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
          CustomText(text: text, fontSize: 11.sp, fontWeight: FontWeight.w400, color: AppColors.white),
          CustomText(text: text1, fontSize: 11.sp, fontWeight: FontWeight.w400, color: AppColors.white),
        ],
      ),
    );
  }
}




// class RecentDetails extends StatelessWidget {
//   final String tagLabel;
//   final String companyName;
//   final String startDate;
//   final String endDate;
//   final String revenueTarget;
//   final String revenueClosed;
//   final String commissionEarned;
//   final Color? color;
//
//   final VoidCallback onViewDetailsTap;
//
//   const RecentDetails({
//     Key? key,
//     required this.tagLabel,
//     required this.companyName,
//     required this.startDate,
//     required this.endDate,
//     required this.revenueTarget,
//     required this.revenueClosed,
//     required this.commissionEarned,
//     required this.onViewDetailsTap, this.color,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: double.infinity,
//       margin: EdgeInsets.only(bottom: 10.h),
//       padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
//       decoration: BoxDecoration(
//         color: Color(0xFFFFFFFF).withOpacity(0.09),
//         borderRadius: BorderRadius.circular(8.r),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Container(
//             width: 100.w
//             ,
//             padding: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
//             decoration: BoxDecoration(
//               color: color,
//               borderRadius: BorderRadius.circular(50.r),
//             ),
//             child: CustomText(
//               text: tagLabel,
//               fontSize: 12.sp,
//               fontWeight: FontWeight.w400,
//               color: AppColors.white,
//             ),
//           ),
//           SizedBox(height: 8.h),
//           CustomText(
//             text: companyName,
//             fontSize: 16.sp,
//             fontWeight: FontWeight.w600,
//             color: AppColors.white,
//           ),
//           SizedBox(height: 8.h),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               _rowText(text: 'Start Date -', text1: startDate),
//               _rowText(text: 'Ending date -', text1: endDate),
//             ],
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               _rowText(text: 'Revenue Target - ', text1: revenueTarget),
//               _rowText(text: 'Revenue Closed -', text1: revenueClosed),
//             ],
//           ),
//           _rowText(text: 'Commission Earned - $commissionEarned', text1: ''),
//           SizedBox(height: 12.h),
//           CustomButton(
//             leftIcon:Icon(Icons.remove_red_eye_outlined,color: AppColors.white,),
//             // buttonColor: AppColors.orangeColor.withOpacity(0.05),
//             border: Border.all(color: AppColors.white, width: 0.25),
//             title: 'View Details',
//             onTap: onViewDetailsTap,
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _rowText({required String text, required String text1}) {
//     return Padding(
//       padding: EdgeInsets.symmetric(vertical: 6.h),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           CustomText(
//             text: text,
//             fontSize: 11.sp,
//             fontWeight: FontWeight.w400,
//             color: AppColors.white,
//           ),
//           CustomText(
//             text: text1,
//             fontSize: 11.sp,
//             fontWeight: FontWeight.w400,
//             color: AppColors.white,
//           ),
//         ],
//       ),
//     );
//   }
// }
