import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import '../../../common_widget/custom text/custom_text_widget.dart';
import '../../../uitilies/app_colors.dart';
import '../../../uitilies/custom_loader.dart';
import '../controllers/leader_borad_get.dart';
import '../modell/filter_leader_board_model.dart';
import 'package:intl/intl.dart';   // ← This line is missing in your file!
class LeaderBoardView extends StatelessWidget {
  const LeaderBoardView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LeaderBoardGetController());

    return Obx(() {
      if (controller.isLoading.value) {
        return Center(child: CustomLoader());
      }

      final users = controller.sortedUsers;
      if (users.isEmpty) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('No data available',
                  style: TextStyle(color: Colors.white)),
              Gap(16.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: controller.fetchLeaderBoard,
                    child: const Text('Refresh'),
                  ),
                  SizedBox(width: 12.w),
                  ElevatedButton(
                    onPressed: () {
                      controller.selectedMonth.value = null;
                      controller.selectedYear.value = null;
                      controller.selectedQuarter.value = null;
                      controller.applyFilters();
                    },
                    child: const Text('Clear'),
                  ),
                ],
              ),
            ],
          ),
        );
      }

      final topUser = controller.topUser;
      final others = controller.otherTopUsers;
      final currentUserId = controller.currentUserId.value;

      return SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 1.w, vertical: 16.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _FilterBar(),
            Gap(12.h),
            if (topUser != null) _TopCloserCard(user: topUser),
            Gap(10.h),
            CustomText(
              text: 'Leaderboard',
              fontWeight: FontWeight.w600,
              fontSize: 18.sp,
              color: AppColors.white,
            ),
            // Gap(4.h),
            _LeaderBoardList(users: others, currentUserId: currentUserId),
            // Gap(30.h),
          ],
        ),
      );
    });
  }
}

class _FilterBar extends StatelessWidget {
  _FilterBar({super.key});

  final List<String> _monthNames = [
    "Months",
    "January",
    "February",
    "March",
    "April",
    "May",
    "June",
    "July",
    "August",
    "September",
    "October",
    "November",
    "December"
  ];

  final List<Map<String, dynamic>> quarters = [
    {"name": "Quarters", "value": null},
    {"name": "Jan - Mar", "value": 1},
    {"name": "Apr - Jun", "value": 2},
    {"name": "Jul - Sep", "value": 3},
    {"name": "Oct - Dec", "value": 4},
  ];

  // Auto-generate years and include current year
  late final List<int> years = List.generate(
    10,
        (index) => DateTime.now().year - 5 + index, // last 5, current, next 4
  );

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<LeaderBoardGetController>();

    // Set default year (current year) if null
    controller.selectedYear.value ??= DateTime.now().year;

    return Row(
      children: [
        Flexible(
          child: Obx(() => DropdownButtonFormField<int?>(
            value: controller.selectedMonth.value,
            decoration: _dropdownDecoration("Month"),
            dropdownColor: const Color(0xFF1E1E1E),
            style: TextStyle(color: Colors.white, fontSize: 14.sp),
            icon: const Icon(
              Icons.keyboard_arrow_down,
              color: Colors.white70,
              size: 12,
            ),
            items: List.generate(13, (index) {
              return DropdownMenuItem<int?>(
                value: index == 0 ? null : index,
                child: Text(_monthNames[index],
                    overflow: TextOverflow.ellipsis),
              );
            }),
            onChanged: (val) {
              controller.selectedMonth.value = val;
              controller.selectedQuarter.value = null;
              controller.applyFilters();
            },
          )),
        ),
        SizedBox(width: 10.w),

        /// YEAR DROPDOWN
        Flexible(
          child: Obx(() => DropdownButtonFormField<int?>(
            value: controller.selectedYear.value,
            decoration: _dropdownDecoration("Year"),
            dropdownColor: const Color(0xFF1E1E1E),
            style: TextStyle(color: Colors.white, fontSize: 14.sp),
            icon: const Icon(
              Icons.keyboard_arrow_down,
              color: Colors.white70,
              size: 12,
            ),
            items: years
                .map((year) => DropdownMenuItem<int?>(
              value: year,
              child: Text(
                year.toString(),
                overflow: TextOverflow.ellipsis,
              ),
            ))
                .toList(),
            onChanged: (val) {
              controller.selectedYear.value = val;
              controller.applyFilters();
            },
          )),
        ),
        SizedBox(width: 10.w),

        /// QUARTER DROPDOWN
        Flexible(
          child: Obx(() => DropdownButtonFormField<int?>(
            value: controller.selectedQuarter.value,
            decoration: _dropdownDecoration("Quarter"),
            dropdownColor: const Color(0xFF1E1E1E),
            style: TextStyle(color: Colors.white, fontSize: 14.sp),
            icon: const Icon(
              Icons.keyboard_arrow_down,
              color: Colors.white70,
              size: 12,
            ),
            items: quarters
                .map((q) => DropdownMenuItem<int?>(
              value: q["value"] as int?,
              child: Text(
                q["name"],
                overflow: TextOverflow.ellipsis,
              ),
            ))
                .toList(),
            onChanged: (val) {
              controller.selectedQuarter.value = val;
              controller.selectedMonth.value = null;
              controller.applyFilters();
            },
          )),
        ),
      ],
    );
  }

  InputDecoration _dropdownDecoration(String label) {
    return InputDecoration(
      labelText: label,
      labelStyle: TextStyle(color: Colors.white70, fontSize: 14.sp),
      filled: true,
      fillColor: Colors.white.withOpacity(0.1),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.r),
        borderSide: BorderSide.none,
      ),
      contentPadding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 16.h),
    );
  }
}

