import 'package:get/get.dart';

class DashboardController extends GetxController {
  var selectedIndex = 0.obs;

  static const int notificationTabIndex = 2;

  void changeIndex(int index) {
    selectedIndex.value = index;
  }

  void goToNotifications() {
    selectedIndex.value = notificationTabIndex;
  }

}
