import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:wolf_pack/app/uitilies/app_colors.dart';

import '../../../common_widget/custom_button.dart';

class RowButtonWidgets extends StatelessWidget {
  const RowButtonWidgets({
    super.key,
    this.onTapCancel,
    this.onTapSave,
    this.buttonName1,
    this.buttonName2,
    this.isLoading1 = false,
    this.isLoading2 = false,
  });

  final VoidCallback? onTapCancel;
  final VoidCallback? onTapSave;
  final String? buttonName1;
  final String? buttonName2;
  final bool isLoading1;
  final bool isLoading2;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: CustomButton(
            isLoading: isLoading1,
            title: buttonName1 ?? 'Back',
            onTap: onTapCancel ?? () {},
            isGradient: false,
            buttonColor: AppColors.white.withOpacity(0.090),
            leftIcon: Icon(Icons.arrow_back, color: AppColors.white),
          ),
        ),
        Gap(10.w),
        Expanded(
          child: CustomButton(
            isLoading: isLoading2,
            title: buttonName2 ?? 'Add Deal',
            onTap: onTapSave ?? () {},
            isGradient: false,
            buttonColor: AppColors.orangeColor,
            rightIcon: Icon(Icons.arrow_forward, color: AppColors.white),
          ),
        )
      ],
    );
  }
}
