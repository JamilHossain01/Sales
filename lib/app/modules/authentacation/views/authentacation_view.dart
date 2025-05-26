import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/authentacation_controller.dart';

class AuthentacationView extends GetView<AuthentacationController> {
  const AuthentacationView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AuthentacationView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'AuthentacationView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
