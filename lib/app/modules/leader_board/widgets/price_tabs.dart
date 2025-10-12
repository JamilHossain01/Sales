import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wolf_pack/app/modules/leader_board/widgets/quater_prize_widgets.dart';

import '../../home/widgets/top_closer_widgets.dart';
import '../controllers/quater_prize_controller.dart';
import '../modell/prizew_winner_model.dart';

class PrizeTabsWidget extends StatelessWidget {
  final AllPrizeWinnerController monthController;
  final AllQuaterPrizeWinnersController quarterController;

  const PrizeTabsWidget({
    super.key,
    required this.monthController,
    required this.quarterController,
  });

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TabBar(
            labelColor: Colors.amber,
            unselectedLabelColor: Colors.grey,
            indicatorColor: Colors.amber,
            labelStyle: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
            tabs: const [
              Tab(text: 'Month'),
              Tab(text: 'Quarter'),
            ],
          ),
          SizedBox(height: 12.h),

          /// ✅ Fixed height + scrollable child
          SizedBox(
            height: 400.h, // you can tweak as needed
            child: TabBarView(
              physics: const BouncingScrollPhysics(),
              children: [
                SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: TopClosersWidget(controller: monthController),
                ),
                SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: TopQuaterClosersWidget(controller: quarterController),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
