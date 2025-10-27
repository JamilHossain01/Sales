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
  final String? Function(String?)? validator;
  final Widget? suffix; // ✅ NEW: for custom suffix widget like image

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
    this.validator,
    this.suffix, // ✅ NEW
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
        style: TextStyle(color: Colors.white),
        keyboardType: widget.keyboardType,
        controller: widget.controller,
        readOnly: widget.readOnly ?? false,
        enabled: widget.enabled,
        obscureText: widget.showObscure ? _obscureText : false,
        maxLines: widget.maxLines ?? 1,
        validator: widget.validator,
        decoration: InputDecoration(
          filled: true,
          fillColor: widget.fillColor ?? const Color(0xFF333333).withOpacity(0.25),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.sp),
            borderSide: BorderSide(
              color: widget.borderColor ?? AppColors.borderColor,
              width: 0.10,
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.sp),
            borderSide: BorderSide(
              color: widget.borderColor ?? AppColors.borderColor,
              width: 0.10,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.sp),
            borderSide: BorderSide(
              color: widget.borderColor ?? AppColors.borderColor,
              width: 0.10,
            ),
          ),
          prefixIcon: widget.prefixIcon != null
              ? Icon(widget.prefixIcon, color: AppColors.mainColor)
              : null,

          // ✅ Suffix: use image/icon if not showObscure
          suffixIcon: widget.showObscure
              ? IconButton(
            icon: Icon(
              _obscureText ? Icons.visibility_off : Icons.visibility,
              color: const Color(0xFF212529),
            ),
            onPressed: () {
              setState(() {
                _obscureText = !_obscureText;
              });
            },
          )
              : widget.suffix,

          hintText: widget.hintText,
          hintStyle: GoogleFonts.poppins(
            fontSize: 14.h,
            color:AppColors.white.withOpacity(0.5) ,
          ),
        ),
      ),
    );
  }
}
