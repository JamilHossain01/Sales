import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../uitilies/app_colors.dart';

class CustomTextField extends StatefulWidget {
  final String hintText;
  final bool showObscure;
  final bool? readOnly;
  final bool? enabled;
  final IconData? prefixIcon;
  final TextInputType? keyboardType;
  final TextEditingController? controller;
  final Color? fillColor;
  final Color? borderColor;
  final int? maxLines;
  final String? Function(String?)? validator; // <-- Add this line

  const CustomTextField({
    Key? key,
    required this.hintText,
    required this.showObscure,
    this.keyboardType,
    this.controller,
    this.prefixIcon,
    this.fillColor,
    this.borderColor,
    this.maxLines,
    this.readOnly,
    this.enabled = true,
    this.validator, // <-- Add this line
  }) : super(key: key);

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.width,
      child: TextFormField(
        keyboardType: widget.keyboardType,
        controller: widget.controller,
        readOnly: widget.readOnly ?? false,
        enabled: widget.enabled,
        obscureText: widget.showObscure ? _obscureText : false,
        maxLines: widget.maxLines ?? 1,
        validator: widget.validator, // <-- Forward validator here
        decoration: InputDecoration(
          filled: true,
          fillColor: widget.fillColor ?? Colors.white,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.sp),
            borderSide: BorderSide(
              color: widget.borderColor ?? AppColors.borderColor,
              width: 1,
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.sp),
            borderSide: BorderSide(
              color: widget.borderColor ?? AppColors.borderColor,
              width: 1,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.sp),
            borderSide: BorderSide(
              color: widget.borderColor ?? AppColors.borderColor,
              width: 1,
            ),
          ),
          prefixIcon: widget.prefixIcon != null
              ? Icon(widget.prefixIcon, color: AppColors.mainColor)
              : null,
          suffixIcon: widget.showObscure
              ? IconButton(
            icon: Icon(
              _obscureText ? Icons.visibility_off : Icons.visibility,
              color: AppColors.borderColor,
            ),
            onPressed: () {
              setState(() {
                _obscureText = !_obscureText;
              });
            },
          )
              : null,
          hintText: widget.hintText,
          hintStyle: GoogleFonts.poppins(
            fontSize: 14.h,
            color: Colors.grey.shade500,
          ),
        ),
      ),
    );
  }
}
