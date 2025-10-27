import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:wolf_pack/app/modules/log_in/views/log_in_view.dart';
import 'package:wolf_pack/app/modules/sign_in/views/sign_in_view.dart';
import '../../../common_widget/customSnackBar.dart';
import '../../../routes/app_pages.dart';
import '../../../uitilies/api/api_url.dart';
import '../../../uitilies/api/app_constant.dart';
import '../../../uitilies/api/local_storage.dart';



import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../../routes/app_pages.dart';
import '../../../uitilies/api/api_url.dart';
import '../../../uitilies/api/app_constant.dart';
import '../../../uitilies/api/local_storage.dart';

class SignInController extends GetxController {
  final isLoading = false.obs;
  final storage = Get.put(StorageService());

  Future<void> login({
    required String email,
    required String password,
  }) async {
    if (email.isEmpty || password.isEmpty) {
      CustomSnackbar.showError('Email and password are required');
      return;
    }

    isLoading.value = true;

    try {
      // 🔑 Get stored FCM token
      String? fcmToken = storage.read<String>(AppConstant.fcmToken);

      if (fcmToken == null) {
        fcmToken = await FirebaseMessaging.instance.getToken();
        if (fcmToken != null) {
          await storage.write(AppConstant.fcmToken, fcmToken);
        }
      }

      final url = Uri.parse(ApiUrl.signIn);
      final body = {
        "email": email.trim(),
        "password": password,
        "fcmToken": fcmToken ?? "",
      };

      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(body),
      );

      final responseData = jsonDecode(response.body);

      if (response.statusCode == 200 && responseData['success'] == true) {
        final data = responseData['data'];
        if (data != null) {
          await storage.write(AppConstant.accessToken, data['accessToken']);
          await storage.write(AppConstant.refreshToken, data['refreshToken']);
          await storage.write(AppConstant.role, data['role']);

          print("💾 Saved AccessToken: ${data['accessToken']}");
          print("💾 Saved Role: ${data['role']}");

          CustomSnackbar.showSuccess(
            responseData['message'] ?? 'Sign in successful!',
          );

          _navigateBasedOnRole(data['role']);
        } else {
          throw Exception("No token data received");
        }
      } else {
        throw Exception(responseData['message'] ?? 'Login failed');
      }
    } catch (e) {
      debugPrint("Login error: $e");
      CustomSnackbar.showError(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  void _navigateBasedOnRole(String role) {
    switch (role) {
      case 'USER':
        Get.offAllNamed(Routes.DASHBOARD);
        break;
      case 'ADMIN':
        Get.offAllNamed(Routes.DASHBOARD);
        break;
      case 'BUYER':
        Get.offAllNamed(Routes.ONBOARDING);
        break;
      default:
        Get.offAllNamed(Routes.SIGN_IN);
    }
  }
}
