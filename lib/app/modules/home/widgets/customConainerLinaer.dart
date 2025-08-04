import 'package:flutter/material.dart';

class CustomGradientContainer extends StatelessWidget {
  final Widget child;

  const CustomGradientContainer({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 30), // Gap from top
        Container(
          width: double.infinity,
          padding:  EdgeInsets.all(16),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFFFCB806).withOpacity(0.050),
                Color(0xFFFCB806).withOpacity(0.050),
              ],
              stops: [0.0, 1.0],
            ),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(44),
              bottomRight: Radius.circular(44),
            ),
            boxShadow: [
              BoxShadow(
                color: Color(0x29000000), // Subtle shadow
                offset: Offset(0, 4),
                blurRadius: 13,
                spreadRadius: 0,
              ),
            ],
          ),
          child: child
        ),
      ],
    );
  }
}