import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../common_widget/customSnackBar.dart';
import '../../../uitilies/api/api_url.dart';
import '../../../uitilies/api/local_storage.dart';
import '../../sign_in/views/new_password.dart';
import '../../../uitilies/api/app_constant.dart';
import '../views/new_password.dart';

class VerifyOtpController extends GetxController {
  final StorageService _storage = Get.put(StorageService());
  final isLoading = false.obs;

  Future<void> verifyOtp(String otp) async {
    final token = _storage.read<String>(AppConstant.otpToken);

    print('[OTP DEBUG] 🔐 OTP Token: $token'); // Debug print

    if (token == null || token.isEmpty) {
      CustomSnackbar.showError('Verification token missing. Please log in again.');
      return;
    }

    isLoading(true);
    try {
      final intOtp = int.tryParse(otp.replaceAll(' ', '')) ?? -1;
      if (intOtp == -1) {
        CustomSnackbar.showError('Invalid OTP format. Please enter a valid number.');
        return;
      }

      final response = await http.post(
        Uri.parse(ApiUrl.verifyOtp),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'token': '$token',
        },
        body: jsonEncode({'otp': intOtp}),
      );

      final data = jsonDecode(utf8.decode(response.bodyBytes));
      final ok = response.statusCode == 200 && data['success'] == true;

      if (ok) {
        final accessToken = data['data']?['accessToken'];
        if (accessToken != null && accessToken.isNotEmpty) {
          await _storage.write(AppConstant.accessToken, accessToken);
          print('[OTP DEBUG] ✅ Access token saved: $accessToken');
        } else {
          print('[OTP DEBUG] ⚠️ Access token missing in response');
        }

        CustomSnackbar.showSuccess(data['message'] ?? 'OTP Verified');
        Get.offAll(() => const MakeNewPassword());
      } else {
        throw data['message'] ?? 'OTP verification failed';
      }
    } catch (e) {
      CustomSnackbar.showError(e.toString());
      print('[OTP DEBUG] ❌ Exception: $e');
    } finally {
      isLoading(false);
    }
  }
}
