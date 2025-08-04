import 'package:get/get.dart';

import '../controllers/closed_deal_controller.dart';

class ClosedDealBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ClosedDealController>(
      () => ClosedDealController(),
    );
  }
}
