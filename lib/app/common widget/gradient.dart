import 'package:flutter/material.dart';
import 'package:wolf_pack/app/uitilies/app_images.dart';

class GradientContainer extends StatelessWidget {
  const GradientContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Image.asset(
        AppImages.gradients,
        fit: BoxFit.cover,
      ),
    );
  }
}
