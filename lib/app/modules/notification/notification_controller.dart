import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../uitilies/api/api_url.dart';
import '../../uitilies/api/base_client.dart';
import 'model/notification_model.dart';


class NotificationController extends GetxController {
  // initialize with an empty Data object containing empty list
  final Rx<NotificationModel> notificationData =
      NotificationModel(data: Data(meta: null, data: [])).obs;

  final RxBool isLoading = false.obs;
  final RxInt unreadNotificationCount = 0.obs;

  Future<void> getNotificationData() async {
    try {
      isLoading.value = true;

      final response = await BaseClient.getRequest(api: ApiUrl.notification);
      final responseBody = await BaseClient.handleResponse(response);

      if (responseBody is! Map<String, dynamic>) {
        throw Exception('Invalid response format');
      }

      final notificationModel = NotificationModel.fromJson(responseBody);
      notificationData.value = notificationModel;

      // FIX: access the inner list
      unreadNotificationCount.value =
          notificationModel.data?.data.where((e) => e.isRead == false).length ?? 0;

      if (notificationModel.data?.data.isEmpty ?? true) {
        debugPrint('No notification data found');
      }
    } catch (e, stackTrace) {
      debugPrint('Error: $e\nStackTrace: $stackTrace');
      Get.snackbar('Error', 'Failed to load notifications: $e');
      notificationData.value =
          NotificationModel(data: Data(meta: null, data: []));
      unreadNotificationCount.value = 0;
    } finally {
      isLoading.value = false;
    }
  }
}
