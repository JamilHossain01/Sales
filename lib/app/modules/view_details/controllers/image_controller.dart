import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ImagePickerController extends GetxController {
  var selectedImagePath = ''.obs;  // To store the picked image path

  // Method to pick image from either camera or gallery
  Future<void> pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      selectedImagePath.value = pickedFile.path;
      print("🖼️ Image picked: ${pickedFile.path}");
    } else {
      print("❌ No image selected.");
    }
  }
}
