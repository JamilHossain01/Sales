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
        fontSize: 14.sp, // Adjusted to match the image's text size
        fontWeight: FontWeight.w400, // Slightly lighter for hint
        color: Colors.black.withOpacity(0.6), // Matches the lighter hint color
      ),
      items: widget.items.map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: CustomText(
            text: value,
            fontSize: 14.sp, // Consistent with hint size
            fontWeight: FontWeight.w400, // Consistent weight
            color: Colors.black, // Matches the image's text color
          ),
        );
      }).toList(),
      onChanged: widget.onChanged,
      decoration: InputDecoration(
        filled: true, // Adds the light gray background
        fillColor: Colors.grey[200], // Light gray background from the image
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(color: widget.borderColor ?? Colors.grey[400]!), // Subtle border
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(color: widget.borderColor ?? Colors.grey[400]!),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(color: widget.focusedBorderColor ?? Colors.grey[400]!), // Subtle focused border
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h), // Adjusted padding
         // Matches the arrow style
      ),
      dropdownColor: Colors.white,
      style: TextStyle(color: Colors.black), // Ensures text color consistency
      iconEnabledColor: Colors.black, // Matches the arrow color
      iconDisabledColor: Colors.black, // Ensures consistency when disabled
    );
  }
}