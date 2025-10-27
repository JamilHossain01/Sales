import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gap/gap.dart'; // make sure this package is added
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'custom text/custom_text_widget.dart';
import 'custom_button.dart';

// Your custom widgets import placeholders:
// import 'path_to_custom_button.dart';
// import 'path_to_custom_text.dart';
// import 'path_to_app_images.dart';

class CustomBottomSheet extends StatelessWidget {
  final double height;
  final String title;
  final String subtitle1;
  final String subtitle2;
  final VoidCallback onDone;
  final String imageAsset;

  const CustomBottomSheet({
    Key? key,
    required this.height,
    required this.title,
    required this.subtitle1,
    required this.subtitle2,
    required this.onDone,
    required this.imageAsset,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 16),
            Container(
              width: 40,
              height: 5,
              margin: const EdgeInsets.only(bottom: 20),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            Container(
              width: 50,
              height: 50,
              margin: const EdgeInsets.only(bottom: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFF19A2A5), // start color
                    Color(0xFF8AD8C0), // end color
                  ],
                  begin: Alignment.topRight,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Image.asset(imageAsset),
              ),
            ),
            CustomText(
              text: title,
              fontSize: 24.sp,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
            CustomText(
              text: subtitle1,
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
              color: const Color(0XFF969696),
            ),
            CustomText(
              text: subtitle2,
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
              color: const Color(0XFF969696),
            ),
            Gap(30.h),
            CustomButton(
              title: 'Done',
              onTap: onDone,
            ),
          ],
        ),
      ),
    );
  }
}

// Helper function to show this BottomSheet anywhere
void showCustomBottomSheet({
  required BuildContext context,
  double height = 300,
  required String title,
  required String subtitle1,
  required String subtitle2,
  required VoidCallback onDone,
  required String imageAsset,
}) {
  showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    backgroundColor: Colors.white,
    isScrollControlled: true,
    builder: (context) {
      return Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: CustomBottomSheet(
          height: height,
          title: title,
          subtitle1: subtitle1,
          subtitle2: subtitle2,
          onDone: onDone,
          imageAsset: imageAsset,
        ),
      );
    },
  );
}
