import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wolf_pack/app/common_widget/custom%20text/custom_text_widget.dart';

import '../uitilies/app_colors.dart';
import 'custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wolf_pack/app/common_widget/custom text/custom_text_widget.dart';
import '../uitilies/app_colors.dart';
import 'custom_button.dart';

class CustomSuccessScreen extends StatefulWidget {
  final String title;
  final String message;
  final String? clientName; // Added for client-specific text
  final VoidCallback onContinue;

  const CustomSuccessScreen({
    super.key,
    required this.title,
    required this.message,
    this.clientName, // Optional
    required this.onContinue,
  });

  @override
  State<CustomSuccessScreen> createState() => _CustomSuccessScreenState();
}

class _CustomSuccessScreenState extends State<CustomSuccessScreen>
    with SingleTickerProviderStateMixin {
  double _scale = 0.0;
  double _opacity = 0.0;

  @override
  void initState() {
    super.initState();
    // Start animations
    Future.delayed(const Duration(milliseconds: 300), () {
      if (mounted) {
        setState(() {
          _scale = 1.0;
          _opacity = 1.0;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedScale(
                scale: _scale,
                duration: const Duration(milliseconds: 600),
                curve: Curves.elasticOut,
                child: AnimatedOpacity(
                  opacity: _opacity,
                  duration: const Duration(milliseconds: 400),
                  child: Icon(
                    Icons.check_circle,
                    size: 120,
                    color: AppColors.mainColor,
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Title
              Text(
                widget.title,
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: AppColors.mainColor,
                ),
                textAlign: TextAlign.center,
              ),

              // Client Name (Deal-specific text)
              if (widget.clientName != null) ...[
                const SizedBox(height: 12),
                CustomText(
                  text: 'for ${widget.clientName}',
                  fontSize: 22.sp,
                  color: AppColors.mainColor,
                  fontWeight: FontWeight.w600,
                  textAlign: TextAlign.center,
                ),
              ],

              const SizedBox(height: 16),

              // Message
              CustomText(
                text: widget.message,
                textAlign: TextAlign.center,
                fontSize: 16.sp,
                color: Colors.white,
              ),

              const SizedBox(height: 40),

              // Continue Button
              CustomButton(
                isGradient: false,
                buttonColor: AppColors.orangeColor,
                title: "Back to Home",
                onTap: widget.onContinue,
              ),
            ],
          ),
        ),
      ),
    );
  }
}