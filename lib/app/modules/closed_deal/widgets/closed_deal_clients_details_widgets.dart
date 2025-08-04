import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:pet_donation/app/common%20widget/custom%20text/custom_text_widget.dart';
import 'package:pet_donation/app/modules/open_deal/widgets/export_widgets.dart';
import 'package:pet_donation/app/modules/view_details/widgets/location_tile.dart';
import 'package:pet_donation/app/uitilies/app_colors.dart';

class ClosedDealClintDeatilsView extends StatelessWidget {
  const ClosedDealClintDeatilsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const LocationTile(
          label: "Client Name",
          value: "TechSavvy Solutions Ltd",
        ),
        Gap(10.h),
        CustomText(
          text: "Service",
          fontSize: 16.sp,
          color: Colors.white.withOpacity(0.82),
        ),
        Gap(10.h),
        CustomText(
          text: "Custom software development for small",
          fontSize: 16.sp,
          fontWeight: FontWeight.w300,
          color: Colors.white.withOpacity(0.82),
        ),
        CustomText(
          text: "businesses in healthcare",
          fontSize: 16.sp,
          fontWeight: FontWeight.w300,
          color: Colors.white.withOpacity(0.82),
        ),
        Gap(10.h),

        LocationTile(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                text: "Target Audience",
                fontSize: 16.sp,
                color: Colors.white.withOpacity(0.82),
              ),
              Gap(5.h),
              CustomText(
                text: "Small healthcare clinics and private",
                fontSize: 16.sp,
                fontWeight: FontWeight.w300,
                color: Colors.white.withOpacity(0.82),
              ),
              CustomText(
                text: "doctors offices",
                fontSize: 16.sp,
                fontWeight: FontWeight.w300,
                color: Colors.white.withOpacity(0.82),
              ),
            ],
          ),
        ),
        Gap(10.h),

        buildRow(text: 'Contact', text1: 'contact12345@gmail.com'),
        Gap(10.h),
        LocationTile(
          label: "Deal Date",
          value: "April 1, 2025",
        ),
        Gap(10.h),
        buildRow(text: 'Deal Amount', text1: ' €7,500'),
        Gap(10.h),
        const LocationTile(
          label: 'Location',
          value: ' Berlin, CET',
        ),
        Gap(10.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomText(
              text: "Revenue Target",
              fontSize: 16.sp,
              color: Colors.white.withOpacity(0.82),
            ),
            CustomText(
              text: " €10,000",
              fontSize: 16.sp,
              fontWeight: FontWeight.w300,
              color: Colors.white.withOpacity(0.82),
            ),
          ],
        ),
        Gap(10.h),
        LocationTile(
          label: 'Revenue Closed',
          value: ' €0.00',
        ),
        Gap(10.h),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomText(
              text: "Commission",
              fontSize: 16.sp,
              color: Colors.white.withOpacity(0.82),
            ),
            CustomText(
              text: "12%",
              fontSize: 16.sp,
              fontWeight: FontWeight.w300,
              color: Colors.white.withOpacity(0.82),
            ),
          ],
        ),
        Gap(10.h),
        LocationTile(
          label: 'Status',
          value: 'Closed',
        ),
      ],
    );
  }

  Widget buildRow({String? text, String? text1}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomText(
          text: text ?? '',
          fontSize: 16.sp,
          fontWeight: FontWeight.w500,
          color: Colors.white.withOpacity(0.82),
        ),
        CustomText(
          text: text1 ?? '',
          fontWeight: FontWeight.w300,
          fontSize: 14.sp,
          color: Colors.white.withOpacity(0.82),
        ),
      ],
    );
  }
}
