import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_donation/app/common%20widget/gradient.dart';

import '../controllers/authentacation_controller.dart';

class AuthentacationView extends GetView<AuthentacationController> {
  const AuthentacationView({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height; // define screenHeight here

    return Scaffold(
      // Remove AppBar if not needed
      body: Column(
        children: [
          GradientContainer(
            height: screenHeight * 0.2,
            width: double.infinity,
          ),
          const SizedBox(height: 24),
          const Center(
            child: Text(
              'AuthentacationView is working',
              style: TextStyle(fontSize: 20),
            ),
          ),
        ],
      ),
    );
  }
}
