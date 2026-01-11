import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wolf_pack/app/common_widget/custom text/custom_text_widget.dart';
import 'package:wolf_pack/app/uitilies/app_colors.dart';
import 'package:wolf_pack/app/uitilies/custom_loader.dart';
import '../../leader_board/modell/all_winner_model.dart';
import '../../leader_board/controllers/prizew_winner_model.dart';


class TopClosersWidget extends StatefulWidget {
  final AllPrizeWinnerController controller;

  const TopClosersWidget({super.key, required this.controller});

  @override
  State<TopClosersWidget> createState() => _TopClosersWidgetState();
}

class _TopClosersWidgetState extends State<TopClosersWidget> {
  PrizeCardData? selectedCard;

  late int selectedYear;
  late int selectedMonth;

  late List<int> availableYears;
  final List<int> availableMonths = List.generate(12, (index) => index + 1);

  @override
  void initState() {
    super.initState();

    final now = DateTime.now();
    selectedYear = now.year;
    selectedMonth = now.month;

    // Current year ± (2 before, 4 after) → 2024 to 2030, newest first
    availableYears = [];
    for (int i = -2; i <= 4; i++) {
      availableYears.add(now.year + i);
    }
    availableYears.sort((a, b) => b.compareTo(a)); // Descending: 2030 → 2024
  }

  String _getMonthName(int month) {
    return DateFormat('MMMM').format(DateTime(2026, month));
  }

  String _getFirstTwoWords(String text) {
    if (text.isEmpty) return '';

    final words = text.trim().split(' ');

    if (words.length <= 2) {
      return text.trim();
    }

    return '${words[0]} ${words[1]}';
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildYearAndMonthDropdowns(),
          SizedBox(height: 10.h),
          Obx(() {
            final isLoading = widget.controller.isLoading.value;
            final Datum? data =
                widget.controller.allPrizeList.value.data.firstOrNull;

            if (isLoading) {
              return SizedBox(
                height: 300.h,
                child:  Center(child: CustomLoader()),
              );
            }

            if (data == null || data.entries.isEmpty) {
              final period =
                  '${_getMonthName(selectedMonth)} $selectedYear';

              // Reset selected card when no data
              if (selectedCard != null) {
                selectedCard = null;
              }

              return Container(
                width: double.infinity,
                margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                padding: EdgeInsets.all(20.w),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.4),
                  borderRadius: BorderRadius.circular(16.r),
                  border: Border.all(color: Colors.white24),
                ),
                child: Center(
                  child: CustomText(
                    text: 'No data available for $period',
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              );
            }

            // Data present
            final monthName = DateFormat('MMMM yyyy')
                .format(DateTime(selectedYear, selectedMonth));

            final entries = data.entries;
            final topUsers = data.topUsers;

            List<PrizeCardData> prizeCards = [];
            final int displayCount = entries.length.clamp(0, 3);
            for (int i = 0; i < displayCount; i++) {
              final entry = entries[i];
              final topUser = i < topUsers.length ? topUsers[i] : null;
              prizeCards.add(PrizeCardData(
                rank: (entry.rank as num).toInt(),
                userName: topUser?.name ?? 'TBA',
                userImage: topUser?.profilePicture ?? '',
                prizeName: entry.name ?? '',
                prizeIcon: entry.icon ?? '',
              ));
            }

            // Auto-select first prize if nothing selected yet (after fresh load)
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (mounted &&
                  selectedCard == null &&
                  prizeCards.isNotEmpty) {
                setState(() {
                  selectedCard = prizeCards[0];
                });
              }
            });

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
                  // HEADER
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(8.r),
                        decoration: BoxDecoration(
                          color: Colors.blueAccent.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: const Icon(Icons.emoji_events,
                            color: Colors.white),
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

                  Center(
                    child: CustomText(
                      text: 'Top Prize Winners',
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white70,
                    ),
                  ),
                  SizedBox(height: 16.h),

                  // PODIUM
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (prizeCards.length > 1)
                        Expanded(
                            child: _buildTopWinnerCard(prizeCards[1], false)),
                      if (prizeCards.isNotEmpty)
                        Expanded(
                            child: _buildTopWinnerCard(prizeCards[0], true)),
                      if (prizeCards.length > 2)
                        Expanded(
                            child: _buildTopWinnerCard(prizeCards[2], false)),
                    ],
                  ),

                  if (topUsers.isEmpty)
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

                  // DETAILED CARD
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
          }),
        ],
      ),
    );
  }

  Widget _buildYearAndMonthDropdowns() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.3),
                borderRadius: BorderRadius.circular(8.r),
                border: Border.all(color: Colors.white24),
              ),
              child: DropdownButton<int>(
                isExpanded: true,
                dropdownColor: Colors.black87,
                value: selectedYear,
                items: availableYears.map((year) {
                  return DropdownMenuItem<int>(
                    value: year,
                    child: Text(
                      year.toString(),
                      style: const TextStyle(color: Colors.white),
                    ),
                  );
                }).toList(),
                onChanged: (int? value) {
                  if (value != null && value != selectedYear) {
                    setState(() {
                      selectedYear = value;
                      selectedCard = null; // Reset selection on period change
                    });
                    widget.controller.refreshWinners(
                      year: selectedYear,
                      month: selectedMonth,
                    );
                  }
                },
                underline: const SizedBox(),
                iconEnabledColor: Colors.white,
              ),
            ),
          ),
          SizedBox(width: 8.w),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.3),
                borderRadius: BorderRadius.circular(8.r),
                border: Border.all(color: Colors.white24),
              ),
              child: DropdownButton<int>(
                isExpanded: true,
                dropdownColor: Colors.black87,
                value: selectedMonth,
                items: availableMonths.map((month) {
                  return DropdownMenuItem<int>(
                    value: month,
                    child: Text(
                      _getMonthName(month),
                      style: const TextStyle(color: Colors.white),
                    ),
                  );
                }).toList(),
                onChanged: (int? value) {
                  if (value != null && value != selectedMonth) {
                    setState(() {
                      selectedMonth = value;
                      selectedCard = null; // Reset selection on period change
                    });
                    widget.controller.refreshWinners(
                      year: selectedYear,
                      month: selectedMonth,
                    );
                  }
                },
                underline: const SizedBox(),
                iconEnabledColor: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
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
                    backgroundColor: AppColors.orangeColor,
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
                      backgroundColor: AppColors.orangeColor,
                      child: const Icon(Icons.person,
                          color: Colors.white, size: 35),
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
                text: _getFirstTwoWords(card.prizeName),
                fontSize: 10.sp,
                color: Colors.white70,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: 4.h),
              Container(
                padding:
                EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: isFirst
                      ? Colors.amber
                      : Colors.blueGrey.withOpacity(0.8),
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
          ClipRRect(
            borderRadius: BorderRadius.circular(10.r),
            child: card.prizeIcon.isNotEmpty
                ? Image.network(
              card.prizeIcon,
              height: 100.h,
              width: 100.w,
              fit: BoxFit.contain,
              errorBuilder: (_, __, ___) => const Icon(
                  Icons.card_giftcard,
                  size: 40,
                  color: Colors.amber),
            )
                : const Icon(Icons.card_giftcard,
                size: 40, color: Colors.amber),
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