import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pet_donation/app/common%20widget/custom%20text/custom_text_widget.dart';

class CustomDropdown extends StatefulWidget {
  final String? value;
  final String hint;
  final List<String> items;
  final ValueChanged<String?> onChanged;
  final Color? borderColor;
  final Color? focusedBorderColor;

  const CustomDropdown({
    super.key,
    this.value,
    this.hint = 'Select an option',
    required this.items,
    required this.onChanged,
    this.borderColor,
    this.focusedBorderColor,
  });

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
        fontSize: 12.sp,
        fontWeight: FontWeight.w500,
        color: Colors.black.withOpacity(0.6), // lighter color for hint
      ),
      items: widget.items.map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: CustomText(
            text: value,
            fontSize: 12.sp,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        );
      }).toList(),
      onChanged: widget.onChanged,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(color: widget.borderColor ?? Colors.grey),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(color: widget.borderColor ?? Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(color: widget.focusedBorderColor ?? Theme.of(context).primaryColor),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 14.h),
      ),
      dropdownColor: Colors.white,
      style: TextStyle(color: Colors.black), // text style when selected
    );
  }
}
