
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import 'package:pet_donation/app/common%20widget/gradient.dart';
import 'package:pet_donation/app/common%20widget/custom%20text/custom_text_widget.dart';
import 'package:pet_donation/app/common%20widget/noitification_item.dart';
import 'package:pet_donation/app/common%20widget/top_bar.dart';

import '../../../common widget/custom_app_bar_widget.dart';

class NotificationView extends StatefulWidget {
  const NotificationView({super.key});

  @override
  State<NotificationView> createState() => _NotificationViewState();
}

class _NotificationViewState extends State<NotificationView> {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
      appBar: const CommonAppBar(
        title: 'Notifications',
      ),
      body:


          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 110),
            child:
            Column(
              children: [
                NotificationItem(
                  isHighlighted: false,
                  title: "New Sale Logged!",
                  message: "Great job, Alex! You’ve just logged a new",
                  message1: "sale worth \$2,000. Keep it up!",
                  time: "10:12 AM",
                  showEmoji: true,
                ),
                NotificationItem(isHighlighted: true,
                  title: "You’re just",
                  message: "You’re just \$1,500 away from your monthly",
                  message1: "target! Let’s hit that goal!",
                  time: "10:12 AM",
                ),
              ],
            )
          ),

    );
  }
}
