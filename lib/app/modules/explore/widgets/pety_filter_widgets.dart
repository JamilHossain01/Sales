import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pet_donation/app/uitilies/app_colors.dart';

import '../../../common widget/custom text/custom_text_widget.dart';

class PetTypeSelector extends StatefulWidget {
  final String initialSelection;
  final String text1;
  final String text2;
  final String text3;
  final String mainText;
  final ValueChanged<String>? onSelectionChanged;

  const PetTypeSelector({
    super.key,
    this.initialSelection = 'Both',
    this.onSelectionChanged,
    required this.text1,
    required this.text2,
    required this.text3, required this.mainText,
  });

  @override
  State<PetTypeSelector> createState() => _PetTypeSelectorState();
}

class _PetTypeSelectorState extends State<PetTypeSelector> {
  late String selectedPetType;

  @override
  void initState() {
    super.initState();
    selectedPetType = widget.initialSelection;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          text: widget.mainText,
          fontWeight: FontWeight.w500,
          color: Colors.black,
          fontSize: 16.sp,
        ),
        SizedBox(height: 8.h),
        Container(
          decoration: BoxDecoration(
            color: AppColors.borderColor,
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Row(
            children: [
              _buildPetTypeOption(widget.text1), // Fixed typo 'texct1' to 'widget.text1'
              _buildPetTypeOption(widget.text2),
              _buildPetTypeOption(widget.text3),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPetTypeOption(String type) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            selectedPetType = type;
          });
          widget.onSelectionChanged?.call(type);
        },
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 12.h),
          decoration: BoxDecoration(
            color: selectedPetType == type ? Colors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Center(
            child: CustomText(
              text: type,
              fontWeight: FontWeight.w500,
              color: selectedPetType == type
                  ? Colors.black
                  : Colors.black.withOpacity(0.6),
              fontSize: 16.sp,
            ),
          ),
        ),
      ),
    );
  }
}