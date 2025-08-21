import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wolf_pack/app/uitilies/app_colors.dart';
import 'package:wolf_pack/app/uitilies/app_images.dart';

class NewLeaderBoardCard extends StatelessWidget {
  final String? name;
  final String? value;

  const NewLeaderBoardCard({
    Key? key,
    this.name,
    this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xFF2B1B0F),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Padding(
        padding: EdgeInsets.all(12.h),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name ?? '',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  if (value != null)
                    Padding(
                      padding: EdgeInsets.only(top: 4.h),
                      child: Text(
                        value!.replaceAll('_', ' '),
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFFFFA500),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            SizedBox(
              child: Image.asset(AppImages.badges, width: 30, height: 30),
            ),
          ],
        ),
      ),
    );
  }
}