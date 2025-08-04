// custom_checkbox.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomCheckboxWithText extends StatelessWidget {
  final String text;
  final RxBool isChecked;
  final Color activeColor;
  final TextStyle? textStyle;

  const CustomCheckboxWithText({
    super.key,
    required this.text,
    required this.isChecked,
    this.activeColor = const Color(0xFF00D1FF),
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() => Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Checkbox(
          value: isChecked.value,
          onChanged: (value) {
            isChecked.value = value ?? false;
          },
          activeColor: activeColor,
          checkColor: Colors.black,
          side: BorderSide(color: activeColor, width: 2),
        ),
        SizedBox(width: 8.w),
        Expanded(
          child: Text(
            text,
            style: textStyle ??
                TextStyle(
                  fontSize: 14.sp,
                  color: Color(0xFF00D1FF),
                  fontWeight: FontWeight.w400,
                ),
          ),
        ),
      ],
    ));
  }
}
