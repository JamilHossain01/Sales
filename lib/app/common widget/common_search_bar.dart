import 'package:flutter/material.dart';

import '../uitilies/app_colors.dart';

class CommonSearchbar extends StatelessWidget {
  const CommonSearchbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      color: Colors.transparent,
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Search items...',
          hintStyle: TextStyle(
            fontSize: 12,
            fontStyle: FontStyle.italic,
            color: AppColors.textGray,
          ),
          prefixIcon: Icon(
            Icons.search,
            color: AppColors.borderColor,
          ),
          filled: true,
          fillColor: Colors.transparent,
          contentPadding: const EdgeInsets.symmetric(vertical: 12.0),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide(
              color: AppColors.borderColor,
              width: 1,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide(
              color: AppColors.borderColor,
              width: 1.5,
            ),
          ),
        ),
      ),
    );
  }
}
