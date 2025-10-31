// lib/app/modules/leader_board/views/leader_board_view.dart

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

    return Obx(() {
      if (controller.isLoading.value) {
        return  Center(child: CustomLoader());
      }

      final users = controller.rawData;
      if (users.isEmpty) {
        return const Center(
          child: Text(
            'No data available',
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
        );
      }

      // Top User (max salesCount)
      final topUser = users.reduce((a, b) =>
      (a['salesCount'] ?? 0) > (b['salesCount'] ?? 0) ? a : b);

      return SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _TopCloserCard(user: topUser),
            Gap(24.h),
            CustomText(
              text: 'Leaderboard',
              fontWeight: FontWeight.w600,
              fontSize: 18.sp,
              color: AppColors.white,
            ),
            Gap(12.h),
            _LeaderBoardList(users: users, topUserId: topUser['id']),
          ],
        ),
      );
    });
  }
}

// TOP CLOSER CARD
class _TopCloserCard extends StatelessWidget {
  final dynamic user;
  const _TopCloserCard({required this.user});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFFFCB806).withOpacity(0.050),
            Color(0xFFFCB806).withOpacity(0.2),
          ],
          stops: [0.0, 1.0],
        ),
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: const [
          BoxShadow(color: Colors.black26, blurRadius: 12, offset: Offset(0, 4))
        ],
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
                child: const Icon(Icons.emoji_events, color: Colors.white, size: 20),
              ),
              Gap(8.w),
              const Text(
                'Top Closer',
                style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),
              ),
              const Spacer(),
              const Icon(Icons.star, color: Colors.amber, size: 28),
            ],
          ),
          Gap(12.h),
          Row(
            children: [
              CircleAvatar(
                radius: 32.r,
                backgroundImage: (user['profilePicture'] as String?)?.startsWith('http') == true
                    ? CachedNetworkImageProvider(user['profilePicture'])
                    : const AssetImage('assets/images/default_avatar.png') as ImageProvider,
              ),
              Gap(12.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text: user['name'] ?? '—',
                    fontWeight: FontWeight.w700,
                    fontSize: 20.sp,
                    color: Colors.white,
                  ),
                   CustomText(
                    text: 'Sales Champion',
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    color: Colors.white70,
                  ),
                ],
              ),
            ],
          ),
          Gap(16.h),
          Row(
            children: [
              Expanded(child: _StatBox(label: 'Total Amount', value: '\$${user['salesCount'] ?? 0}')),
              Gap(12.w),
              Expanded(child: _StatBox(label: 'Deals Closed', value: '${user['dealCount'] ?? 0}')),
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
      padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 12.w),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        children: [
          CustomText(text: label, fontWeight: FontWeight.w500, fontSize: 12.sp, color: Colors.white70),
          Gap(4.h),
          CustomText(text: value, fontWeight: FontWeight.w700, fontSize: 18.sp, color: Colors.white),
        ],
      ),
    );
  }
}

// LEADERBOARD LIST
class _LeaderBoardList extends StatelessWidget {
  final List<dynamic> users;
  final String? topUserId;
  const _LeaderBoardList({required this.users, this.topUserId});

  double _percentChange(int? current, int? previous) {
    if (previous == null || previous == 0) return 0;
    return ((current ?? 0) - previous) / previous * 100;
  }

  @override
  Widget build(BuildContext context) {
    final sorted = List<dynamic>.from(users)
      ..sort((a, b) => (b['salesCount'] ?? 0).compareTo(a['salesCount'] ?? 0));

    return ListView.builder(
      shrinkWrap: true, // এই লাইন যোগ করুন
      physics: const NeverScrollableScrollPhysics(), // এই লাইন যোগ করুন
      itemCount: sorted.length,
      itemBuilder: (context, i) {
        final user = sorted[i];
        final prev = i > 0 ? sorted[i - 1]['salesCount'] : null;
        final change = _percentChange(user['salesCount'], prev);
        final isMe = user['id'] == topUserId;

        return Container(
          margin: EdgeInsets.only(bottom: 12.h),
          padding: EdgeInsets.all(12.r),
          decoration: BoxDecoration(
            color: isMe ? AppColors.orangeColor.withOpacity(0.15) : Colors.white.withOpacity(0.05),
            borderRadius: BorderRadius.circular(12.r),
            border: isMe ? Border.all(color: AppColors.orangeColor) : null,
          ),
          child: Row(
            children: [
              _RankBadge(rank: i + 1),
              Gap(12.w),
              CircleAvatar(
                radius: 20.r,
                backgroundImage: (user['profilePicture'] as String?)?.startsWith('http') == true
                    ? CachedNetworkImageProvider(user['profilePicture'])
                    : const AssetImage('assets/images/default_avatar.png') as ImageProvider,
              ),
              Gap(12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: user['name'] ?? 'Unknown',
                      fontWeight: FontWeight.w600,
                      fontSize: 14.sp,
                      color: AppColors.white,
                    ),
                    CustomText(
                      text: '${user['dealCount'] ?? 0} deal${user['dealCount'] == 1 ? '' : 's'}',
                      fontWeight: FontWeight.w400,
                      fontSize: 12.sp,
                      color: AppColors.white,
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  CustomText(
                    text: '\$${user['salesCount'] ?? 0}',
                    fontWeight: FontWeight.w700,
                    fontSize: 16.sp,
                    color: AppColors.white,
                  ),
                  Gap(2.h),
                  Row(
                    children: [
                      Icon(
                        change > 0 ? Icons.trending_up : change < 0 ? Icons.trending_down : Icons.remove,
                        size: 14.r,
                        color: change > 0 ? Colors.green : change < 0 ? Colors.red : Colors.grey,
                      ),
                      Gap(2.w),
                      CustomText(
                        text: '${change.abs().toStringAsFixed(0)}%',
                        fontSize: 12.sp,
                        color: change > 0 ? Colors.green : change < 0 ? Colors.red : Colors.grey,
                      ),
                    ],
                  ),
                ],
              ),
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
        color: Colors.white,
      ),
    );
  }
}