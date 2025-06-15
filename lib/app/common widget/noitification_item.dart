import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pet_donation/app/common%20widget/custom%20text/custom_text_widget.dart';
import 'package:pet_donation/app/uitilies/app_images.dart';

class NotificationItem extends StatelessWidget {
  final String title;
  final String message;
  final String message1;
  final String time;
  final VoidCallback? onTap;

  const NotificationItem({
    super.key,
    required this.title,
    required this.message,
    required this.time,
    this.onTap, required this.message1,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 36.w,
                height: 36.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.grey.shade200,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset(AppImages.messages),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    CustomText(
                      textAlign: TextAlign.start,
                      text: message,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      color: Colors.black87,
                    ),
                    SizedBox(width: 8.w),
                    CustomText(
                      text: time,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey,
                    ),
                  ],
                ),
              ),


            ],
          ),

        ],
      ),
    );
  }
}
