import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wolf_pack/app/uitilies/app_colors.dart';
import 'package:wolf_pack/app/uitilies/app_images.dart';

import 'custom text/custom_text_widget.dart';

class CustomCalendarWidget extends StatefulWidget {
  final Function(DateTime)? onDateSelected;
  final Function()? onClearDate;
  final DateTime? selectedFilterDate;

  const CustomCalendarWidget({
    Key? key,
    this.onDateSelected,
    this.onClearDate,
    this.selectedFilterDate,
  }) : super(key: key);

  @override
  State<CustomCalendarWidget> createState() => _CustomCalendarWidgetState();
}

class _CustomCalendarWidgetState extends State<CustomCalendarWidget> {
  DateTime selectedDate = DateTime.now();
  DateTime? selectedFilterDate;

  @override
  void initState() {
    super.initState();
    selectedFilterDate = widget.selectedFilterDate;
  }

  @override
  void didUpdateWidget(covariant CustomCalendarWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.selectedFilterDate != oldWidget.selectedFilterDate) {
      selectedFilterDate = widget.selectedFilterDate;
    }
  }

  List<DateTime> getWeekDates(DateTime date) {
    final firstDay = date.subtract(Duration(days: date.weekday - 1));
    return List.generate(7, (index) => firstDay.add(Duration(days: index)));
  }

  void _goToPreviousWeek() {
    setState(() {
      selectedDate = selectedDate.subtract(const Duration(days: 7));
    });
  }

  void _goToNextWeek() {
    setState(() {
      selectedDate = selectedDate.add(const Duration(days: 7));
    });
  }

  void _handleDateSelection(DateTime date) {
    setState(() {
      if (selectedFilterDate != null &&
          selectedFilterDate!.day == date.day &&
          selectedFilterDate!.month == date.month &&
          selectedFilterDate!.year == date.year) {
        // Clear selection if same date is tapped
        selectedFilterDate = null;
        widget.onClearDate?.call();
      } else {
        // Select new date
        selectedFilterDate = date;
        widget.onDateSelected?.call(date);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final weekDates = getWeekDates(selectedDate);

    return Column(
      children: [
        /// ===== Month, Year & Arrows Row =====
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
                onPressed: _goToPreviousWeek,
                icon: const Icon(Icons.arrow_back_ios, color: Colors.white)
            ),
            Row(
              children: [
                CustomText(
                  text: "${_monthName(selectedDate.month)}, ${selectedDate.year}",
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
                SizedBox(width: 8.w),
                Image.asset(
                    AppImages.spCalendar,
                    height: 24.h,
                    width: 24.w,
                    color: Colors.white
                )
              ],
            ),
            IconButton(
                onPressed: _goToNextWeek,
                icon: const Icon(Icons.arrow_forward_ios, color: Colors.white)
            ),
          ],
        ),

        SizedBox(height: 10.h),

        /// ===== Date Selector Row =====
        SizedBox(
          height: 90.h,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            itemCount: weekDates.length,
            separatorBuilder: (_, __) => SizedBox(width: 10.w),
            itemBuilder: (context, index) {
              final date = weekDates[index];
              final isSelected = selectedFilterDate != null &&
                  date.day == selectedFilterDate!.day &&
                  date.month == selectedFilterDate!.month &&
                  date.year == selectedFilterDate!.year;

              return GestureDetector(
                onTap: () => _handleDateSelection(date),
                child: Container(
                  width: 48.w,
                  padding: EdgeInsets.symmetric(vertical: 10.h),
                  decoration: BoxDecoration(
                    color: isSelected ? AppColors.orangeColor.withOpacity(0.2) : Colors.transparent,
                    border: Border.all(
                      color: isSelected ? AppColors.orangeColor : Colors.transparent,
                      width: 1.2,
                    ),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomText(
                        text: "${date.day}",
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: isSelected ? AppColors.orangeColor : Colors.white,
                      ),
                      CustomText(
                        text: _weekdayShort(date.weekday),
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                        color: isSelected
                            ? AppColors.orangeColor
                            : Colors.white.withOpacity(0.7),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),

        // Clear date button when a date is selected
        if (selectedFilterDate != null)
          Padding(
            padding: EdgeInsets.only(top: 10.h),
            child: TextButton(
              onPressed: () {
                setState(() => selectedFilterDate = null);
                widget.onClearDate?.call();
              },
              child: CustomText(
                text: "Clear date",
                color: AppColors.orangeColor,
                fontSize: 14.sp,
              ),
            ),
          ),
      ],
    );
  }

  String _monthName(int month) {
    const months = [
      "January", "February", "March", "April", "May", "June",
      "July", "August", "September", "October", "November", "December"
    ];
    return months[month - 1];
  }

  String _weekdayShort(int weekday) {
    const weekdays = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"];
    return weekdays[weekday - 1];
  }
}