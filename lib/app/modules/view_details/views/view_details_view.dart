import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import 'package:pet_donation/app/common%20widget/custom_app_bar_widget.dart';
import 'package:pet_donation/app/common%20widget/custom_button.dart';
import 'package:pet_donation/app/modules/view_details/controllers/image_controller.dart';
import 'package:pet_donation/app/modules/view_details/widgets/xustom_filePicker.dart';
import 'package:pet_donation/app/uitilies/app_images.dart';
import '../../../common widget/custom text/custom_text_widget.dart';
import '../../../common widget/custom_dropdown_controller.dart';
import '../../../uitilies/app_colors.dart';
import '../controllers/check_box_controler.dart';
import '../widgets/add_details_widgets.dart';
import '../widgets/check_box.dart';
import '../widgets/clinet_details_wigets.dart';

class ViewDetailsView extends StatefulWidget {
  const ViewDetailsView({super.key});

  @override
  State<ViewDetailsView> createState() => _ViewDetailsViewState();
}

class _ViewDetailsViewState extends State<ViewDetailsView> {
  String? selectedClient;
  String? selectedStatus;
  bool isAddDealActive = true;

  List<String> clients = ['Techsavy Solutions Ltd.', 'NextGen Tech', 'CodeLab'];
  List<String> statusList = ['Pending', 'Approved', 'Rejected'];

  @override
  void initState() {
    super.initState();
    Get.put(ImagePickerController());
    Get.put(CheckboxController());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF000000),
      appBar: const CommonAppBar(title: 'Open Deal'),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
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
                    titleColor: isAddDealActive ? AppColors.white : AppColors
                        .textGray,
                    title: 'Add Deals',
                    onTap: () {
                      setState(() {
                        isAddDealActive = true;
                      });
                    },
                  ),
                ),
                Gap(20.w),
                Expanded(
                  child: CustomButton(
                    isGradient: false,
                    buttonColor: !isAddDealActive
                        ? const Color(0XFFFCB806).withOpacity(0.30)
                        : const Color(0XFFFCB806).withOpacity(0.15),
                    titleColor: !isAddDealActive ? AppColors.white : AppColors
                        .textGray,
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
            SizedBox(height: 20.h),
            isAddDealActive ? const AddDealsForm() : const ClientDetailsForm(),
          ],
        ),
      ),
    );
  }
}


