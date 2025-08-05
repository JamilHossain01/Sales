import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pet_donation/app/modules/closed_deal/views/closed_deal_view.dart';
import 'package:pet_donation/app/modules/open_deal/views/open_deal_view.dart';
import 'package:pet_donation/app/modules/view_details/views/view_details_view.dart';
import 'package:pet_donation/app/uitilies/app_colors.dart';

class CommonSearchbarWithFilter extends StatefulWidget {
  final Function(String)? onSearch;

  const CommonSearchbarWithFilter({
    super.key,
    this.onSearch,
  });

  @override
  State<CommonSearchbarWithFilter> createState() => _CommonSearchbarWithFilterState();
}

class _CommonSearchbarWithFilterState extends State<CommonSearchbarWithFilter> {
  String selectedStatus = 'Status';
  final List<String> statusOptions = ['Status', 'New', 'Open', 'Closed'];

  void handleStatusChange(BuildContext context, String? status) {
    if (status == null || status == 'Status') return;

    setState(() {
      selectedStatus = status;
    });

    switch (status) {
      case 'New':
        Get.to(()=>OpenDealView(clientId: '',));


        break;
      case 'Open':
        Get.to(()=>ViewDetailsView());
        break;
      case 'Closed':
        Get.to(()=>ClosedDealView());
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        /// 🔍 Search Field
        Expanded(
          child: Container(
            height: 45.h,
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.orangeColor),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Row(
              children: [
                Icon(Icons.search, color: AppColors.orangeColor, size: 18.sp),
                SizedBox(width: 8.w),
                Expanded(
                  child: TextField(
                    onChanged: widget.onSearch,
                    style: TextStyle(color: AppColors.orangeColor),
                    cursorColor: AppColors.orangeColor,
                    decoration: InputDecoration(
                      hintText: 'Search here..',
                      hintStyle: TextStyle(color: AppColors.orangeColor),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(width: 10.w),

        /// ⬇️ Status Dropdown
        Container(
          height: 45.h,
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          decoration: BoxDecoration(
            color: const Color(0xFF6C4D0C),
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              dropdownColor: const Color(0xFF6C4D0C),
              value: selectedStatus,
              icon: const Icon(Icons.keyboard_arrow_down, color: Colors.white),
              items: statusOptions.map((String status) {
                return DropdownMenuItem<String>(
                  value: status,
                  child: Text(
                    status,
                    style: const TextStyle(color: Colors.white),
                  ),
                );
              }).toList(),
              onChanged: (value) => handleStatusChange(context, value),
            ),
          ),
        ),
      ],
    );
  }
}

