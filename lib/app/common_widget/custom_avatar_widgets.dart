import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../uitilies/app_colors.dart';

class CustomAvatar extends StatelessWidget {
  final String imageUrl;
  final double radius;

  const CustomAvatar({
    Key? key,
    required this.imageUrl,
    this.radius = 20, // default radius
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius.r,
      backgroundColor: AppColors.orangeColor,
      backgroundImage: imageUrl.isNotEmpty ? NetworkImage(imageUrl) : null,
      child: imageUrl.isEmpty
          ? Icon(
        Icons.person,
        color: Colors.white,
        size: radius.r,
      )
          : null,
    );
  }
}
