import 'package:flutter/material.dart';

import '../../../common widget/custom text/custom_text_widget.dart';
import '../../../uitilies/app_colors.dart';


class IncludedServiceTile extends StatelessWidget {
  final String text;
  const IncludedServiceTile({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 6),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.mainColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Icon(Icons.radio_button_checked, color: AppColors.mainColor),
          SizedBox(width: 10),
          Expanded(
            child: CustomText(
             text: text,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
