import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import 'package:pet_donation/app/common widget/custom text/custom_text_widget.dart';
import 'package:pet_donation/app/uitilies/app_colors.dart';
import '../../../modules/view_details/controllers/image_controller.dart';

class CustomFilePicker extends StatefulWidget {
  final Function(File?)? onFilePicked;

  const CustomFilePicker({super.key, this.onFilePicked});

  @override
  _CustomFilePickerState createState() => _CustomFilePickerState();
}

class _CustomFilePickerState extends State<CustomFilePicker> {
  File? _selectedFile;
  final ImagePickerController _imagePickerController = Get.find();

  Future<void> _pickFile() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _selectedFile = File(pickedFile.path);
        _imagePickerController.selectedImagePath.value = pickedFile.path;
      });
      if (widget.onFilePicked != null) {
        widget.onFilePicked!(_selectedFile);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          text: 'Upload Document',
          fontSize: 16.sp,
          color: Colors.white.withOpacity(0.82),
          fontWeight: FontWeight.w500,
        ),
        SizedBox(height: 8.h),
        GestureDetector(
          onTap: _pickFile,
          child: Container(
            width: double.infinity,
            height: 45.h,
            decoration: BoxDecoration(
              color:Color(0xFF333333).withOpacity(0.25),
              border: Border.all(
                color: Colors.white.withOpacity(0.080),
              ),
              borderRadius: BorderRadius.circular(8.r),
            ),
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
                  decoration: BoxDecoration(
                    border: Border.all(color: Color(0xFF212529),
                  ),
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                  child: CustomText(
                    text: 'Choose file',
                    fontSize: 14.sp,
                    color: Color(0xFF212529),
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(width: 10.w),
                Expanded(
                  child: CustomText(
                    text: _selectedFile == null
                        ? "No file chosen"
                        : _selectedFile!.path.split('/').last,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF212529),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
