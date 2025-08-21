import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../../common widget/customSnackBar.dart';
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
      // Get FCM token from StorageService or FirebaseMessaging
      String? fcmToken = await storage.read<String>(AppConstant.fcmToken);
      debugPrint("FCM Token from storage: $fcmToken");

      // If token is not in storage, fetch fresh token (optional)
      if (fcmToken == null) {
        fcmToken = await FirebaseMessaging.instance.getToken();
        debugPrint("FCM Token fetched from FirebaseMessaging: $fcmToken");
        if (fcmToken != null) {
          await storage.write(AppConstant.fcmToken, fcmToken);
          debugPrint("FCM Token saved to storage");
        }
      }

      final url = Uri.parse(ApiUrl.signIn);
      final body = {
        "email": email.trim(),
        "password": password,
        "fcmToken": fcmToken ?? "",
      };

      debugPrint("Login request body: $body");

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

          CustomSnackbar.showSuccess(responseData['message'] ?? 'Sign in successful!');
          Get.offAllNamed(Routes.DASHBOARD);
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
}
