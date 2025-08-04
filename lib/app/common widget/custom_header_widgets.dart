import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../uitilies/app_colors.dart';
import 'custom text/custom_text_widget.dart';

class HeaderWidgets extends StatelessWidget {
  final String title;
  final String subTitle;
  const HeaderWidgets({
    super.key, required this.title, required this.subTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Row( mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomText(text: title,fontSize: 14.sp,fontWeight: FontWeight.w500,color: AppColors.white.withOpacity(0.7),),
        CustomText(text: subTitle,fontSize: 12.sp,fontWeight: FontWeight.w400,color: Color(0XFFFCB806).withOpacity(0.6),)
      ],);
  }
}