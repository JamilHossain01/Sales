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
import '../../onboarding/widgets/row_button_widgets.dart';
import '../../sales/controllers/deal_closer_create_controller.dart';
import '../../view_details/controllers/check_box_controler.dart';

class OpenDealUpdateForm extends StatefulWidget {
  final String clientId;

  const OpenDealUpdateForm({super.key, required this.clientId});

  @override
  State<OpenDealUpdateForm> createState() => _OpenDealUpdateFormState();
}

class _OpenDealUpdateFormState extends State<OpenDealUpdateForm> {
  String? selectedClient;
  String? selectedStatus;
  final DealController creatDealController = Get.put(DealController());
  final TextEditingController nameController = TextEditingController();
  final TextEditingController prepoController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController dealamountController = TextEditingController();
  final TextEditingController noteController = TextEditingController();


  final List<String> clients = [
    'Techsavy Solutions Ltd.',
    'NextGen Tech',
    'CodeLab'
  ];
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
        CustomTextField(hintText: 'Client Name', showObscure: false),

        SizedBox(height: 10.h),
        CustomText(
          text: 'Proposition',
          fontSize: 16.sp,
          color: Colors.white.withOpacity(0.82),
        ),
        SizedBox(height: 10.h),

        CustomTextField(
          hintText: "Enter proposition",
          showObscure: false,
        ),
        SizedBox(height: 10.h),
        CustomText(
          text: 'Deal Date',
          fontSize: 16.sp,
          color: Colors.white.withOpacity(0.82),
          fontWeight: FontWeight.w500,
        ),
        SizedBox(height: 10.h),

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
        SizedBox(height: 10.h),


        CustomText(
          text: 'Deal Amount',
          fontSize: 16.sp,
          color: Colors.white.withOpacity(0.82),
          fontWeight: FontWeight.w500,
        ),
        SizedBox(height: 10.h),

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
        SizedBox(height: 16.h),
        Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
              color: Color(0XFF00D1FF).withOpacity(0.090),
              borderRadius: BorderRadius.circular(8.r)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                text: 'Pricing Breakdown',
                fontSize: 14.sp,
                color: Colors.white.withOpacity(0.82),
                fontWeight: FontWeight.w300,
              ),
              Gap(10.h),
              Row(
                children: [
                  Expanded(
                    child: CustomButton(
                      imagePath: AppImages.export,
                      title: 'Export',
                      onTap: () {},
                      isGradient: false,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                      imageHeight: 15,
                      imageWidth: 15,
                      buttonColor: AppColors.white.withOpacity(0.16),
                    ),
                  ),
                  Gap(10.w),
                  Expanded(
                    child: CustomButton(
                      border: Border.all(color: Colors.red),
                      imagePath: AppImages.deLate,
                      imageHeight: 15,
                      imageWidth: 15,
                      title: 'Delete',
                      titleColor: Colors.red,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                      onTap: () {},
                      isGradient: false,
                      buttonColor: Colors.transparent,
                    ),
                  )
                ],
              )
            ],
          ),
        ),
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
        RowButtonWidgets(),
        SizedBox(height: 20.h),

      ],
    );
  }
}

