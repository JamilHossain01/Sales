// File: sign_in_controller.dart
import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:wolf_pack/app/modules/dashboard/views/dashboard_view.dart';
import 'package:wolf_pack/app/modules/home/views/home_view.dart';

import '../../../common_widget/customSnackBar.dart';
import '../../../routes/app_pages.dart';
import '../../../uitilies/api/api_url.dart';
import '../../../uitilies/api/app_constant.dart';
import '../../../uitilies/api/local_storage.dart';
import '../../home/controllers/nav_controller.dart';
import '../../profile/controllers/get_myProfile_controller.dart';

class SignInController extends GetxController {
  final RxBool isLoading = false.obs;
  final StorageService storage = Get.put(StorageService());
  //
  // final GetMyProfileController profileController =
  //     Get.put(GetMyProfileController());

  Future<void> login({
    required String email,
    required String password,
  }) async {
    if (email.trim().isEmpty || password.trim().isEmpty) {
      CustomSnackbar.showError('Email and password are required');
      return;
    }

    isLoading.value = true;

    try {
      /// 🔹 FCM token
      String? fcmToken = storage.read<String>(AppConstant.fcmToken);
      fcmToken ??= await FirebaseMessaging.instance.getToken();
      if (fcmToken != null) {
        await storage.write(AppConstant.fcmToken, fcmToken);
      }

      final response = await http.post(
        Uri.parse(ApiUrl.signIn),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "email": email.trim(),
          "password": password.trim(),
          "fcmToken": fcmToken ?? "",
        }),
      );

      final Map<String, dynamic> responseData =
          jsonDecode(response.body ?? '{}');

      if (response.statusCode == 200 && responseData['success'] == true) {
        final data = responseData['data'];

        await storage.write(AppConstant.accessToken, data['accessToken']);
        await storage.write(AppConstant.refreshToken, data['refreshToken']);
        await storage.write(AppConstant.role, data['role']);


        final navController = Get.put(NavController(), permanent: true);


        await Future.doWhile(() async {
          await Future.delayed(const Duration(milliseconds: 50));
          return !navController.isReady.value;
        });

        await Future.delayed(const Duration(milliseconds: 300));

        Get.offAll(() => DashboardView());
      } else {
        throw Exception(responseData['message'] ?? 'Login failed');
      }
    } catch (e) {
      debugPrint('Login error: $e');
      CustomSnackbar.showError(
        e.toString().replaceAll('Exception:', '').trim(),
      );
    } finally {
      isLoading.value = false;
    }
  }
}
