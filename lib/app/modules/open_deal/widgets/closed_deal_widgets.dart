import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:wolf_pack/app/modules/open_deal/widgets/export_widgets.dart';
import 'package:wolf_pack/app/modules/view_details/widgets/location_tile.dart';
import 'package:wolf_pack/app/uitilies/app_colors.dart';

import '../../../common_widget/custom text/custom_text_widget.dart';



class OpenClientDetailsForm extends StatelessWidget {
  const OpenClientDetailsForm({super.key});

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
        buildRow(text: 'Proposition',text1: 'XYZ Coaching Academy'),
        Gap(10.h),

        LocationTile(
          label: "Deal Date",
          value: "April 1, 2025",
        ),
        Gap(10.h),

        buildRow(text: 'Deal Amount',text1: ' €7,500'),

        Gap(10.h),

        const LocationTile(
          value: 'Status',
          label: 'New',
        ),
        Gap(10.h),


        CustomText(
          text: "Notes",
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
        ) ,   CustomText(
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
        Divider(color: AppColors.textGray,),
        CustomText(
          text: "Document",
          fontSize: 16.sp,
          fontWeight: FontWeight.w300,
          color: Colors.white.withOpacity(0.82),
        ),
        Gap(10.h),
        // LocationTile(
        //   child: Column(
        //     crossAxisAlignment: CrossAxisAlignment.start,
        //     children: [
        //       CustomText(
        //         text: "Small healthcare clinics and private doctors",
        //         fontSize: 14.sp,
        //         fontWeight: FontWeight.w300,
        //         color: Colors.white.withOpacity(0.82),
        //       ),
        //       CustomText(
        //         text: "offices",
        //         fontSize: 14.sp,
        //         fontWeight: FontWeight.w300,
        //         color: Colors.white.withOpacity(0.82),
        //       ),
        //     ],
        //   ),
        // ),
        ExportContainerWidgets(),

        Gap(10.h),
        ExportContainerWidgets(title: 'Invoice.pdf',),    Gap(10.h),
        ExportContainerWidgets(title: 'Image1.jpg',),




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
