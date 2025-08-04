import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import 'package:get/get.dart';
import 'package:pet_donation/app/common%20widget/common_search_bar.dart';
import 'package:pet_donation/app/common%20widget/custom_calender.dart';
import 'package:pet_donation/app/modules/view_details/views/view_details_view.dart';

import '../../home/widgets/target_widgets.dart';
import '../../view_details/controllers/image_controller.dart';
import '../controllers/sales_controller.dart';
import 'package:flutter/material.dart';

import 'package:pet_donation/app/modules/home/widgets/rececnt_deatils_widgets.dart';

import '../widgets/common_search_bar_with_filter.dart';

class SalesView extends GetView<SalesController> {
  SalesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      child: Column(
        children: [
          TargetProgressCard(
            title: 'Monthly Target',
            progressValue: 0.5,
            achievedText: 'Achieved: €5,000 of €10,000',
            percentageLabel: '50%',
            footerMessage: "You're halfway there! 🎉",
          ),
          Gap(20.h),
          CustomCalendarWidget(),
          Gap(20.h),
          CommonSearchbarWithFilter(
            onSearch: (val) {
              print("Search text: $val");
            },
            // Optional, in case you want to do extra stuff

          ),

          Gap(20.h),
          RecentDetails(
            color: Color(0xFF16A34A),
            tagLabel: 'New',
            companyName: 'TechSavy Solutions Ltd.',
            startDate: '28 May, 2025',
            endDate: 'N/A',
            revenueTarget: '€10,000',
            revenueClosed: '€0.00',
            commissionEarned: '€0.00',
            onViewDetailsTap: () {
              Get.to(() => ViewDetailsView());

              print('View Details tapped');
            },
          ),
          Gap(10.h),
          RecentDetails(
            color: Color(0xFF0094B5),
            tagLabel: 'Open',
            companyName: 'TechSavy Solutions Ltd.',
            startDate: '28 May, 2025',
            endDate: 'N/A',
            revenueTarget: '€10,000',
            revenueClosed: '€0.00',
            commissionEarned: '€0.00',
            onViewDetailsTap: () {
              Get.to(() => ViewDetailsView());

              print('View Details tapped');
            },
          ),
          Gap(10.h),
          RecentDetails(
            color: Colors.red,
            tagLabel: 'Closed',
            companyName: 'TechSavy Solutions Ltd.',
            startDate: '28 May, 2025',
            endDate: 'N/A',
            revenueTarget: '€10,000',
            revenueClosed: '€0.00',
            commissionEarned: '€0.00',
            onViewDetailsTap: () {
              Get.to(() => ViewDetailsView());
              print('View Details tapped');
            },
          ),
        ],
      ),
    );
  }
}
