import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../common widget/custom text/custom_text_widget.dart';
import '../../../uitilies/app_images.dart';
import '../controllers/quater_prize_controller.dart';

class TopQuaterClosersWidget extends StatelessWidget {
  final AllQuaterPrizeWinnersController controller;

  const TopQuaterClosersWidget({super.key, required this.controller});

  String _getQuarterName(int number) {
    switch (number) {
      case 1:
        return "January - March";
      case 2:
        return "April - June";
      case 3:
        return "July - September";
      case 4:
        return "October - December";
      default:
        return "Unknown Quarter";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }
      if (controller.userPrizeWinnerList.value.data.isEmpty) {
        return const SizedBox.shrink();
      }

      final activeData = controller.userPrizeWinnerList.value.data
          .where((d) => d.isActive == true)
          .toList()
        ..sort((a, b) {
          final yearDiff = (b.year as int).compareTo(a.year as int);
          if (yearDiff != 0) return yearDiff;
          return (b.number as int).compareTo(a.number as int);
        });

      if (activeData.isEmpty) return const SizedBox.shrink();

      return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: activeData.length,
        itemBuilder: (context, index) {
          final data = activeData[index];
          if (data.quarterPrizeEntries.length < 3) return const SizedBox.shrink();

          final entries = data.quarterPrizeEntries;
          final topUsers = data.topUsers;
          final isTopUsersEmpty = topUsers.isEmpty;

          List<PrizeCardData> prizeCards = [];
          for (int i = 0; i < 3; i++) {
            final entry = entries[i];
            final topUser = i < topUsers.length ? topUsers[i] : null;
            prizeCards.add(PrizeCardData(
              rank: entry.rank.toInt(),
              userName: topUser?.name ?? 'TBA',
              userImage: topUser?.profilePicture ?? '',
              prizeName: entry.name ?? '',
              prizeIcon: entry.icon ?? '',
            ));
          }

          Color getColor(int rank) {
            switch (rank) {
              case 1:
                return Colors.amber;
              case 2:
              case 3:
                return const Color(0xFFFF7D00);
              default:
                return Colors.orange;
            }
          }

          final quarterName = _getQuarterName(data.number.toInt());

          return Container(
            width: double.infinity,
            margin: EdgeInsets.only(bottom: 16.h),
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.amber.withOpacity(0.60),
                  Colors.amber.withOpacity(0.1),
                ],
              ),
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(color: Colors.amber.withOpacity(0.2)),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      AppImages.badges,
                      height: 34.h,
                      width: 34.w,
                    ),
                    SizedBox(width: 8.w),
                    Expanded(
                      child: CustomText(
                        text: 'Top 3 $quarterName Prize Winners',
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w700,
                        color: Colors.black87,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
                if (isTopUsersEmpty)
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.h),
                    child: CustomText(
                      text: 'Winners to be announced soon! 🎉',
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey,
                      textAlign: TextAlign.center,
                    ),
                  ),
                SizedBox(height: 24.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildTopCloserCard(context, prizeCards[2], getColor(prizeCards[2].rank), prizeCards[2].rank == 1),
                    _buildTopCloserCard(context, prizeCards[0], getColor(prizeCards[0].rank), true),
                    _buildTopCloserCard(context, prizeCards[1], getColor(prizeCards[1].rank), prizeCards[1].rank == 1),
                  ],
                ),
              ],
            ),
          );
        },
      );
    });
  }

  Widget _buildTopCloserCard(BuildContext context, PrizeCardData card, Color color, bool isFirst) {
    final isTBA = card.userName == 'TBA';
    return GestureDetector(
      onTap: () {
        _showPrizeDetailsDialog(
          context: context,
          rank: card.rank.toString(),
          prizeName: card.prizeName,
          winnerName: card.userName,
          winnerImage: card.userImage,
          prizeImage: card.prizeIcon,
          isTBA: isTBA,
        );
      },
      child: Column(
        children: [
          Stack(
            alignment: Alignment.bottomRight,
            children: [
              CircleAvatar(
                radius: 40.r,
                backgroundColor: Colors.white,
                child: isTBA
                    ? CircleAvatar(
                  radius: 36.r,
                  backgroundColor: Colors.grey[200],
                  child: const Icon(
                    Icons.hourglass_empty,
                    color: Colors.grey,
                    size: 28,
                  ),
                )
                    : card.userImage.isNotEmpty
                    ? CircleAvatar(
                  radius: 36.r,
                  backgroundImage: NetworkImage(card.userImage),
                )
                    : CircleAvatar(
                  radius: 36.r,
                  backgroundColor: Colors.grey[200],
                  child: const Icon(
                    Icons.person,
                    color: Colors.grey,
                  ),
                ),
              ),
              if (isFirst)
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: Container(
                    padding: EdgeInsets.all(4.r),
                    decoration: const BoxDecoration(
                      color: Colors.amber,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.star, color: Colors.white, size: 16),
                  ),
                ),
            ],
          ),
          SizedBox(height: 12.h),
          Container(
            width: 80.w,
            padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 12.w),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Column(
              children: [
                CustomText(
                  text: card.userName,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: isTBA ? Colors.grey[600]! : Colors.black,
                ),
                SizedBox(height: 2.h),
                Text(
                  card.prizeName,
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 2.h),
                CustomText(
                  text: '#${card.rank}',
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.black54,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showPrizeDetailsDialog({
    required BuildContext context,
    required String rank,
    required String prizeName,
    required String winnerName,
    required String winnerImage,
    required String prizeImage,
    required bool isTBA,
  }) {
    Get.dialog(
      AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        contentPadding: EdgeInsets.zero,
        titlePadding: EdgeInsets.all(16.w),
        title: CustomText(
          text: 'Prize Details',
          fontSize: 20.sp,
          fontWeight: FontWeight.w700,
          color: Colors.black87,
        ),
        content: ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.7,
            maxWidth: MediaQuery.of(context).size.width * 0.9,
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (prizeImage.isNotEmpty)
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12.r),
                      child: Image.network(
                        prizeImage,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => Container(
                          height: 200.h,
                          width: double.infinity,
                          color: Colors.grey[200],
                          child: const Icon(Icons.image_not_supported,
                              size: 50, color: Colors.grey),
                        ),
                      ),
                    ),
                  SizedBox(height: 16.h),
                  CustomText(
                    text: 'Rank: $rank',
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                  SizedBox(height: 8.h),
                  CustomText(
                    text: 'Prize: $prizeName',
                    fontSize: 16.sp,
                    color: Colors.black54,
                  ),
                  SizedBox(height: 8.h),
                  CustomText(
                    text: 'Winner: ${isTBA ? 'To Be Announced' : winnerName}',
                    fontSize: 16.sp,
                    color: Colors.green,
                  ),
                  SizedBox(height: 16.h),
                  if (!isTBA && winnerImage.isNotEmpty)
                    Center(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(50.r),
                        child: Image.network(
                          winnerImage,
                          height: 80.h,
                          width: 80.w,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) =>
                          const Icon(Icons.person, size: 40, color: Colors.grey),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: CustomText(
              text: 'Close',
              fontSize: 16.sp,
              color: Colors.amber,
            ),
          ),
        ],
      ),
    );
  }
}

class PrizeCardData {
  final int rank;
  final String userName;
  final String userImage;
  final String prizeName;
  final String prizeIcon;

  PrizeCardData({
    required this.rank,
    required this.userName,
    required this.userImage,
    required this.prizeName,
    required this.prizeIcon,
  });
}
