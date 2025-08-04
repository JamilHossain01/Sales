import 'dart:convert';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:http/http.dart' as http;
import 'package:pet_donation/app/uitilies/api/app_constant.dart';

import '../../../common widget/customSnackBar.dart';
import '../../../uitilies/api/api_url.dart';
import '../../../uitilies/api/local_storage.dart';
import '../../sign_in/controllers/log_in_controller.dart';
import '../../sign_in/views/sign_in_view.dart';

class NewPasswordController extends GetxController {
  final StorageService _storage = Get.find<StorageService>();
  final isLoading = false.obs;

  Future<void> setNewPassword({
    required String password,
    required String confirmPassword,
  }) async {
    print('🔐 Attempting to set new password...');
    print('New: $password | Confirm: $confirmPassword');

    final token = _storage.read<String>(AppConstant.otpToken);
    print('🔍 Retrieved Token: $token');
    if (token == null || token.isEmpty) {
      CustomSnackbar.showError('Authorization token missing. Please login again.');
      Get.offAll(() => SignInView());
      return;
    }

    if (password != confirmPassword) {
      CustomSnackbar.showError('Passwords do not match!');
      return;
    }

    isLoading(true);
    try {
      final response = await http.post(
        Uri.parse(ApiUrl.setNewPassword),
        headers: {
          'Content-Type': 'application/json',
          'token': '$token',
        },
        body: jsonEncode({
          'password': password, // API only needs password based on Postman
        }),
      );

      print('📡 Response Status: ${response.statusCode}');
      print('📡 Response Body: ${response.body}');

      final responseBody = response.body.isNotEmpty ? jsonDecode(response.body) : {};

      if (response.statusCode == 200 && responseBody['success'] == true) {
        CustomSnackbar.showSuccess(responseBody['message'] ?? 'Password updated successfully!');
        Get.offAll(() => SignInView());
      } else if (response.statusCode == 401) {
        CustomSnackbar.showError('Session expired or invalid token. Please log in again.');
        Get.offAll(() => SignInView());
      } else {
        throw responseBody['message'] ?? 'Password update failed';
      }
    } catch (e) {
      print('❗ Exception: $e');
      CustomSnackbar.showError(e.toString());
    } finally {
      isLoading(false);
    }
  }
}