// Top Closer Card
class _TopCloserCard extends StatelessWidget {
  final Datum user;
  const _TopCloserCard({required this.user});

  @override
  Widget build(BuildContext context) {
    final num totalAmount = user.totalSales ?? 0;
    final num deals = user.totalDeals ?? 0;


    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color(0xFFFCB806).withOpacity(0.15),
            const Color(0xFFFCB806).withOpacity(0.3),
          ],
        ),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(6.r),
                decoration: BoxDecoration(
                  color: AppColors.orangeColor,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: const Icon(Icons.emoji_events,
                    color: Colors.white, size: 20),
              ),
              Gap(8.w),
              const Text('Top Closer',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600)),
              const Spacer(),
              const Icon(Icons.star, color: Colors.amber, size: 28),
            ],
          ),
          Gap(12.h),
          Row(
            children: [
              user.profilePicture != null && user.profilePicture!.startsWith('http')
                  ? CircleAvatar(
                radius: 32.r,
                backgroundImage: CachedNetworkImageProvider(user.profilePicture!),
                backgroundColor: AppColors.orangeColor,
              )
                  : CircleAvatar(
                radius: 32.r,
                backgroundColor: AppColors.orangeColor,
                child: Icon(Icons.person,
                    color: Colors.white, size: 32.r),
              ),
              Gap(12.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                      text: user.name ?? "N/A",
                      fontWeight: FontWeight.w700,
                      fontSize: 20.sp,
                      color: Colors.white),
                  CustomText(
                      text: 'Sales Champion',
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      color: Colors.white70),
                ],
              ),
            ],
          ),
          Gap(16.h),

          Row(
            children: [
              Expanded(
                child: _StatBox(
                  label: 'Total Amount',
                  value: totalAmount, // ✅ num
                ),
              ),
              Gap(12.w),
              Expanded(
                child: _StatBox(
                  label: 'Deals Closed',
                  value: deals, // ✅ num
                ),
              ),
            ],
          ),

        ],
      ),
    );
  }
}

class _StatBox extends StatelessWidget {
  final String label;
  final num value;

  const _StatBox({
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    final bool isMoney = label.toLowerCase().contains('amount');

    final String displayValue = isMoney
        ? NumberFormat.currency(
      symbol: '€',
      decimalDigits: 0,
    ).format(value)
        : NumberFormat.decimalPattern().format(value);

    return Container(
      padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 12.w),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        children: [
          CustomText(
            text: label,
            fontWeight: FontWeight.w500,
            fontSize: 12.sp,
            color: Colors.white70,
          ),
          Gap(4.h),
          CustomText(
            text: displayValue,
            fontWeight: FontWeight.w700,
            fontSize: 18.sp,
            color: value.isNegative ? Colors.red : Colors.white,
          ),
        ],
      ),
    );
  }
}


