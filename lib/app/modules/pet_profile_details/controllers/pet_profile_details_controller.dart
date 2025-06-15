import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../uitilies/app_images.dart';
import '../model/service-model.dart';

class PetProfileDetailsController extends GetxController {
  var serviceDetail = PetProfileModel(
    title: "Kitten",
    location: "Vilnius, Lithuania",
    weight: 3.0,
    ageYears: 3,
    ageMonths: 5,
    breed: "Maine Coon",
    gender: "Male",
    isVaccinated: true,
    isChipped: true,
    isNeutered: true,
    description:
    "Kitten is a gentle and affectionate Maine Coon who loves being the center of attention. She enjoys playful moments with toys and quiet cuddles on the couch. With her soft purr and loving nature, Luna makes a perfect companion for families and individuals alike. She adapts easily to new environments and thrives in a calm, indoor home.",
    images: [
      AppImages.pet1,
      AppImages.pet2,
      AppImages.pet4,
    ],
    shelterName: "SOS Gyvūnai",
    shelterLocation: "Vilnius, Lithuania",
    shelterPhone: "+370 83 398 26",
    shelterEmail: "info@sos-gyvunai.lt",
    shelterImageUrl: AppImages.pet4,
  ).obs;

  var currentPage = 0.obs;
  PageController pageController = PageController();
}
