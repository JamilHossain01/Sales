import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:wolf_pack/app/uitilies/app_images.dart';

import '../controllers/all_prize_controller.dart';

class PrizeAndBadgeSection extends StatelessWidget {
  PrizeAndBadgeSection({Key? key}) : super(key: key);

  final AllPrizeController controller = Get.put(AllPrizeController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }

      if (controller.allPrizeList.value.data.isEmpty) {
        return const Center(child: Text("No prizes available"));
      }

      final prizeData = controller.allPrizeList.value.data;

      return SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 16.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _sectionTitle("Prize Tools"),
            ...prizeData.map((item) => _buildPrizeItem(
              imagePath: item.icon ?? AppImages.apple,
              title: item.name ?? "Unknown Prize",
              rank: "Tier ${item.tierLevel ?? 0}",
              rankColor: const Color(0xFFFFC107),
            )),
            SizedBox(height: 20.h),
            _sectionTitle("Achieving Badge"),
            // You can also map badge data similarly if you have it from API
            _buildBadgeItem(
              iconPath: AppImages.apple,
              name: "Alex Thompson",
              achievement: "First 50k Sales",
              achievementColor: const Color(0xFFFFC107),
            ),
          ],
        ),
      );
    });
  }

  Widget _sectionTitle(String title) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 14.sp,
          fontWeight: FontWeight.w500,
          color: Colors.white.withOpacity(0.8),
        ),
      ),
    );
  }

  Widget _buildPrizeItem({
    required String imagePath,
    required String title,
    required String rank,
    required Color rankColor,
  }) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 6.h, horizontal: 12.w),
      padding: EdgeInsets.all(8.w),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.09),
        borderRadius: BorderRadius.circular(8.r),
        boxShadow: const [
          BoxShadow(
            color: Color(0x29000000),
            offset: Offset(0, 4),
            blurRadius: 13,
          ),
        ],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(6.r),
            child: Image.network(
              imagePath,
              width: 70.w,
              height: 70.w,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Image.asset(
                  AppImages.apple,
                  width: 70.w,
                  height: 70.w,
                  fit: BoxFit.cover,
                );
              },
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  rank,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: rankColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBadgeItem({
    required String iconPath,
    required String name,
    required String achievement,
    required Color achievementColor,
  }) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 6.h, horizontal: 12.w),
      padding: EdgeInsets.all(8.w),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.09),
        borderRadius: BorderRadius.circular(8.r),
        boxShadow: const [
          BoxShadow(
            color: Color(0x29000000),
            offset: Offset(0, 4),
            blurRadius: 13,
          ),
        ],
      ),
      child: Row(
        children: [
          Image.asset(
            iconPath,
            width: 40.w,
            height: 40.w,
            fit: BoxFit.cover,
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  achievement,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: achievementColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
