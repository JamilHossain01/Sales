import 'package:flutter/material.dart';

class GradientC extends StatelessWidget {
  final Widget? child;

  const GradientC({Key? key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return       Container(
      height: 130,
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: RadialGradient(
          colors: [
            Color(0xFF19A2A5),  // 100% opacity
            Color(0x0019A2A5),  // 0% opacity
          ],
          stops: [0.05, 0.5],
          center: Alignment.topLeft,
          radius: 1.5,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: child,
      ),
    );

  }
}

