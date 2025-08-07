import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import 'package:wolf_pack/app/common widget/custom text/custom_text_widget.dart';
import 'package:wolf_pack/app/uitilies/app_colors.dart';
import '../../../modules/view_details/controllers/image_controller.dart';

class CustomFilePicker extends StatefulWidget {
  final Function(File?)? onFilePicked;
  final Function(String?)? onFilePickedPath;

  const CustomFilePicker({
    super.key,
    this.onFilePicked,
    this.onFilePickedPath,
  });

  @override
  _CustomFilePickerState createState() => _CustomFilePickerState();
}

class _CustomFilePickerState extends State<CustomFilePicker> {
  File? _selectedFile;
  final ImagePickerController _imagePickerController = Get.find();

  Future<void> _showPickDialog() async {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: const Text('Select Image Source'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Gallery'),
                onTap: () async {
                  Navigator.of(context).pop();
                  await _pickImage(ImageSource.gallery);
                },
              ),
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text('Camera'),
                onTap: () async {
                  Navigator.of(context).pop();
                  await _pickImage(ImageSource.camera);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _selectedFile = File(pickedFile.path);
        _imagePickerController.selectedImagePath.value = pickedFile.path;
      });
      widget.onFilePicked?.call(_selectedFile);
      widget.onFilePickedPath?.call(pickedFile.path);
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
          onTap: _showPickDialog,
          child: Container(
            width: double.infinity,
            height: 45.h,
            decoration: BoxDecoration(
              color: const Color(0xFF333333).withOpacity(0.25),
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
                    border: Border.all(color: const Color(0xFF212529)),
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                  child: CustomText(
                    text: 'Choose file',
                    fontSize: 14.sp,
                    color: const Color(0xFF212529),
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
                    color: const Color(0xFF212529),
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

