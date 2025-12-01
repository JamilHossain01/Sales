import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wolf_pack/app/modules/open_deal/widgets/new_add_deals.dart';
import 'package:wolf_pack/app/modules/view_details/controllers/check_box_controler.dart';
import 'package:wolf_pack/app/modules/view_details/widgets/add_details_widgets.dart';
import '../../../common_widget/custom_app_bar_widget.dart';
import '../../../common_widget/custom_button.dart';
import '../../../uitilies/app_colors.dart';
import '../../closed_deal/widgets/closed_deal_clients_details_widgets.dart';
import '../../view_details/controllers/image_controller.dart';
import '../../view_details/widgets/clinet_details_wigets.dart';
import '../controllers/open_deal_controller.dart';
import '../widgets/closed_deal_widgets.dart';
import '../widgets/open_deal_update_widgest.dart';

class OpenDealView extends StatefulWidget {
  const OpenDealView({super.key, required this.clientId, required this.clientName,required  this.clientNewDealCreateId});
  final String clientId;
  final String clientNewDealCreateId;
  final String clientName;


  @override
  State<OpenDealView> createState() => _OpenDealViewState();
}

class _OpenDealViewState extends State<OpenDealView> {
  String? selectedClient;
  String? selectedStatus;
  bool isAddDealActive = true;

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
      appBar: const CommonAppBar(title: 'Add New Deal'),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
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
                SizedBox(width: 20),
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
            isAddDealActive ? NewAddDealsForm(clientId:widget.clientId, clientName: widget.clientName, clientDealCreateId: widget.clientNewDealCreateId,) :  ClosedDealClintDeatilsView(clientId: widget.clientId,),
          ],
        ),
      ),
    );
  }
}
