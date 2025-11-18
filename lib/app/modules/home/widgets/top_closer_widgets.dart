import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wolf_pack/app/common_widget/custom text/custom_text_widget.dart';
import '../../leader_board/modell/prizew_winner_model.dart';

class TopClosersWidget extends StatefulWidget {
  final AllPrizeWinnerController controller;

  const TopClosersWidget({super.key, required this.controller});

  @override
  State<TopClosersWidget> createState() => _TopClosersWidgetState();
}

class _TopClosersWidgetState extends State<TopClosersWidget> {
  PrizeCardData? selectedCard;

  @override
  void initState() {
    super.initState();
    // Default: First prize winner always shown
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.controller.allPrizeList.value.data.isNotEmpty) {
        final activeData = widget.controller.allPrizeList.value.data
            .where((d) => d.isActive == true)
            .toList();
        if (activeData.isNotEmpty && activeData.first.entries.isNotEmpty) {
          final data = activeData.first;
          final entries = data.entries;
          final topUsers = data.topUsers;

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

      if (widget.controller.allPrizeList.value.data.isEmpty) {
        return const SizedBox.shrink();
      }

      final activeData = widget.controller.allPrizeList.value.data
          .where((d) => d.isActive == true)
          .toList()
        ..sort((a, b) {
          final yearDiff = (b.year as int).compareTo(a.year as int);
          if (yearDiff != 0) return yearDiff;
          return (b.month as int).compareTo(a.month as int);
        });

      if (activeData.isEmpty) return const SizedBox.shrink();

      final data = activeData.first;
      final monthName =
      DateFormat('MMMM yyyy').format(DateTime(data.year, data.month));

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
            // ===== HEADER =====
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(8.r),
                  decoration: BoxDecoration(
                    color: Colors.blueAccent.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: const Icon(Icons.emoji_events, color: Colors.white),
                ),
                SizedBox(width: 10.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: 'Top Closers',
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                    CustomText(
                      text: monthName,
                      fontSize: 14.sp,
                      color: Colors.white70,
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 20.h),

            CustomText(
              text: 'Top 3 Prize Winners',
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: Colors.white70,
            ),
            SizedBox(height: 16.h),

            // ===== TOP 3 WINNERS (avatars) =====
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildTopWinnerCard(prizeCards[1], false),
                _buildTopWinnerCard(prizeCards[0], true),
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

            /// ===== EXPANDED CARD (always first visible) =====
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: selectedCard != null
                  ? Padding(
                key: ValueKey(selectedCard!.rank),
                padding: EdgeInsets.only(top: 20.h),
                child: _buildPrizeInfoCard(selectedCard!),
              )
                  : const SizedBox.shrink(),
            ),
          ],
        ),
      );
    });
  }

  Widget _buildTopWinnerCard(PrizeCardData card, bool isFirst) {
    final isTBA = card.userName == 'TBA';
    final isSelected = selectedCard?.rank == card.rank;

    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            selectedCard = card;
          });
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeInOut,
          padding: EdgeInsets.all(isSelected ? 4.w : 0),
          decoration: BoxDecoration(
            border: isSelected
                ? Border.all(color: Colors.amber, width: 2)
                : null,
            borderRadius: BorderRadius.circular(50.r),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Stack(
                alignment: Alignment.bottomRight,
                children: [
                  CircleAvatar(
                    radius: isFirst ? 45.r : 38.r,
                    backgroundColor: Colors.white,
                    child: isTBA
                        ? CircleAvatar(
                      radius: isFirst ? 41.r : 34.r,
                      backgroundColor: Colors.grey[200],
                      child: const Icon(Icons.hourglass_empty,
                          color: Colors.grey, size: 30),
                    )
                        : card.userImage.isNotEmpty
                        ? CircleAvatar(
                      radius: isFirst ? 41.r : 34.r,
                      backgroundImage: NetworkImage(card.userImage),
                    )
                        : CircleAvatar(
                      radius: isFirst ? 41.r : 34.r,
                      backgroundColor: Colors.grey[200],
                      child: const Icon(Icons.person,
                          color: Colors.grey),
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
              SizedBox(height: 4.h),
              CustomText(
                text: _getFirstTwoWords(card.prizeName ?? ''),
                fontSize: 10.sp,
                color: Colors.white70,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis, // optional: adds ... if somehow still longer
              ),
              SizedBox(height: 4.h),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color:
                  isFirst ? Colors.amber : Colors.blueGrey.withOpacity(0.8),
                  borderRadius: BorderRadius.circular(6.r),
                ),
                child: CustomText(
                  text: '#${card.rank}',
                  fontSize: 12.sp,
                  color: isFirst ? Colors.black : Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  String _getFirstTwoWords(String text) {
    if (text.isEmpty) return '';

    // Split by space and take maximum 2 words
    final words = text.trim().split(' ');

    if (words.length <= 2) {
      return text.trim(); // return as-is if 1 or 2 words
    }

    return '${words[0]} ${words[1]}';
  }
  /// ===== EXPANDED CARD =====
  Widget _buildPrizeInfoCard(PrizeCardData card) {
    final isTBA = card.userName == 'TBA';
    return Container(
      width: double.infinity,
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
                    : const Icon(Icons.person,
                    size: 40, color: Colors.white70),
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
