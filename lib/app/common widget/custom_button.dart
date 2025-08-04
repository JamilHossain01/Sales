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
  final Color? ImageColor;
  final Widget? widget;
  final bool? isGradient;
  final Gradient? gradient;

  // Optional image and icons
  final String? imagePath;
  final double? imageWidth;
  final double? imageHeight;
  final BoxFit? imageFit;

  final Widget? leftIcon;
  final Widget? rightIcon;

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
    this.imagePath,
    this.imageWidth,
    this.imageHeight,
    this.imageFit,
    this.leftIcon,
    this.rightIcon, this.ImageColor,
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
               LinearGradient(
                colors: [
                  Color(0xffFCB806).withOpacity(0.050),
                  Color(0xffFCB806).withOpacity(0.090),
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
                  // 🔹 Left icon or image
                  if (leftIcon != null)
                    leftIcon!
                  else if (imagePath != null)
                    Image.asset(
                      imagePath!,
                      width: imageWidth ?? 24,
                      height: imageHeight ?? 24,
                      fit: imageFit ?? BoxFit.contain,
                      color:ImageColor,
                    ),

                  if (leftIcon != null || imagePath != null)
                    const SizedBox(width: 8),

                  // 🔸 Button title
                  Text(
                    title,
                    style: GoogleFonts.urbanist(
                      fontSize: fontSize,
                      fontWeight: fontWeight,
                      color: titleColor,
                    ),
                  ),

                  // 🔹 Right icon
                  if (rightIcon != null) ...[
                    const SizedBox(width: 8),
                    rightIcon!,
                  ],
                ],
              ),
        ),
      ),
    );
  }
}
