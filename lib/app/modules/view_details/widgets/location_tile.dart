import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pet_donation/app/common%20widget/custom%20text/custom_text_widget.dart';

class LocationTile extends StatelessWidget {
  final String? label;
  final String? value;
  final Widget? child; // <-- Now accepts any widget!

  const LocationTile({
    super.key,
    this.label,
    this.value,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1A),
        border: Border(
          top: BorderSide(color: Colors.white.withOpacity(0.1), width: 1),
          bottom: BorderSide(color: Colors.white.withOpacity(0.1), width: 1),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (label != null || value != null)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                  text: label ?? '',
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.white.withOpacity(0.82),
                ),
                CustomText(
                  text: value ?? '',
                  maxLines: 2,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w300,
                  color: Colors.white.withOpacity(0.6),
                ),
              ],
            ),
          if (child != null) ...[
            SizedBox(height: 6.h),
            child!,
          ],
        ],
      ),
    );
  }
}
