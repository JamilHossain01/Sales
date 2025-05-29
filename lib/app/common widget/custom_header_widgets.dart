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
        CustomText(text: title,fontSize: 16.sp,fontWeight: FontWeight.w600,color: Colors.black,),
        CustomText(text: subTitle,fontSize: 12.sp,fontWeight: FontWeight.w400,color: AppColors.textGray,)
      ],);
  }
}