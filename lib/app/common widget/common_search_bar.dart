import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../uitilies/app_colors.dart';

class CommonSearchbar extends StatelessWidget {
  const CommonSearchbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60.h,
      padding: const EdgeInsets.all(8.0),
      color: Colors.transparent,
      child:
      TextField(
        decoration: InputDecoration(
          hintText: 'Search items...',
          hintStyle: TextStyle(
            fontSize: 12,
            color: AppColors.orangeColor,
          ),
          prefixIcon: Icon(
            Icons.search,
            color: AppColors.orangeColor,
          ),
          filled: true,
          fillColor: Colors.transparent,
          contentPadding: const EdgeInsets.symmetric(vertical: 9.0),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide(
              color: AppColors.orangeColor,
              width: 1,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide(
              color: AppColors.orangeColor,
              width: 1.5,
            ),
          ),
        ),
      ),
    );
  }
}
