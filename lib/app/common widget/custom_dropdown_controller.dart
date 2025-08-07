import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wolf_pack/app/common%20widget/custom%20text/custom_text_widget.dart';
import '../uitilies/app_colors.dart';

class CustomDropdown extends StatefulWidget {
  final String? value;
  final String hint;
  final List<String> items;
  final ValueChanged<String?> onChanged;
  final Color? borderColor;
  final Color? focusedBorderColor;
  final Color? fillColor;

  const CustomDropdown({
    Key? key,
    this.value,
    this.hint = 'Select an option',
    required this.items,
    required this.onChanged,
    this.borderColor,
    this.focusedBorderColor,
    this.fillColor,
  }) : super(key: key);

  @override
  State<CustomDropdown> createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: widget.value,
      hint: CustomText(
        text: widget.hint,
        fontSize: 14.sp,
        fontWeight: FontWeight.w400,
        color: const Color(0xFF212529), // Match TextField hint color
      ),
      items: widget.items.map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: CustomText(
            text: value,
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
            color: Colors.white,
          ),
        );
      }).toList(),
      onChanged: widget.onChanged,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        filled: true,
        fillColor: widget.fillColor ?? const Color(0xFF333333).withOpacity(0.25), // same as TextField
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide(
            color: widget.borderColor ?? AppColors.borderColor,
            width: 0.10,
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide(
            color: widget.borderColor ?? AppColors.borderColor,
            width: 0.10,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide(
            color: widget.focusedBorderColor ?? AppColors.borderColor,
            width: 0.10,
          ),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
      ),
      dropdownColor: const Color(0xFF1E1E1E),
      iconEnabledColor: Colors.white,
      iconDisabledColor: Colors.white,
    );
  }
}
