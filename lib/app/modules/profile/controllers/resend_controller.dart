import 'dart:convert';

import 'package:get/get.dart';
import 'package:wolf_pack/app/uitilies/snakbar.dart';

import '../../../common widget/customSnackBar.dart';
import '../../../uitilies/api/api_url.dart';
import '../../../uitilies/api/base_client.dart';





class ResendEmailController extends GetxController {
  var isLoading = false.obs;

  Future<void> resendEmail({required String email}) async {
    isLoading(true);

    try {
      final response = await BaseClient.postRequest(
        api: ApiUrl.resendEmail,
        body: {"email": email}, // <-- pass Map directly
      );

      final responseBody = response.body.isNotEmpty
          ? jsonDecode(response.body)
          : {};

      if (response.statusCode == 200 && responseBody['success'] == true) {
        CustomSnackbar.showSuccess(responseBody['message'] ?? 'OTP Sent!');
        // Navigate to OTP screen if needed
      } else {
        throw responseBody['message'] ?? 'OTP request failed';
      }
    } catch (e) {
      CustomSnackbar.showError(e.toString());
    } finally {
      isLoading(false);
    }
  }
}
