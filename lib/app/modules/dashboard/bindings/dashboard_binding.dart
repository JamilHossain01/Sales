import 'package:get/get.dart';
import 'package:wolf_pack/app/modules/dashboard/views/dashboard_view.dart';

import '../controllers/dashboard_controller.dart';

class DashboardBinding extends Bindings {
  @override
  void dependencies() {
    GetPage(
      name: '/dashboard',
      page: () => DashboardView(),
      binding: DashboardBinding(),
    );

  }
}