class _RankBadge extends StatelessWidget {
  final int rank;
  const _RankBadge({required this.rank});

  @override
  Widget build(BuildContext context) {
    Color bg;
    switch (rank) {
      case 1:
        bg = const Color(0xFFFFD700);
        break;
      case 2:
        bg = const Color(0xFFC0C0C0);
        break;
      case 3:
        bg = const Color(0xFFCD7F32);
        break;
      default:
        bg = Colors.grey.shade700;
    }
    return Container(
      width: 32.r,
      height: 32.r,
      decoration: BoxDecoration(color: bg, shape: BoxShape.circle),
      alignment: Alignment.center,
      child: CustomText(
          text: rank.toString(),
          fontWeight: FontWeight.w700,
          fontSize: 14.sp,
          color: Colors.white),
    );
  }
}


class _LeaderBoardList extends StatelessWidget {
  final List<Datum> users;
  final String currentUserId;
  final bool isLoading;

  const _LeaderBoardList({
    required this.users,
    required this.currentUserId,
    this.isLoading = false, // add a flag to show shimmer
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      // Show shimmer placeholders
      return ListView.builder(
        itemCount: 6, // number of shimmer items
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, i) {
          return Container(
            margin: EdgeInsets.only(bottom: 10.h),
            padding: EdgeInsets.all(12.r),
            decoration: BoxDecoration(
              color: Colors.grey.shade800.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Row(
              children: [
                Shimmer.fromColors(
                  baseColor: Colors.grey.shade700,
                  highlightColor: Colors.grey.shade500,
                  child: Container(
                    width: 24.r,
                    height: 24.r,
                    decoration:
                    BoxDecoration(color: Colors.grey, shape: BoxShape.circle),
                  ),
                ),
                Gap(12.w),
                Shimmer.fromColors(
                  baseColor: Colors.grey.shade700,
                  highlightColor: Colors.grey.shade500,
                  child: CircleAvatar(
                    radius: 20.r,
                    backgroundColor: Colors.grey.shade700,
                  ),
                ),
                Gap(12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Shimmer.fromColors(
                        baseColor: Colors.grey.shade700,
                        highlightColor: Colors.grey.shade500,
                        child: Container(
                          height: 14.h,
                          width: 100.w,
                          color: Colors.grey,
                        ),
                      ),
                      SizedBox(height: 6.h),
                      Shimmer.fromColors(
                        baseColor: Colors.grey.shade700,
                        highlightColor: Colors.grey.shade500,
                        child: Container(
                          height: 12.h,
                          width: 60.w,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
                Shimmer.fromColors(
                  baseColor: Colors.grey.shade700,
                  highlightColor: Colors.grey.shade500,
                  child: Container(
                    height: 16.h,
                    width: 50.w,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          );
        },
      );
    }

    // 🔹 Actual list
    return ListView.builder(
      itemCount: users.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, i) {
        final user = users[i];
        final isMe = user.id == currentUserId;

        return Container(
          margin: EdgeInsets.only(bottom: 10.h),
          padding: EdgeInsets.all(12.r),
          decoration: BoxDecoration(
            color: isMe
                ? Colors.orange.withOpacity(0.15)
                : Colors.white.withOpacity(0.05),
            borderRadius: BorderRadius.circular(12.r),
            border: isMe ? Border.all(color: Colors.orange) : null,
          ),
          child: Row(
            children: [
              _RankBadge(rank: i + 2),
              Gap(12.w),
              CircleAvatar(
                radius: 20.r,

                backgroundImage: (user.profilePicture?.startsWith('http') == true)
                    ? CachedNetworkImageProvider(user.profilePicture!)
                    : null,
                backgroundColor: AppColors.orangeColor,
                child: user.profilePicture == null
                    ? Icon(Icons.person,
                    color: Colors.white, size: 20.r)
                    : null,

              ),
              Gap(12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user.name ?? 'Unknown',
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14.sp,
                          color: Colors.white),
                    ),
                    Text(
                      '${user.totalDeals ?? 0} deals',
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 12.sp,
                          color: Colors.white70),
                    ),
                  ],
                ),
              ),
              Text(
                '€${NumberFormat("#,##0", "en_US").format(user.totalSales ?? 0)}',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 16.sp,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
