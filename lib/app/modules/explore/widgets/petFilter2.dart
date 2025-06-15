import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pet_donation/app/uitilies/app_colors.dart';

import '../../../common widget/custom text/custom_text_widget.dart';

class PetTypeSelectors extends StatefulWidget {
  final String initialSelection;
  final String text1;
  final String text2;
  final String text3;
  final String text4;
  final String mainText;
  final ValueChanged<String>? onSelectionChanged;

  const PetTypeSelectors({
    super.key,
    this.initialSelection = 'Both',
    this.onSelectionChanged,
    required this.text1,
    required this.text2,
    required this.text3,
    required this.mainText,
    required this.text4,
  });

  @override
  State<PetTypeSelectors> createState() => _PetTypeSelectorsState();
}

class _PetTypeSelectorsState extends State<PetTypeSelectors> {
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
            color: Color(0XFFF5F6F7),
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Padding(
            padding: const EdgeInsets.only(
              left: 4,
              top: 4,
              bottom: 4,
            ),
            child: Row(
              children: [
                _buildPetTypeOption(widget.text1),
                _buildPetTypeOption(widget.text2),
                _buildPetTypeOption(widget.text3),
                _buildPetTypeOption(widget.text4),
              ],
            ),
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
          padding: EdgeInsets.symmetric(vertical: 6.h),
          decoration: BoxDecoration(
            color: selectedPetType == type ? Colors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Center(
            child: CustomText(
              text: type,
              fontWeight: FontWeight.w500,
              color: selectedPetType == type
                  ? AppColors.mainColor
                  : Colors.black.withOpacity(0.6),
              fontSize: 16.sp,
            ),
          ),
        ),
      ),
    );
  }
}
