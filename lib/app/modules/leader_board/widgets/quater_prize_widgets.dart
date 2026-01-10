import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:wolf_pack/app/uitilies/app_colors.dart';
import '../../../common_widget/custom text/custom_text_widget.dart';
import '../controllers/quater_prize_controller.dart';
import 'package:intl/intl.dart';   // ← This line is missing in your file!

class TopQuaterClosersWidget extends StatefulWidget {
  final AllQuaterPrizeWinnersController controller;

  const
  TopQuaterClosersWidget({super.key, required this.controller});

  @override
  State<TopQuaterClosersWidget> createState() => _TopQuaterClosersWidgetState();
}

class _TopQuaterClosersWidgetState extends State<TopQuaterClosersWidget> {
  PrizeCardData? selectedCard;
  int selectedYear = DateTime.now().year;
  int? selectedQuarter; // Added for quarter filter
  List<int> availableYears = [];
  List<int> availableQuarters = [1, 2, 3, 4]; // Quarters 1-4

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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initializeData();
    });
  }

  Future<void> _initializeData() async {
    // Hardcode available years from 2022 to 2026, sorted descending (newest first)
    setState(() {
      availableYears = List.generate(5, (index) => 2022 + index).reversed.toList();
      selectedYear = DateTime.now().year; // Default to current year (2025)
      selectedQuarter = null; // Default to all quarters or active
    });

    // Load all data for the current year first
    await widget.controller.fetchPrizeWinnersForYear(selectedYear);

    await _fetchYearData(selectedYear);
    _initializeDefaultCard();
  }

  Future<void> _fetchYearData(int year) async {
    setState(() => selectedYear = year);
    await widget.controller.fetchPrizeWinnersForYear(year);
    setState(() {});
  }

  Future<void> _fetchFilteredData() async {
    // You can extend this to refetch if needed, but for now, filter client-side
    setState(() {});
  }

  void _initializeDefaultCard() {
    final allData = widget.controller.userPrizeWinnerList.value.data ?? [];
    final activeData = allData
        .where((d) => d.isActive == true && d.year == selectedYear)
        .toList()
        .where((d) => selectedQuarter == null || d.number == selectedQuarter)
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
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (widget.controller.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }

      final allData = widget.controller.userPrizeWinnerList.value.data ?? [];
      final activeData = allData
          .where((d) => d.isActive == true && d.year == selectedYear)
          .toList()
          .where((d) => selectedQuarter == null || d.number == selectedQuarter)
          .toList();

      if (activeData.isEmpty) {
        return SingleChildScrollView(
          child: Column(
            children: [
              _buildYearAndQuarterDropdowns(),
              SizedBox(height: 30.h),
              Container(
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
                    text: 'No data available for $selectedYear${selectedQuarter != null ? ' - Quarter ${_getQuarterName(selectedQuarter!)}' : ''}',
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        );
      }

      final data = activeData.first;
      final quarterName = _getQuarterName(data.number.toInt());
      final entries = data.quarterPrizeEntries;
      final topUsers = data.topUsers;

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

      return SingleChildScrollView(
        child: Column(
          children: [
            _buildYearAndQuarterDropdowns(),
            Container(
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
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.all(8.r),
                        decoration: BoxDecoration(
                          color: Colors.blueAccent.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: const Icon(Icons.workspace_premium,
                            color: Colors.white, size: 24),
                      ),
                      SizedBox(width: 10.w),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CustomText(
                            text: data.name ?? 'Top Quarter Closers',
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                          SizedBox(height: 4.h),
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
                  // Center(
                  //   child: CustomText(
                  //     text: 'Top Prize Winners',
                  //     fontSize: 14.sp,
                  //     fontWeight: FontWeight.w600,
                  //     color: Colors.white70,
                  //   ),
                  // ),
                  // SizedBox(height: 16.h),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: [
                  //     if (prizeCards.length > 1)
                  //       _buildTopWinnerCard(prizeCards[1], false),
                  //     if (prizeCards.isNotEmpty)
                  //       _buildTopWinnerCard(prizeCards[0], true),
                  //     if (prizeCards.length > 2)
                  //       _buildTopWinnerCard(prizeCards[2], false),
                  //   ],
                  // ),
                  // if (topUsers.isEmpty)
                  //   Padding(
                  //     padding: EdgeInsets.only(top: 10.h),
                  //     child: Center(
                  //       child: CustomText(
                  //         text: 'Winners to be announced soon! 🎉',
                  //         fontSize: 14.sp,
                  //         color: Colors.white70,
                  //       ),
                  //     ),
                  //   ),
                  if (selectedCard != null) ...[
                    SizedBox(height: 10.h),
                    _buildPrizeInfoCard(selectedCard!),
                  ],
                  // New section for all top users list
                  // SizedBox(height: 20.h),
                  CustomText(
                    text: 'All Top Users',
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.white70,
                  ),
                  // SizedBox(height: 16.h),
                  if (topUsers.isEmpty)
                    Center(
                      child: CustomText(
                        text: 'No users available yet!',
                        fontSize: 14.sp,
                        color: Colors.white70,
                      ),
                    )
                  else
                    SizedBox(
                      height: 300.h, // Fixed height to constrain the ListView
                      child: ListView.separated(
                        shrinkWrap: true,
                        physics: const ClampingScrollPhysics(),
                        itemCount: topUsers.length,
                        separatorBuilder: (context, index) => Divider(
                          color: Colors.white24,
                          thickness: 1.h,
                        ),
                        itemBuilder: (context, index) {
                          final user = topUsers[index];
                          final num totalAmount = user.totalAmount ?? 0;

                          final formattedAmount = NumberFormat.currency(
                            symbol: '€',
                            decimalDigits: 0,
                          ).format(totalAmount);



                          return ListTile(
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 8.w,
                              vertical: 4.h,
                            ),
                            leading: CircleAvatar(
                              radius: 20.r,
                              backgroundColor: Colors.white.withOpacity(0.2),
                              backgroundImage: user.profilePicture != null && user.profilePicture.isNotEmpty
                                  ? NetworkImage(user.profilePicture)
                                  : null,
                              child: user.profilePicture == null || user.profilePicture.isEmpty
                                  ?  Icon(
                                Icons.person,
                                color:AppColors.orangeColor,
                                size: 24,
                              )
                                  : null,
                            ),
                            title: Row(crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomText(
                                  text: user.name ?? 'Unknown User',
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 4.h),
                                // CustomText(
                                //   text: 'Deals Closed: $totalDealsClosed',
                                //   fontSize: 12.sp,
                                //   color: Colors.white70,
                                // ),
                                CustomText(
                                  text: 'Total Amount: $formattedAmount',
                                  fontSize: 12.sp,
                                  color: Colors.greenAccent,
                                ),
                              ],
                            ),
                            trailing: Container(
                              padding: EdgeInsets.all(8.r),
                              decoration: BoxDecoration(
                                color: Colors.amber.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                              child: CustomText(
                                text: '#${index + 1}',
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w700,
                                color: Colors.amber,
                              ),
                            ),
                            dense: true,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                            tileColor: Colors.transparent,
                          );
                        },
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget _buildYearAndQuarterDropdowns() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      child: Row(
        children: [
          // Year Dropdown
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
                onChanged: (value) async {
                  if (value != null) {
                    await _fetchYearData(value);
                    if (mounted) {
                      setState(() => selectedQuarter = null); // Reset quarter filter
                      _initializeDefaultCard();
                    }
                  }
                },
                underline: const SizedBox(),
                iconEnabledColor: Colors.white,
              ),
            ),
          ),
          SizedBox(width: 8.w),
          // Quarter Filter Dropdown
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.3),
                borderRadius: BorderRadius.circular(8.r),
                border: Border.all(color: Colors.white24),
              ),
              child: DropdownButton<int?>(
                isExpanded: true,
                dropdownColor: Colors.black87,
                value: selectedQuarter,
                hint: Text(
                  'All Quarters',
                  style: const TextStyle(color: Colors.white70),
                ),
                items: [
                  const DropdownMenuItem<int?>(
                    value: null,
                    child: Text('All Quarters', style: TextStyle(color: Colors.white)),
                  ),
                  ...availableQuarters.map((quarter) {
                    return DropdownMenuItem<int>(
                      value: quarter,
                      child: Text(
                        'Q$quarter - ${_getQuarterName(quarter)}',
                        style: const TextStyle(color: Colors.white),
                        overflow: TextOverflow.ellipsis,
                      ),
                    );
                  }).toList(),
                ],
                onChanged: (value) {
                  if (mounted) {
                    setState(() => selectedQuarter = value);
                    _initializeDefaultCard();
                    _fetchFilteredData();
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

  Widget _buildTopWinnerCard(PrizeCardData card, bool isMiddle) {
    final isTBA = card.userName == 'TBA';
    double radius = isMiddle ? 50.r : 38.r;
    double imageRadius = isMiddle ? 46.r : 34.r;

    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => selectedCard = card),
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
                      child: const Icon(Icons.person,
                          color: Colors.grey),
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
      padding: EdgeInsets.only(top: 8.h),
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
              // ClipOval(
              //   child: card.userImage.isNotEmpty
              //       ? Image.network(
              //     card.userImage,
              //     height: 70.h,
              //     width: 70.w,
              //     fit: BoxFit.cover,
              //     errorBuilder: (_, __, ___) =>
              //     const Icon(Icons.person, color: Colors.white70),
              //   )
              //       : const Icon(Icons.person, size: 40, color: Colors.white70),
              // ),
              // SizedBox(width: 16.w),

              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.r),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16.r),
                  child: card.prizeIcon.isNotEmpty
                      ? Image.network(
                    card.prizeIcon,
                    height: 150.h,
                    width: 280.w,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => const Icon(
                      Icons.card_giftcard,
                      size: 40,
                      color: Colors.amber,
                    ),
                  )
                      : const Icon(
                    Icons.card_giftcard,
                    size: 40,
                    color: Colors.amber,
                  ),
                ),
              )

            ],
          ),
          SizedBox(height: 8.h),
          CustomText(
            text: '🏆 ${card.prizeName}',
            fontSize: 16.sp,
            fontWeight: FontWeight.w700,
            color: Colors.amberAccent,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 4.h),
          CustomText(
            text: 'Rank: #${card.rank}',
            fontSize: 14.sp,
            color: Colors.white,
          ),
          SizedBox(height: 4.h),
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