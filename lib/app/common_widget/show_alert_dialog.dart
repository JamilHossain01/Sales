import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:wolf_pack/app/modules/sign_in/views/sign_in_view.dart';
import 'package:wolf_pack/app/uitilies/api/local_storage.dart';
import 'custom text/custom_text_widget.dart';
import 'package:wolf_pack/app/uitilies/app_colors.dart';

import 'custom_button.dart';

class SignOutDialog extends StatelessWidget {
  final VoidCallback onConfirm;
  final VoidCallback? onCancel;
  final String title;

   SignOutDialog({
    super.key,
    required this.onConfirm,
    this.onCancel,
    this.title = 'Do you want to sign out your profile?',
  });

  final storage = Get.put(StorageService());

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.r),
        side: BorderSide(color: AppColors.orangeColor, width: 1.5),
      ),
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: AppColors.orangeColor, width: 1.5),
          color: Colors.white,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Gap(1.h),
            CustomText(
              text: title,
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              color: Colors.black,
              textAlign: TextAlign.center,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
              child: Row(
                children: [
                  Expanded(
                    child: CustomButton(
                      isGradient: false,
                      buttonColor: AppColors.white,
                      border: Border.all(color: AppColors.textGray),
                      title: 'No',
                      fontWeight: FontWeight.w500,
                      fontSize: 12.sp,
                      titleColor:Colors.black,
                      onTap: () {
                        Navigator.of(context).pop();
                        if (onCancel != null) onCancel!();
                      },
                    ),
                  ),
                  Gap(20.w),
                  Expanded(
                    child: CustomButton(
                      isGradient: false,
                      buttonColor: AppColors.orangeColor,

                      fontWeight: FontWeight.w500,
                      fontSize: 12.sp,
                      title: 'Yes',
                      onTap: () async {

                        await storage.clear();




                        Get.offAll(()=> SignInView());

                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
