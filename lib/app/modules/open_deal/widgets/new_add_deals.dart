import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';


import '../../../common_widget/custom text/custom_text_widget.dart';
import '../../../common_widget/custom_text_filed.dart';
import '../../../uitilies/app_colors.dart';
import '../../../uitilies/app_images.dart';
import '../../onboarding/widgets/row_button_widgets.dart';
import '../../sales/controllers/deal_closer_create_controller.dart';
import '../../view_details/controllers/check_box_controler.dart';
import '../../view_details/controllers/image_controller.dart';
import '../../view_details/widgets/check_box.dart';
import '../../view_details/widgets/xustom_filePicker.dart';

class NewAddDealsForm extends StatefulWidget {
  const NewAddDealsForm({super.key, required this.clientId, required this.clientName, required this.clientDealCreateId});
  final String clientId;
  final String clientDealCreateId;
  final String clientName;

  @override
  State<NewAddDealsForm> createState() => _NewAddDealsFormState();
}

class _NewAddDealsFormState extends State<NewAddDealsForm> {
  String? selectedImagePath;
  final _formKey = GlobalKey<FormState>();
  final DealController dealController = Get.put(DealController());
  final CheckboxController checkboxController = Get.put(CheckboxController());

  final TextEditingController _propositionController = TextEditingController();
  final TextEditingController _dealDateController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _clienNameController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  final TextEditingController _cashCollectedController = TextEditingController();
  final ImagePickerController imagePickerController = Get.put(ImagePickerController());


  void _submitForm() {
    final formState = _formKey.currentState;
    if (formState != null && formState.validate()) {
      dealController.createDeal(
        proposition: _propositionController.text,
        dealDate: _dealDateController.text,
        amount: int.tryParse(_amountController.text) ?? 0,
        clientId: widget.clientDealCreateId,
        notes: _noteController.text,
        filePath: selectedImagePath ?? '', cashCollected: int.tryParse(_cashCollectedController.text) ?? 0,
      );
    }
  }
  @override
  void initState() {
    super.initState();
    _clienNameController.text = widget.clientName; // auto fill client name
  }
  @override
  Widget build(BuildContext context) {
    return Material( // ✅ FIX: Ensure Material ancestor is present
      color: Colors.transparent,
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              text: 'Client Name',
              fontSize: 16.sp,
              color: Colors.white.withOpacity(0.82),
              fontWeight: FontWeight.w500,
            ),
            SizedBox(height: 8.h),
            CustomTextField(
              hintText: 'Client Name',
              showObscure: false,
              enabled: false,
              controller: _clienNameController,
            ),

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
              controller: _propositionController,
            ),
SizedBox(height: 10.h),
            CustomText(
              text: 'Cash Collected',
              fontSize: 16.sp,
              color: Colors.white.withOpacity(0.82),
            ),
            SizedBox(height: 10.h),
            CustomTextField(
              hintText: "Enter cash collected",
              showObscure: false,
              controller: _cashCollectedController,
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
              controller: _dealDateController,
              hintText: "Enter Date",
              showObscure: false,
              suffix: Padding(
                padding: const EdgeInsets.all(12),
                child: GestureDetector(
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100),
                    );

                    if (pickedDate != null) {
                      String formattedDate = "${pickedDate.day.toString().padLeft(2, '0')}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.year}";
                      setState(() {
                        _dealDateController.text = formattedDate;
                      });
                    }
                  },
                  child: Image.asset(
                    AppImages.spCalendar,
                    height: 18,
                    width: 18,
                    color: AppColors.grayBlak,
                  ),
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
              controller: _amountController,
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

            SizedBox(height: 16.h),
            CustomFilePicker(
              onFilePickedPath: (path) {
                selectedImagePath = path;
                print('Picked path: $selectedImagePath');
              },
            ),

            SizedBox(height: 16.h),
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
              controller: _noteController,
            ),

            // Gap(10.h),
            // CustomCheckboxWithText(
            //   text: "Set Reminder",
            //   isChecked: checkboxController.isChecked,
            //   activeColor: const Color(0xFF00D1FF),
            // ),

            Gap(20.h),
            Obx(() {
              return RowButtonWidgets(
                onTapCancel: (){
                  Get.back();
                },
                isLoading2: dealController.isLoading.value,
                onTapSave: _submitForm,
              );
            }),
            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }
}
