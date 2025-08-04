import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pet_donation/app/common%20widget/custom%20text/custom_text_widget.dart';
import 'package:pet_donation/app/common%20widget/html_view.dart';

class AboutUsSection extends StatelessWidget {
  final String title;
  final String content;

  const AboutUsSection({
    super.key,
    this.title = 'About Us',
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return HTMLView(htmlData: content);
  }
}
