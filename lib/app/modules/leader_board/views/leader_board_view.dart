import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import '../../../common_widget/custom text/custom_text_widget.dart';
import '../../../uitilies/app_colors.dart';
import '../../../uitilies/custom_loader.dart';
import '../controllers/leader_borad_get.dart';



class LeaderBoardView extends StatelessWidget {
  const LeaderBoardView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LeaderBoardGetController());

    return Scaffold(
      backgroundColor: Colors.black, // Adjust as per your theme
      body: Obx(() {
        if (controller.isLoading.value) {
          return  Center(child: CustomLoader());
        }

        final users = controller.sortedUsers;
        if (users.isEmpty) {
          return const Center(
            child: Text('No data available', style: TextStyle(color: Colors.white)),
          );
        }

        return SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Gap(20.h),

              // === FILTER BAR ===
              _FilterBar(),

              Gap(20.h),

              // === TOP CLOSER CARD ===
              if (controller.topUser != null) _TopCloserCard(user: controller.topUser),

              Gap(25.h),

              // === LEADERBOARD TITLE ===
              CustomText(
                text: 'Leaderboard',
                fontWeight: FontWeight.w600,
                fontSize: 20.sp,
                color: AppColors.white,
              ),
              Gap(12.h),

              // === RANK 2-10 LIST ===
              _LeaderBoardList(
                users: controller.otherTopUsers,
                currentUserId: controller.currentUserId.value,
              ),
              Gap(30.h),
            ],
          ),
        );
      }),
    );
  }
}

// ====================== FILTER BAR ======================
// ====================== FILTER BAR (FIXED & CLEAN) ======================
class _FilterBar extends StatelessWidget {
  _FilterBar({super.key});

  // Full month names
  final List<String> _monthNames = [
    "All Months",
    "January", "February", "March", "April", "May", "June",
    "July", "August", "September", "October", "November", "December"
  ];

  final List<Map<String, dynamic>> quarters = [
    {"name": "All Quarters", "value": null},
    {"name": "January - March", "value": 1},
    {"name": "April - June", "value": 2},
    {"name": "July - September", "value": 3},
    {"name": "October - December", "value": 4},
  ];

  final List<int> years = [2022, 2023, 2024, 2025, 2026];

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<LeaderBoardGetController>();

    return Row(
      children: [
        // Month Dropdown
        Expanded(
          child: Obx(() => DropdownButtonFormField<int?>(
            value: controller.selectedMonth.value,
            decoration: _dropdownDecoration("Month"),
            dropdownColor: const Color(0xFF1E1E1E),
            style: TextStyle(color: Colors.white, fontSize: 14.sp),
            icon: const Icon(Icons.keyboard_arrow_down, color: Colors.white70),
            items: List.generate(13, (index) {
              return DropdownMenuItem<int?>(
                value: index == 0 ? null : index,
                child: Text(_monthNames[index]),
              );
            }),
            onChanged: (val) {
              controller.selectedMonth.value = val;
              controller.selectedQuarter.value = null; // Clear quarter
              controller.applyFilters();
            },
          )),
        ),
        Gap(10.w),

        // Year Dropdown
        Expanded(
          child: Obx(() => DropdownButtonFormField<int>(
            value: controller.selectedYear.value,
            decoration: _dropdownDecoration("Year"),
            dropdownColor: const Color(0xFF1E1E1E),
            style: TextStyle(color: Colors.white, fontSize: 14.sp),
            icon: const Icon(Icons.keyboard_arrow_down, color: Colors.white70),
            items: years.map((year) {
              return DropdownMenuItem<int>(
                value: year,
                child: Text(year.toString()),
              );
            }).toList(),
            onChanged: (val) {
              controller.selectedYear.value = val!;
              controller.applyFilters();
            },
          )),
        ),
        Gap(10.w),

        // Quarter Dropdown
        Expanded(
          child: Obx(() => DropdownButtonFormField<int?>(
            value: controller.selectedQuarter.value,
            decoration: _dropdownDecoration("Quarter"),
            dropdownColor: const Color(0xFF1E1E1E),
            style: TextStyle(color: Colors.white, fontSize: 14.sp),
            icon: const Icon(Icons.keyboard_arrow_down, color: Colors.white70),
            items: quarters.map((q) {
              return DropdownMenuItem<int?>(
                value: q["value"] as int?,
                child: Text(q["name"]),
              );
            }).toList(),
            onChanged: (val) {
              controller.selectedQuarter.value = val;
              controller.selectedMonth.value = null; // Clear month
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
// ====================== TOP CLOSER CARD ======================
class _TopCloserCard extends StatelessWidget {
  final dynamic user;
  const _TopCloserCard({required this.user});

  @override
  Widget build(BuildContext context) {
    final totalAmount = (user['totalAmount'] ?? 0).toStringAsFixed(0);
    final deals = user['totalDeals'].toString();

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(18.r),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            const Color(0xFFFCB806).withOpacity(0.2),
            const Color(0xFFFCB806).withOpacity(0.4),
          ],
        ),
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: const Color(0xFFFCB806), width: 1.5),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(8.r),
                decoration: BoxDecoration(
                  color: AppColors.orangeColor,
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: const Icon(Icons.emoji_events, color: Colors.white, size: 24),
              ),
              Gap(10.w),
              Text('Top Closer', style: TextStyle(color: Colors.white, fontSize: 18.sp, fontWeight: FontWeight.bold)),
              const Spacer(),
              Icon(Icons.star_rounded, color: Colors.amber, size: 36.r),
            ],
          ),
          Gap(16.h),
          Row(
            children: [
              CircleAvatar(
                radius: 36.r,
                backgroundColor: AppColors.orangeColor,
                backgroundImage: (user['profilePicture'] as String?)?.startsWith('http') == true
                    ? CachedNetworkImageProvider(user['profilePicture'])
                    : const AssetImage('assets/images/default_avatar.png') as ImageProvider,
              ),
              Gap(16.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(text: user['name'] ?? '—', fontSize: 22.sp, fontWeight: FontWeight.w700, color: Colors.white),
                    CustomText(text: 'Sales Champion', fontSize: 15.sp, color: Colors.white70),
                  ],
                ),
              ),
            ],
          ),
          Gap(20.h),
          Row(
            children: [
              Expanded(child: _StatBox(label: 'Total Amount', value: '€$totalAmount')),
              Gap(12.w),
              Expanded(child: _StatBox(label: 'Deals Closed', value: deals)),
            ],
          ),
        ],
      ),
    );
  }
}

