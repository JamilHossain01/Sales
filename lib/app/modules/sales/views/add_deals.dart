import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:wolf_pack/app/modules/open_deal/widgets/new_add_deals.dart';
import 'package:wolf_pack/app/uitilies/custom_loader.dart';
import '../../../common_widget/custom text/custom_text_widget.dart';
import '../../../common_widget/custom_app_bar_widget.dart';
import '../../../common_widget/custom_button.dart';
import '../../../uitilies/app_colors.dart';
import '../../home/controllers/ny_clients_controller.dart';
import '../../view_details/controllers/check_box_controler.dart';
import '../../view_details/controllers/image_controller.dart';
import '../../open_deal/controllers/open_deal_controller.dart';

import 'package:gap/gap.dart';
import '../../../common_widget/custom_text_filed.dart';
import '../../../uitilies/app_images.dart';
import '../../onboarding/widgets/row_button_widgets.dart';
import '../../sales/controllers/deal_closer_create_controller.dart';
import '../../view_details/widgets/check_box.dart';
import '../../view_details/widgets/xustom_filePicker.dart';

class AddDealView extends StatefulWidget {
  const AddDealView({super.key, this.clientId, this.clientName});

  final String? clientId;
  final String? clientName;

  @override
  State<AddDealView> createState() => _AddDealViewState();
}

class _AddDealViewState extends State<AddDealView> {
  String? selectedImagePath;
  String? selectedClientId;

  final _formKey = GlobalKey<FormState>();
  final DealController dealController = Get.put(DealController());
  final CheckboxController checkboxController = Get.put(CheckboxController());
  final ImagePickerController imagePickerController = Get.put(ImagePickerController());

  late final MyAllClientsGetController clientsController;

  final TextEditingController _propositionController = TextEditingController();
  final TextEditingController _dealDateController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  final TextEditingController _cashCollectedController = TextEditingController();

  @override
  void initState() {
    super.initState();

    // Reuse existing controller if already created (e.g., from AllClientsScreen), otherwise create new
    clientsController = Get.isRegistered<MyAllClientsGetController>()
        ? Get.find<MyAllClientsGetController>()
        : Get.put(MyAllClientsGetController());

    // Pre-select client if passed in
    selectedClientId = widget.clientId;
  }

  void _submitForm() {
    if (_formKey.currentState!.validate() && selectedClientId != null) {
      dealController.createDeal(
        proposition: _propositionController.text,
        dealDate: _dealDateController.text,
        amount: int.tryParse(_amountController.text) ?? 0,
        clientId: selectedClientId!,
        notes: _noteController.text,
        filePath: selectedImagePath ?? '',
        cashCollected: int.tryParse(_cashCollectedController.text) ?? 0,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF000000),
      appBar: CommonAppBar(title: 'Add New Deal'),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ==================== CLIENT DROPDOWN ====================
              CustomText(
                text: 'Select Client',
                fontSize: 16.sp,
                color: Colors.white.withOpacity(0.82),
                fontWeight: FontWeight.w500,
              ),
              SizedBox(height: 8.h),
              Obx(() {
                if (clientsController.isLoading.value) {
                  return const Center(
                    child: CircularProgressIndicator(color: Colors.white),
                  );
                }

                final clients = clientsController.myAllClientData.value.data?.data ?? [];

                if (clients.isEmpty) {
                  return const Text(
                    'No clients available',
                    style: TextStyle(color: Colors.redAccent),
                  );
                }

                final dropdownItems = clients.where((client) => client.userClients.isNotEmpty).map((client) {
                  final userClientId = client.userClients.first.id.toString();
                  return DropdownMenuItem<String>(
                    value: userClientId,
                    child: Text(client.name ?? 'Unknown Client'),
                  );
                }).toList();

                return DropdownButtonFormField<String>(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select a client';
                    }
                    return null;
                  },
                  value: selectedClientId,
                  hint: const Text('Choose a client', style: TextStyle(color: Colors.grey)),
                  items: dropdownItems,
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedClientId = newValue;
                    });
                  },
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.05),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
                      borderSide: BorderSide.none,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
                      borderSide:  BorderSide(color: AppColors.orangeColor),
                    ),
                    hintStyle: const TextStyle(color: Colors.grey),
                  ),
                  dropdownColor: const Color(0xFF1E1E1E),
                  style: const TextStyle(color: Colors.white),
                  icon: const Icon(Icons.arrow_drop_down, color: Colors.white),
                );
              }),
              SizedBox(height: 20.h),

              // ==================== PROPOSITION ====================
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

              // ==================== DEAL DATE ====================
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
                        String formattedDate =
                            "${pickedDate.day.toString().padLeft(2, '0')}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.year}";
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

              // ==================== DEAL AMOUNT ====================
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

              // ==================== CASH COLLECTED ====================
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


              // ==================== FILE PICKER ====================
              CustomFilePicker(
                onFilePickedPath: (path) {
                  selectedImagePath = path;
                },
              ),
              SizedBox(height: 16.h),

              // ==================== NOTES ====================
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
              Gap(20.h),

              // ==================== BUTTONS ====================
              Obx(() {
                return RowButtonWidgets(
                  onTapCancel: () {
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
      ),
    );
  }
}