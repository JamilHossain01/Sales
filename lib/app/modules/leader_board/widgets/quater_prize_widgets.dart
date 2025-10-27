import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../common_widget/custom text/custom_text_widget.dart';
import '../../../uitilies/app_images.dart';
import '../controllers/quater_prize_controller.dart';

class TopQuaterClosersWidget extends StatefulWidget {
  final AllQuaterPrizeWinnersController controller;

  const TopQuaterClosersWidget({super.key, required this.controller});

  @override
  State<TopQuaterClosersWidget> createState() => _TopQuaterClosersWidgetState();
}

class _TopQuaterClosersWidgetState extends State<TopQuaterClosersWidget> {
  PrizeCardData? selectedCard;

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
  void initState() {
    super.initState();
    // Default: show first winner
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final activeData = widget.controller.userPrizeWinnerList.value.data
          .where((d) => d.isActive == true)
          .toList();
      if (activeData.isNotEmpty) {
        final data = activeData.first;
        final entries = data.quarterPrizeEntries;
        final topUsers = data.topUsers;
        if (entries.isNotEmpty) {
          final firstEntry = entries[0];
          final firstUser = topUsers.isNotEmpty ? topUsers[0] : null;
          setState(() {
            selectedCard = PrizeCardData(
              rank: firstEntry.rank.toInt(),
              userName: firstUser?.name ?? 'TBA',
              userImage: firstUser?.profilePicture ?? '',
              prizeName: firstEntry.name ?? '',
              prizeIcon: firstEntry.icon ?? '',
            );
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (widget.controller.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }

      if (widget.controller.userPrizeWinnerList.value.data.isEmpty) {
        return const SizedBox.shrink();
      }

      final activeData = widget.controller.userPrizeWinnerList.value.data
          .where((d) => d.isActive == true)
          .toList()
        ..sort((a, b) {
          final yearDiff = (b.year as int).compareTo(a.year as int);
          if (yearDiff != 0) return yearDiff;
          return (b.number as int).compareTo(a.number as int);
        });

      if (activeData.isEmpty) return const SizedBox.shrink();

      final data = activeData.first;
      final quarterName = _getQuarterName(data.number.toInt());
      final entries = data.quarterPrizeEntries;
      final topUsers = data.topUsers;
      final isTopUsersEmpty = topUsers.isEmpty;

      // Create PrizeCards dynamically
      List<PrizeCardData> prizeCards = [];
      for (int i = 0; i < entries.length; i++) {
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

      return Container(
        width: double.infinity,
        margin: EdgeInsets.symmetric(vertical: 10.h, horizontal: 8.w),
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              const Color(0xFF8B7B4E).withOpacity(0.45),
              const Color(0xFF5F4E2E).withOpacity(0.65),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(8.r),
                  decoration: BoxDecoration(
                    color: Colors.blueAccent.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child:
                  const Icon(Icons.workspace_premium, color: Colors.white),
                ),
                SizedBox(width: 10.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: 'Top Quarter Closers',
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                    CustomText(
                      text: quarterName,
                      fontSize: 14.sp,
                      color: Colors.white70,
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 20.h),

            CustomText(
              text: 'Top Prize Winners',
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: Colors.white70,
            ),
            SizedBox(height: 16.h),

            // Top winners row (first winner middle)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (prizeCards.length > 1)
                  _buildTopWinnerCard(prizeCards[1], false),
                if (prizeCards.isNotEmpty) _buildTopWinnerCard(prizeCards[0], true),
                if (prizeCards.length > 2)
                  _buildTopWinnerCard(prizeCards[2], false),
              ],
            ),

            if (isTopUsersEmpty)
              Padding(
                padding: EdgeInsets.only(top: 10.h),
                child: Center(
                  child: CustomText(
                    text: 'Winners to be announced soon! 🎉',
                    fontSize: 14.sp,
                    color: Colors.white70,
                  ),
                ),
              ),

            // Always show **selected prize info**
            if (selectedCard != null) ...[
              SizedBox(height: 20.h),
              _buildPrizeInfoCard(selectedCard!),
            ],
          ],
        ),
      );
    });
  }

  Widget _buildTopWinnerCard(PrizeCardData card, bool isMiddle) {
    final isTBA = card.userName == 'TBA';
    final isSelected = selectedCard?.rank == card.rank;

    // Sizes
    double radius = isMiddle ? 50.r : 38.r;
    double imageRadius = isMiddle ? 46.r : 34.r;

    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            selectedCard = card;
          });
        },
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: isMiddle ? 12.w : 6.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Stack(
                alignment: Alignment.bottomRight,
                children: [
                  CircleAvatar(
                    radius: radius,
                    backgroundColor: Colors.white,
                    child: isTBA
                        ? CircleAvatar(
                      radius: imageRadius,
                      backgroundColor: Colors.grey[200],
                      child: const Icon(Icons.hourglass_empty,
                          color: Colors.grey, size: 30),
                    )
                        : card.userImage.isNotEmpty
                        ? CircleAvatar(
                      radius: imageRadius,
                      backgroundImage: NetworkImage(card.userImage),
                    )
                        : CircleAvatar(
                      radius: imageRadius,
                      backgroundColor: Colors.grey[200],
                      child:
                      const Icon(Icons.person, color: Colors.grey),
                    ),
                  ),
                  if (isMiddle)
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
              SizedBox(height: 8.h),
              CustomText(
                text: card.userName,
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: Colors.white,
                textAlign: TextAlign.center,
              ),
              CustomText(
                text: card.prizeName,
                fontSize: 12.sp,
                color: Colors.white70,
                textAlign: TextAlign.center,
                maxLines: 2,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPrizeInfoCard(PrizeCardData card) {
    final isTBA = card.userName == 'TBA';
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: Colors.amber.withOpacity(0.5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipOval(
                child: card.userImage.isNotEmpty
                    ? Image.network(
                  card.userImage,
                  height: 70.h,
                  width: 70.w,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) =>
                  const Icon(Icons.person, color: Colors.white70),
                )
                    : const Icon(Icons.person, size: 40, color: Colors.white70),
              ),
              SizedBox(width: 16.w),
              ClipRRect(
                borderRadius: BorderRadius.circular(10.r),
                child: card.prizeIcon.isNotEmpty
                    ? Image.network(
                  card.prizeIcon,
                  height: 70.h,
                  width: 70.w,
                  fit: BoxFit.contain,
                  errorBuilder: (_, __, ___) => const Icon(
                      Icons.card_giftcard,
                      size: 40,
                      color: Colors.amber),
                )
                    : const Icon(Icons.card_giftcard,
                    size: 40, color: Colors.amber),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          CustomText(
            text: '🏆 ${card.prizeName}',
            fontSize: 16.sp,
            fontWeight: FontWeight.w700,
            color: Colors.amberAccent,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 6.h),
          CustomText(
            text: 'Rank: #${card.rank}',
            fontSize: 14.sp,
            color: Colors.white,
          ),
          SizedBox(height: 6.h),
          CustomText(
            text: 'Winner: ${isTBA ? 'To Be Announced' : card.userName}',
            fontSize: 14.sp,
            color: Colors.greenAccent,
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
