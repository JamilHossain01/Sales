import 'package:get/get.dart';

import '../controllers/authentacation_controller.dart';

class AuthentacationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthentacationController>(
      () => AuthentacationController(),
    );
  }
}
