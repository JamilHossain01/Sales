import 'package:flutter/material.dart';

import '../uitilies/app_colors.dart';
import 'custom_button.dart';
class CustomSuccessScreen extends StatefulWidget {
  final String title;
  final String message;
  final VoidCallback onContinue;

  const CustomSuccessScreen({
    super.key,
    required this.title,
    required this.message,
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
      setState(() {
        _scale = 1.0;
        _opacity = 1.0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
              Text(
                widget.title,
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: AppColors.mainColor,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              Text(
                widget.message,
                style: const TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              CustomButton(
                title: "Back to Home",
                onTap: widget.onContinue,
              )
            ],
          ),
        ),
      ),
    );
  }
}
