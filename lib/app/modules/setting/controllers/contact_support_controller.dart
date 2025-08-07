import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../common widget/customSnackBar.dart';
import '../../../common widget/support_screen.dart';
import '../../../uitilies/api/api_url.dart';
import '../../../uitilies/api/app_constant.dart';
import '../../../uitilies/api/local_storage.dart';

class SupportController extends GetxController {
  final isLoading = false.obs;
  final _storageService = Get.find<StorageService>();

  Future<void> supportMessageSend({
    required String name,
    required String email,
    required String message,
    required TextEditingController controller,
  }) async {
    try {
      // Validate inputs
      if (name.trim().isEmpty || email.trim().isEmpty || message.trim().isEmpty) {
        throw 'Name, email, and message cannot be empty.';
      }

      _logRequest(name, email, message);
      isLoading.value = true;

      final accessToken = await _storageService.read(AppConstant.accessToken);
      if (accessToken == null || accessToken.isEmpty) {
        throw 'Authentication token not found. Please login again.';
      }

      final response = await http.post(
        Uri.parse(ApiUrl.supportCreate),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': '$accessToken',
        },
        body: json.encode({
          'name': name.trim(),
          'email': email.trim(),
          'message': message.trim(),
        }),
      );

      _handleResponse(response);

      CustomSnackbar.showSuccess('Feedback submitted successfully');
      controller.clear();
      Get.off(() => SupportConfirmationScreen());
    } catch (e) {
      CustomSnackbar.showError(e.toString());
      debugPrint('Error submitting feedback: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void _handleResponse(http.Response response) {
    debugPrint('Response status: ${response.statusCode}');
    debugPrint('Response body: ${response.body}');

    if (response.statusCode == 401) {
      throw 'Session expired. Please login again.';
    } else if (response.statusCode != 200) {
      throw 'Server error: ${response.statusCode}';
    }

    try {
      final jsonResponse = json.decode(response.body);
      if (jsonResponse['success'] != true) {
        throw jsonResponse['message'] ?? 'Request failed';
      }
    } catch (e) {
      throw 'Invalid response format';
    }
  }

  void _logRequest(String name, String email, String message) {
    debugPrint('''🚀 Making feedback request:
- Endpoint: ${ApiUrl.supportCreate}
- Name: $name
- Email: $email
- Message: ${message.length > 20 ? '${message.substring(0, 20)}...' : message}''');
  }
}