import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wolf_pack/app/modules/closed_deal/widgets/closed_wdigest_view.dart';
import 'package:wolf_pack/app/modules/view_details/controllers/check_box_controler.dart';

import '../../../common_widget/custom_app_bar_widget.dart';
import '../../../common_widget/custom_button.dart';
import '../../../uitilies/app_colors.dart';
import '../../open_deal/controllers/open_deal_controller.dart';
import '../../view_details/controllers/image_controller.dart';
import '../widgets/closed_deal_clients_details_widgets.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wolf_pack/app/modules/closed_deal/widgets/closed_wdigest_view.dart';
import 'package:wolf_pack/app/modules/view_details/controllers/check_box_controler.dart';

import '../../../common_widget/custom_app_bar_widget.dart';
import '../../../common_widget/custom_button.dart';
import '../../../uitilies/app_colors.dart';
import '../../open_deal/controllers/open_deal_controller.dart';
import '../../view_details/controllers/image_controller.dart';
import '../widgets/closed_deal_clients_details_widgets.dart';

class ClosedDealView extends StatefulWidget {
  final String clientID;

  const ClosedDealView({super.key, required this.clientID});

  @override
  State<ClosedDealView> createState() => _ClosedDealViewState();
}

class _ClosedDealViewState extends State<ClosedDealView> {
  String? selectedClient;
  String? selectedStatus;

  /// 👉 Client Details should show first
  bool isAddDealActive = false;

  List<String> clients = ['Techsavy Solutions Ltd.', 'NextGen Tech', 'CodeLab'];
  List<String> statusList = ['Pending', 'Approved', 'Rejected'];

  @override
  void initState() {
    super.initState();
    Get.put(OpenDealController());
    Get.put(ImagePickerController());
    Get.put(CheckboxController());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF000000),
      appBar: const CommonAppBar(title: 'Close Deal'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Toggle Buttons
            Row(
              children: [
                Expanded(
                  child: CustomButton(
                    isGradient: false,
                    buttonColor: isAddDealActive
                        ? const Color(0XFFFCB806).withOpacity(0.30)
                        : const Color(0XFFFCB806).withOpacity(0.15),
                    titleColor: isAddDealActive
                        ? Colors.white
                        : AppColors.textGray,
                    title: 'Add Deals',
                    onTap: () {
                      setState(() {
                        isAddDealActive = true;
                      });
                    },
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: CustomButton(
                    isGradient: false,
                    buttonColor: !isAddDealActive
                        ? const Color(0XFFFCB806).withOpacity(0.30)
                        : const Color(0XFFFCB806).withOpacity(0.15),
                    titleColor: !isAddDealActive
                        ? Colors.white
                        : AppColors.textGray,
                    title: 'Client Details',
                    onTap: () {
                      setState(() {
                        isAddDealActive = false;
                      });
                    },
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            /// 👉 Show Client Details first
            isAddDealActive
                ? ClosedViewWidgets()
                : ClosedDealClintDeatilsView(clientId: widget.clientID),
          ],
        ),
      ),
    );
  }
}

