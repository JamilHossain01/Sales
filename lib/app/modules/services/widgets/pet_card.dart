import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common widget/custom text/custom_text_widget.dart';
import '../../../uitilies/app_colors.dart';

class Pet24Card extends StatelessWidget {
  final String? title;
  final List<String>? icons; // Changed to List<String> for asset paths
  final String? logoImage; // New parameter for logo image asset
  final String? description;
  final Color? backgroundColor;
  final Color? titleColor;
  final Color? descriptionColor;
  final EdgeInsets? padding;
  final double? borderRadius;
  final double? elevation;

  const Pet24Card({
    Key? key,
    this.title,
    this.icons,
    this.logoImage,
    this.description,
    this.backgroundColor,
    this.titleColor,
    this.descriptionColor,
    this.padding,
    this.borderRadius,
    this.elevation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: backgroundColor ?? Colors.white,
      elevation: elevation ?? 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius ?? 8.0),
      ),
      margin: EdgeInsets.zero,
      child: Column(
        children: [
          Container(
            height: 2.h,
            decoration: BoxDecoration(
              color: AppColors.mainColor,
              borderRadius: BorderRadius.only(topLeft: Radius.circular(8.r),
                  topRight: Radius.circular(8.r)),
            ),
          ),
          Container(
            padding: padding ??
                const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(borderRadius ?? 8.0),

            ),
            child: Column(
              children: [

                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Left section with title, icons, and description
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (title != null)
                            CustomText(
                              text: title!,
                              fontWeight: FontWeight.w500,
                              fontSize: 16.sp,
                              color: titleColor ?? Colors.black,
                            ),
                          if (icons != null && icons!.isNotEmpty)
                            Row(
                              children: icons!.map((iconPath) => Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: Image.asset(
                                  iconPath,
                                  width: 24.0,
                                  height: 24.0,
                                  fit: BoxFit.contain,
                                ),
                              )).toList(),
                            ),
                          if (description != null)
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: CustomText(
                                text: description!,
                                fontWeight: FontWeight.w400,
                                fontSize: 10.sp,
                                textAlign: TextAlign.start,
                                color: descriptionColor ?? Color(0XFF1A1A1A),
                              ),
                            ),
                        ],
                      ),
                    ),
                    // Right section with logo image
                    if (logoImage != null)
                      Padding(
                        padding: const EdgeInsets.only(left: 16.0),
                        child: Image.asset(
                          logoImage!,
                          width: 140.0, // Adjust width as needed
                          height: 100.0, // Adjust height as needed
                          fit: BoxFit.contain,
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}