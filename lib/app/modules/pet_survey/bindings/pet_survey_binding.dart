import 'package:get/get.dart';

import '../controllers/pet_survey_controller.dart';

class PetSurveyBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PetSurveyController>(
      () => PetSurveyController(),
    );
  }
}
