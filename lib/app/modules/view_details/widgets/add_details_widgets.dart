import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:wolf_pack/app/common%20widget/custom%20text/custom_text_widget.dart';
import 'package:wolf_pack/app/modules/view_details/widgets/check_box.dart';
import 'package:wolf_pack/app/modules/view_details/widgets/xustom_filePicker.dart';
import 'package:wolf_pack/app/uitilies/app_colors.dart';

import '../../../common widget/custom_button.dart';
import '../../../common widget/custom_dropdown_controller.dart';
import '../../../common widget/custom_text_filed.dart';
import '../../../uitilies/app_images.dart';
import '../controllers/check_box_controler.dart';

class AddDealsForm extends StatefulWidget {
  const AddDealsForm({super.key});

  @override
  State<AddDealsForm> createState() => _AddDealsFormState();
}

class _AddDealsFormState extends State<AddDealsForm> {
  String? selectedClient;
  String? selectedStatus;

  final List<String> clients = ['Techsavy Solutions Ltd.', 'NextGen Tech', 'CodeLab'];
  final List<String> statusList = ['Pending', 'Approved', 'Rejected'];

  @override
  Widget build(BuildContext context) {
    final checkboxController = Get.find<CheckboxController>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          text: 'Client Name',
          fontSize: 16.sp,
          color: Colors.white.withOpacity(0.82),
          fontWeight: FontWeight.w500,
        ),
        SizedBox(height: 8.h),
        SizedBox(
          height: 45.h,
          child: CustomDropdown(
            value: selectedClient,
            hint: 'Techsavy Solutions Ltd.',
            items: clients,
            borderColor: Colors.white.withOpacity(0.80),
            focusedBorderColor: Colors.white.withOpacity(0.09),
            onChanged: (value) {
              setState(() {
                selectedClient = value;
              });
            },
          ),
        ),
        SizedBox(height: 10.h),
        CustomText(
          text: 'Proposition',
          fontSize: 16.sp,
          color: Colors.white.withOpacity(0.82),
        ),
        CustomTextField(
          hintText: "Enter proposition",
          showObscure: false,
          suffix: Padding(
            padding: const EdgeInsets.all(12),
            child: Image.asset(
              AppImages.spCalendar,
              height: 18,
              width: 18,
              color: AppColors.grayBlak,
            ),
          ),
        ),
        CustomText(
          text: 'Deal Amount',
          fontSize: 16.sp,
          color: Colors.white.withOpacity(0.82),
          fontWeight: FontWeight.w500,
        ),
        CustomTextField(
          hintText: "Enter Amount",
          showObscure: false,
          suffix: Padding(
            padding: const EdgeInsets.all(12),
            child: Image.asset(
              AppImages.data,
              height: 14,
              width: 14,
              color: AppColors.grayBlak,
            ),
          ),
        ),
        CustomText(
          text: 'Status',
          fontSize: 14.sp,
          color: Colors.white.withOpacity(0.82),
          fontWeight: FontWeight.w500,
        ),
        SizedBox(height: 8.h),
        SizedBox(
          height: 45.h,
          child: CustomDropdown(
            value: selectedStatus,
            hint: 'Select status',
            items: statusList,
            borderColor: Colors.white.withOpacity(0.80),
            focusedBorderColor: Colors.white.withOpacity(0.09),
            fillColor: const Color(0xFF333333).withOpacity(0.25),
            onChanged: (value) {
              setState(() {
                selectedStatus = value;
              });
            },
          ),
        ),
        SizedBox(height: 16.h),
        CustomFilePicker(),
        CustomText(
          text: 'Notes',
          fontSize: 16.sp,
          color: Colors.white.withOpacity(0.82),
          fontWeight: FontWeight.w500,
        ),
        Gap(10.h),
        CustomTextField(
          maxLines: 5,
          hintText: "Enter notes here.....",
          showObscure: false,
        ),
        Gap(10.h),
        CustomCheckboxWithText(
          text: "Set Reminder",
          isChecked: checkboxController.isChecked,
          activeColor: const Color(0xFF00D1FF),
        ),
        Gap(20.h),
        CustomButton(
          title: 'Save',
          onTap: () {},
          isGradient: false,
          buttonColor: AppColors.orangeColor,
        ),
        Gap(20.h),
      ],
    );
  }
}
