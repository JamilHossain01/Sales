import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ProfileImageController extends GetxController {
  RxString selectedImagePath = ''.obs;

  Future<void> pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);
    if (pickedFile != null) {
      selectedImagePath.value = pickedFile.path;
    }
  }
}
