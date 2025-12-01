import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:wolf_pack/app/modules/closed_deal/views/closed_deal_view.dart';
import 'package:wolf_pack/app/modules/open_deal/views/new_deal_view.dart';
import 'package:wolf_pack/app/modules/view_details/views/view_details_view.dart';
import 'package:wolf_pack/app/uitilies/app_colors.dart';
import 'package:wolf_pack/app/uitilies/app_images.dart';

import '../../../common_widget/custom text/custom_text_widget.dart';

class MonthWithLeagueMenu extends StatefulWidget {
  final Function(String)? onSearch;

  const MonthWithLeagueMenu({super.key, this.onSearch});

  @override
  State<MonthWithLeagueMenu> createState() => _MonthWithLeagueMenuState();
}

class _MonthWithLeagueMenuState extends State<MonthWithLeagueMenu> {
  String selectedStatus = 'League';
  final List<String> statusOptions = ['League', 'Champions League', 'Gold League', 'Silver League'];

  void handleStatusChange(BuildContext context, String? status) {
    if (status == null || status == 'League') return;

    setState(() {
      selectedStatus = status;
    });

    // Navigation logic (replace with your own if needed)
    switch (status) {
      case 'Premier':
        Get.to(() => ViewDetailsView());
        break;
      case 'Championship':
        Get.to(() => NewDealView(clientId: '', clientName: '',));
        break;
      case 'National':
        Get.to(() => ClosedDealView(clientID: '',));
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        /// 📅 "This Month" button
        Expanded(
          child: Container(
            height: 45.h,
            padding: EdgeInsets.symmetric(horizontal: 14.w),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.09),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                  text: 'This Month',
                  color: Colors.white,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                ),
                Image.asset(
                  AppImages.spCalendar,
                  height: 20.h,
                  width: 20.w,
                  color: Colors.white,
                ),
              ],
            ),
          ),
        ),
        SizedBox(width: 10.w),

        /// ⬇️ League Dropdown
        Expanded(
          child: Container(
            height: 45.h,
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.09),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: selectedStatus,
                icon: Icon(Icons.keyboard_arrow_down, color: Colors.white),
                dropdownColor: Colors.black,
                style: TextStyle(color: Colors.white, fontSize: 14.sp),
                items: statusOptions.map((String status) {
                  return DropdownMenuItem<String>(
                    value: status,
                    child: Text(status),
                  );
                }).toList(),
                onChanged: (value) => handleStatusChange(context, value),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
