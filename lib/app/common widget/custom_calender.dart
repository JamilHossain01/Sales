import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pet_donation/app/uitilies/app_colors.dart';
import 'package:pet_donation/app/common%20widget/custom%20text/custom_text_widget.dart';
import 'package:pet_donation/app/uitilies/app_images.dart';

class CustomCalendarWidget extends StatefulWidget {
  const CustomCalendarWidget({Key? key}) : super(key: key);

  @override
  State<CustomCalendarWidget> createState() => _CustomCalendarWidgetState();
}

class _CustomCalendarWidgetState extends State<CustomCalendarWidget> {
  DateTime selectedDate = DateTime.now();

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

  @override
  Widget build(BuildContext context) {
    final weekDates = getWeekDates(selectedDate);

    return Column(
      children: [
        /// ===== Month, Year & Arrows Row =====
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(onPressed: _goToPreviousWeek, icon: const Icon(Icons.arrow_back_ios, color: Colors.white)),
            Row(
              children: [
                CustomText(
                  text: "${_monthName(selectedDate.month)}, ${selectedDate.year}",
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
                SizedBox(width: 8.w),
                Image.asset(AppImages.spCalendar,height: 24.h,width: 24.w
                    , color: Colors.white)
              ],
            ),
            IconButton(onPressed: _goToNextWeek, icon: const Icon(Icons.arrow_forward_ios, color: Colors.white)),
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
              final isSelected = date.day == selectedDate.day &&
                  date.month == selectedDate.month &&
                  date.year == selectedDate.year;

              return GestureDetector(
                onTap: () {
                  setState(() => selectedDate = date);
                },
                child: Container(
                  width: 48.w,
                  padding: EdgeInsets.symmetric(vertical: 10.h),
                  decoration: BoxDecoration(
                    color: isSelected ? Colors.transparent : Colors.transparent,
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
                        color: isSelected ? AppColors.orangeColor : Colors.white.withOpacity(0.7),
                      ),

                    ],
                  ),
                ),
              );
            },
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
