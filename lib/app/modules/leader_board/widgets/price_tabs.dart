import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:wolf_pack/app/modules/leader_board/widgets/quater_prize_widgets.dart';
import '../../home/widgets/top_closer_widgets.dart';
import '../controllers/quater_prize_controller.dart';
import '../modell/prizew_winner_model.dart';
import '../../../uitilies/app_colors.dart';
import '../../../common_widget/custom text/custom_text_widget.dart';

class PrizeTabsWidget extends StatelessWidget {
  final AllPrizeWinnerController monthController;
  final AllQuaterPrizeWinnersController quarterController;

  PrizeTabsWidget({
    super.key,
    required this.monthController,
    required this.quarterController,
  });

  final RxInt selectedIndex = 0.obs; // 0 = Month, 1 = Quarter

  @override
  Widget build(BuildContext context) {
    return Obx(() => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// ---------- Custom Tabs ----------
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildTabButton(title: "Month", index: 0),
            _buildTabButton(title: "Quarter", index: 1),
          ],
        ),
        Divider(height: 1,color: Colors.grey.withOpacity(0.3),),

        SizedBox(height: 15.h),

        /// ---------- Dynamic View ----------
        if (selectedIndex.value == 0)
          TopClosersWidget(controller: monthController)
        else
          TopQuaterClosersWidget(controller: quarterController),
      ],
    ));
  }

  /// ---------- Custom Tab Button ----------
  Widget _buildTabButton({required String title, required int index}) {
    final isSelected = selectedIndex.value == index;
    return GestureDetector(
      onTap: () => selectedIndex.value = index,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: isSelected ? AppColors.orangeColor : Colors.transparent,width: 2)),
  color: Colors.transparent
        ),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: CustomText(
            text: title,
            color: isSelected ? AppColors.orangeColor : Colors.white,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
            fontSize: 15.sp,
          ),
        ),
      ),
    );
  }
}
