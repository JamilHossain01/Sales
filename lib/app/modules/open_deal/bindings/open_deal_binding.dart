import 'package:get/get.dart';

import '../controllers/open_deal_controller.dart';

class OpenDealBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OpenDealController>(
      () => OpenDealController(),
    );
  }
}
