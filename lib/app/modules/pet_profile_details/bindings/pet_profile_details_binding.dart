import 'package:get/get.dart';

import '../controllers/pet_profile_details_controller.dart';

class PetProfileDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PetProfileDetailsController>(
      () => PetProfileDetailsController(),
    );
  }
}
