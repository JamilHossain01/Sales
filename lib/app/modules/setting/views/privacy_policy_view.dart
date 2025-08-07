import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wolf_pack/app/common%20widget/custom_app_bar_widget.dart';
import 'package:wolf_pack/app/modules/profile/widgets/about_section_widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../../../common widget/nodata_wisgets.dart';
import '../../../uitilies/custom_loader.dart';
import '../controllers/get_setting_controller.dart';

class SPPrivacyPolicyView extends StatelessWidget {
  const SPPrivacyPolicyView({super.key});

  @override
  Widget build(BuildContext context) {
    final GetMyProfileSettingController controller = Get.put(GetMyProfileSettingController());
    return Scaffold(
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
      appBar: const CommonAppBar(
        title: 'Privacy Policy',
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return  Center(child: CustomLoader());
        }
        final termData = controller.profileSettingData.value.data;
        if (termData == null || (termData.terms?.isEmpty ?? true)) {
          return const Center(child: NoDataWidget(text: '',));
        }
        return Stack(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(16, kToolbarHeight + MediaQuery.of(context).padding.top + 16, 16, 16),
              child: SingleChildScrollView(
                child: AboutUsSection(

                  content: termData.privacy?? "N/A",
                ),
              ),
            ),
          ],
        );
      }),

    );
  }
}
