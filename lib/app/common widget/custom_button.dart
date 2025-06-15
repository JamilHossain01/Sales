// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final void Function()? onTap;
  final bool isLoading;
  final double width;
  final double? height;
  final FontWeight? fontWeight;

  final double padding_vertical;
  final double borderRadius;
  final Color? buttonColor;
  final double fontSize;
  final BoxBorder? border;
  final Color? titleColor;
  final Widget? widget;
  final bool? isGradient;
  final Gradient? gradient;

  /// 🔹 NEW: Optional image to display beside title
  final String? imagePath;

  const CustomButton({
    super.key,
    required this.title,
    required this.onTap,
    this.isLoading = false,
    this.width = double.infinity,
    this.padding_vertical = 12.0,
    this.borderRadius = 8.0,
    this.border,
    this.titleColor = Colors.white,
    this.widget,
    this.fontSize = 16.0,
    this.isGradient = true,
    this.gradient,
    this.height,
    this.buttonColor,
    this.fontWeight = FontWeight.w700,
    this.imagePath, // ✅ added
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: isLoading ? null : onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        alignment: Alignment.center,
        width: width == double.infinity ? null : width,
        height: height,
        constraints: width == double.infinity
            ? const BoxConstraints(minWidth: double.infinity)
            : null,
        decoration: BoxDecoration(
          color: buttonColor,
          borderRadius: BorderRadius.circular(borderRadius),
          border: border,
          gradient: isGradient == true
              ? gradient ??
              const LinearGradient(
                colors: [
                  Color(0xff8AD8C0),
                  Color(0xff19A2A5),
                ],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              )
              : null,
        ),
        padding: EdgeInsets.symmetric(vertical: padding_vertical),
        child: isLoading
            ? const Center(
          child: CircularProgressIndicator(
            color: Colors.green,
            strokeWidth: 2,
          ),
        )
            : Center(
          child: widget ??
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (imagePath != null) ...[
                    Image.asset(imagePath!, width: 24, height: 24),
                    const SizedBox(width: 8),
                  ],
                  Text(
                    title,
                    style: GoogleFonts.urbanist(
                      fontSize: fontSize,
                      fontWeight: fontWeight,
                      color: titleColor,
                    ),
                  ),
                ],
              ),
        ),
      ),
    );
  }
}