class _StatBox extends StatelessWidget {
  final String label, value;
  const _StatBox({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 12.w),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.25),
        borderRadius: BorderRadius.circular(14.r),
      ),
      child: Column(
        children: [
          Text(label, style: TextStyle(color: Colors.white70, fontSize: 13.sp)),
          Gap(6.h),
          Text(value, style: TextStyle(color: Colors.white, fontSize: 20.sp, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}

// ====================== LEADERBOARD LIST (2-10) ======================
class _LeaderBoardList extends StatelessWidget {
  final List<dynamic> users;
  final String currentUserId;

  const _LeaderBoardList({required this.users, required this.currentUserId});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: users.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, i) {
        final user = users[i];
        final rank = i + 2;
        final isMe = user['id']?.toString() == currentUserId;

        return Container(
          margin: EdgeInsets.only(bottom: 10.h),
          padding: EdgeInsets.all(14.r),
          decoration: BoxDecoration(
            color: isMe ? AppColors.orangeColor.withOpacity(0.2) : Colors.white.withOpacity(0.08),
            borderRadius: BorderRadius.circular(16.r),
            border: isMe ? Border.all(color: AppColors.orangeColor, width: 1.5) : null,
          ),
          child: Row(
            children: [
              _RankBadge(rank: rank),
              Gap(14.w),
              CircleAvatar(
                radius: 22.r,
                backgroundImage: (user['profilePicture'] as String?)?.startsWith('http') == true
                    ? CachedNetworkImageProvider(user['profilePicture'])
                    : const AssetImage('assets/images/default_avatar.png') as ImageProvider,
              ),
              Gap(14.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(text: user['name'] ?? 'Unknown', fontSize: 15.sp, fontWeight: FontWeight.w600, color: Colors.white),
                    Text('${user['totalDeals'] ?? 0} deals', style: TextStyle(color: Colors.white70, fontSize: 12.sp)),
                  ],
                ),
              ),
              Text('€${(user['totalAmount'] ?? 0).toStringAsFixed(0)}',
                  style: TextStyle(color: Colors.white, fontSize: 17.sp, fontWeight: FontWeight.bold)),
            ],
          ),
        );
      },
    );
  }
}

class _RankBadge extends StatelessWidget {
  final int rank;
  const _RankBadge({required this.rank});

  @override
  Widget build(BuildContext context) {
    Color color = rank == 2
        ? const Color(0xFFC0C0C0)
        : rank == 3
        ? const Color(0xFFCD7F32)
        : Colors.grey.shade600;

    return CircleAvatar(
      radius: 18.r,
      backgroundColor: color,
      child: Text(rank.toString(), style: TextStyle(color: Colors.white, fontSize: 16.sp, fontWeight: FontWeight.bold)),
    );
  }
}

// Optional: Add this extension for month names
extension on int {
  String get monthName => [
    'January', 'February', 'March', 'April', 'May', 'June',
    'July', 'August', 'September', 'October', 'November', 'December'
  ][this - 1];
}