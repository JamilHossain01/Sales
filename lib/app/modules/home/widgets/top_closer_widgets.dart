import 'package:get/get.dart';
import 'package:wolf_pack/app/modules/leader_board/modell/all_prize_model.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wolf_pack/app/uitilies/app_images.dart';
import '../../../uitilies/app_colors.dart';
import '../../../common widget/custom text/custom_text_widget.dart';
import '../../leader_board/modell/prizew_winner_model.dart';

class TopClosersWidget extends StatelessWidget {
  final AllPrizeWinnerController controller;

  const TopClosersWidget({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }

      if (controller.allPrizeList.value.data.isEmpty) {
        return const SizedBox.shrink();
      }

      final activeData = controller.allPrizeList.value.data
          .where((d) => d.isActive == true)
          .toList()
        ..sort((a, b) {
          final yearDiff = (b.year as int).compareTo(a.year as int);
          if (yearDiff != 0) return yearDiff;
          return (b.month as int).compareTo(a.month as int);
        });

      if (activeData.isEmpty) {
        return const SizedBox.shrink();
      }

      return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: activeData.length,
        itemBuilder: (context, index) {
          final data = activeData[index];
          if (data.entries.length < 3) return const SizedBox.shrink();

          final entries = data.entries;
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
                return const Color(0xFFFF7D00);
              case 3:
                return const Color(0xFFFF7D00);
              default:
                return Colors.orange;
            }
          }

          final monthName = DateFormat('MMMM').format(
            DateTime(data.year.toInt(), data.month.toInt(), 1),
          );

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
                    Image.asset(AppImages.badges, height: 34.h, width: 34.w),
                    SizedBox(width: 8.w),
                    Expanded(
                      child: CustomText(
                        text: 'Top 3 $monthName Prize Winners',
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
                    // Rank 3
                    _buildTopCloserCard(
                      context: context,
                      name: prizeCards[2].userName,
                      prize: prizeCards[2].prizeName,
                      rank: '#${prizeCards[2].rank}',
                      imageUrl: prizeCards[2].userImage,
                      color: getColor(prizeCards[2].rank),
                      isFirst: prizeCards[2].rank == 1,
                      isTBA: prizeCards[2].userName == 'TBA',
                      prizeIcon: prizeCards[2].prizeIcon,
                    ),
                    // Rank 1 (center)
                    _buildTopCloserCard(
                      context: context,
                      name: prizeCards[0].userName,
                      prize: prizeCards[0].prizeName,
                      rank: '#${prizeCards[0].rank}',
                      imageUrl: prizeCards[0].userImage,
                      color: getColor(prizeCards[0].rank),
                      isFirst: true,
                      isTBA: prizeCards[0].userName == 'TBA',
                      prizeIcon: prizeCards[0].prizeIcon,
                    ),
                    // Rank 2
                    _buildTopCloserCard(
                      context: context,
                      name: prizeCards[1].userName,
                      prize: prizeCards[1].prizeName,
                      rank: '#${prizeCards[1].rank}',
                      imageUrl: prizeCards[1].userImage,
                      color: getColor(prizeCards[1].rank),
                      isFirst: prizeCards[1].rank == 1,
                      isTBA: prizeCards[1].userName == 'TBA',
                      prizeIcon: prizeCards[1].prizeIcon,
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      );
    });
  }

  Widget _buildTopCloserCard({
    required BuildContext context,
    required String name,
    required String prize,
    required String rank,
    required String imageUrl,
    required Color color,
    required bool isFirst,
    required bool isTBA,
    required String prizeIcon,
  }) {
    return GestureDetector(
      onTap: () {
        /// 👇 FIXED: Use context directly for dialog (ensures proper overlay)
        showDialog(
          context: context,
          builder: (_) => _buildPrizeDialog(
            rank: rank,
            prizeName: prize,
            winnerName: name,
            winnerImage: imageUrl,
            prizeImage: prizeIcon,
            isTBA: isTBA,
          ),
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
                    ? const Icon(Icons.hourglass_empty,
                    color: Colors.grey, size: 28)
                    : imageUrl.isNotEmpty
                    ? CircleAvatar(
                  radius: 36.r,
                  backgroundImage: NetworkImage(imageUrl),
                )
                    : const Icon(Icons.person, color: Colors.grey),
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
                    child: const Icon(Icons.star,
                        color: Colors.white, size: 16),
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
                  text: name,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: isTBA ? Colors.grey[600]! : Colors.black,
                ),
                SizedBox(height: 2.h),
                Text(
                  prize,
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
                  text: rank,
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

  Widget _buildPrizeDialog({
    required String rank,
    required String prizeName,
    required String winnerName,
    required String winnerImage,
    required String prizeImage,
    required bool isTBA,
  }) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
      title: CustomText(
        text: 'Prize Details',
        fontSize: 20.sp,
        fontWeight: FontWeight.w700,
        color: Colors.black87,
      ),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (prizeImage.isNotEmpty)
              ClipRRect(
                borderRadius: BorderRadius.circular(12.r),
                child: Image.network(
                  prizeImage,
                  height: 200.h,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    height: 200.h,
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
                    errorBuilder: (_, __, ___) => const Icon(Icons.person,
                        size: 40, color: Colors.grey),
                  ),
                ),
              ),
          ],
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
