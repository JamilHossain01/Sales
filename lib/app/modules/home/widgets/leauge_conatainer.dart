import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wolf_pack/app/uitilies/app_colors.dart';

import '../../../common_widget/custom text/custom_text_widget.dart';

class LeagueContainer extends StatelessWidget {
  final String text;
  final String imagePath;
  final Color textColor;

  const LeagueContainer({
    super.key,
    required this.text,
    required this.imagePath,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40.h, // Fixed height
      width: 200.w, // Fixed width for consistency
      decoration: BoxDecoration(
        color: AppColors.white.withOpacity(0.09),
        borderRadius: BorderRadius.all(Radius.circular(8.r)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: Center(

          child: Row(
            children: [
              Image.asset(
                imagePath,
                height: 15.h,
                width: 15.w,
              ),
              SizedBox(width: 2.w),
              Row(
                children: [
                  CustomText(
                    text: text,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: textColor,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
