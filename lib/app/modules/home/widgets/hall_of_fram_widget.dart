import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wolf_pack/app/uitilies/app_colors.dart';
import '../../../common_widget/custom text/custom_text_widget.dart';

class HallOfFameWidget extends StatelessWidget {
  final String timePeriod;
  final String name;
  final bool isNotEmty;
  final dynamic? commission;
  final dynamic? dealAmount;
  final dynamic? dealsClosed;
  final String imageUrl;

  const HallOfFameWidget({
    super.key,
    this.timePeriod = 'THIS WEEK',
    this.name = 'Name',
    this.commission = 0,
    this.dealAmount = 0,
    this.dealsClosed = 0,
    this.isNotEmty = true,
    this.imageUrl = '',
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 10.h),
        Container(
          width: double.maxFinite,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.white.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 🔹 Period Label
              CustomText(
                text: timePeriod,
                fontSize: 10.sp,
                color: Colors.grey,
              ),
              SizedBox(height: 12.h),

              // 🔹 Conditional Content
              if (isNotEmty)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [

                        CircleAvatar(
                          radius: 20.r,
                          backgroundColor: AppColors.orangeColor,
                          backgroundImage: imageUrl.isNotEmpty
                              ? NetworkImage(imageUrl)
                              : null,
                          child: imageUrl.isEmpty
                              ? Icon(Icons.person,
                                  color: Colors.white, size: 20.r)
                              : null,
                        ),
                        SizedBox(width: 12.w),
                        CustomText(
                          text: name,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ],
                    ),
                    SizedBox(height: 12.h),
                    _buildStatRow('Deal Amount', '€$dealAmount'),
                    _buildDivider(),
                    _buildStatRow('Commission', '€$commission'),
                    _buildDivider(),
                    _buildStatRow('Deals Closed', '$dealsClosed'),
                  ],
                )
              else
                // 🔹 Empty State
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.h),
                  child: Center(
                    child: CustomText(
                      text: 'No data found for $timePeriod',
                      color: Colors.white60,
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDivider() => Divider(
        height: 1,
        thickness: 0.3,
        color: Colors.white10,
      );

  Widget _buildStatRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomText(
            text: label,
            color: Colors.white60,
            fontWeight: FontWeight.w500,
          ),
          CustomText(
            text: value,
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ],
      ),
    );
  }
}
