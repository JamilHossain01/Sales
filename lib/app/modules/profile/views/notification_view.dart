import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wolf_pack/app/common_widget/nodata_wisgets.dart';
import 'package:wolf_pack/app/uitilies/custom_loader.dart';

import '../../../common_widget/custom_app_bar_widget.dart';
import '../../../common_widget/noitification_item.dart';
import '../../notification/notification_controller.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../common_widget/custom_app_bar_widget.dart';
import '../../../common_widget/noitification_item.dart';
import '../../notification/notification_controller.dart';

class NotificationView extends StatelessWidget {
  NotificationView({Key? key}) : super(key: key);

  // Initialize the controller (make sure it is registered with Get.put somewhere)
  final NotificationController controller = Get.put(NotificationController());

  @override
  Widget build(BuildContext context) {
    // Call API on init or you can do this in controller's onInit()
    controller.getNotificationData();

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: const CommonAppBar(title: 'Notifications', showBackButton: false),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Obx(() {
          if (controller.isLoading.value) {
            return  Center(child: CustomLoader());
          }

          if (controller.notificationData.value.data == null ||
              controller.notificationData.value.data!.data.isEmpty) {
            return  Center(
              child: NoDataWidget(text: 'No notifications')
            );
          }

          final notifications = controller.notificationData.value.data!.data;

          return RefreshIndicator(
            onRefresh: controller.getNotificationData, // Trigger the refresh
            color: Colors.amber, // Change color if needed
            child: ListView.builder(
              itemCount: notifications.length,
              itemBuilder: (context, index) {
                final item = notifications[index];
                return NotificationItem(
                  isHighlighted: !item.isRead!,
                  title: item.title ?? "No Title",
                  message: item.body ?? "",
                  message1: "", // Adjust if you have message1 or split body
                  time: item.createdAt != null
                      ? TimeOfDay.fromDateTime(item.createdAt!).format(context)
                      : "",
                  showEmoji: false, // Or true depending on your logic
                );
              },
            ),
          );
        }),
      ),
    );
  }
}
