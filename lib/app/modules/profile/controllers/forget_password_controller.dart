import 'dart:convert';
import 'package:get/get.dart';
import 'package:pet_donation/app/uitilies/snakbar.dart';

import '../../../common widget/customSnackBar.dart';
import '../../../uitilies/api/api_url.dart';
import '../../../uitilies/api/app_constant.dart';
import '../../../uitilies/api/base_client.dart';
import '../../../uitilies/api/local_storage.dart';
import '../../sign_in/views/otp_view.dart';

class ForgotPasswordController extends GetxController {
  final isLoading = false.obs;
  final StorageService _storage = Get.put(StorageService());

  Future<void> forgotPass({required String email}) async {
    isLoading(true);

    try {
      final response = await BaseClient.postRequest(
        api: ApiUrl.forgotPassword,
        body: {"email": email},
      );

      final responseBody = response.body.isNotEmpty
          ? jsonDecode(response.body)
          : {};

      if (response.statusCode == 200 && responseBody['success'] == true) {
        final newToken = responseBody['data']['token'];
        if (newToken != null && newToken.isNotEmpty) {
          await _storage.write(AppConstant.otpToken, newToken);
          print('[OTP DEBUG] ✅ Token saved: $newToken');
        } else {
          print('[OTP DEBUG] ⚠️ Token missing in response');
          throw 'Token not received from server';
        }

        CustomSnackbar.showSuccess(responseBody['message'] ?? 'OTP Sent!');
        Get.to(() => OtpView(email: email));
      } else {
        throw responseBody['message'] ?? 'OTP request failed';
      }
    } catch (e) {
      CustomSnackbar.showError(e.toString());
      print('[OTP DEBUG] ❌ Exception: $e');
    } finally {
      isLoading(false);
    }
  }
}
