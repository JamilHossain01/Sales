import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:pet_donation/app/common%20widget/custom%20text/custom_text_widget.dart';
import 'package:pet_donation/app/uitilies/app_colors.dart';

import '../../../common widget/custom_button.dart';
import 'location_tile.dart';

class ClientDetailsForm extends StatelessWidget {
  const ClientDetailsForm({super.key});

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
                text: "Small healthcare clinics and private doctors",
                fontSize: 14.sp,
                fontWeight: FontWeight.w300,
                color: Colors.white.withOpacity(0.82),
              ),
              CustomText(
                text: "offices",
                fontSize: 14.sp,
                fontWeight: FontWeight.w300,
                color: Colors.white.withOpacity(0.82),
              ),
            ],
          ),
        ),
        Gap(10.h),
        buildRow(
          text: "Contact",
          text1: "contact12345@gmail.com",
        ),
        Gap(10.h),
        LocationTile(
          label: "Location",
          value: ' Berlin, CET',
        ),
        Gap(10.h),

        buildRow(
          text: "Revenue Target",
          text1: " €10,000",
        ),
        Gap(10.h),

        const LocationTile(
          value: 'Revenue Closed',
          label: ' €0.00',
        ),
        Gap(10.h),

        buildRow(
          text: "Commission",
          text1: "12%",
        ),
        Gap(10.h),

        const LocationTile(
          value: 'Status',
          label: 'New',
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
