import 'package:flutter/material.dart';

class GradientContainer extends StatelessWidget {
  final double height;
  final double width;
  final List<Color> colors;
  final List<double> stops;
  final AlignmentGeometry center;
  final double radius;
  final Widget? child;

  const GradientContainer({
    Key? key,
    required this.height,
    required this.width,
    this.colors = const [
      Color(0xFF19A2A5),
      Color(0x0019A2A5),
    ],
    this.stops = const [0.03, 0.85],
    this.center = Alignment.topCenter,
    this.radius = 1.0,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        gradient: RadialGradient(
          colors: colors,
          stops: stops,
          center: center,
          radius: radius,
        ),
      ),
      child: child,
    );
  }
}
