import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import 'package:pet_donation/app/common%20widget/custom_button.dart';
import 'package:pet_donation/app/common%20widget/custom_text_filed.dart';
import 'package:pet_donation/app/common%20widget/gradient.dart';
import 'package:pet_donation/app/common%20widget/custom%20text/custom_text_widget.dart';
import 'package:pet_donation/app/common%20widget/noitification_item.dart';
import 'package:pet_donation/app/common%20widget/show_alert_dialog.dart';
import 'package:pet_donation/app/modules/profile/controllers/porfile_image_controller.dart';
import 'package:pet_donation/app/modules/profile/controllers/profile_controller.dart';
import 'package:pet_donation/app/modules/profile/views/chnage_password.dart';
import 'package:pet_donation/app/uitilies/app_colors.dart';
import 'package:pet_donation/app/uitilies/app_images.dart';

import '../../../common widget/custom_app_bar_widget.dart';
import '../../../common widget/custom_dropdown_controller.dart';
import '../../../common widget/menue_item.dart';
import '../widgets/about_section_widgets.dart';

class PrivacyPolicyView extends StatefulWidget {
  const PrivacyPolicyView({super.key});

  @override
  State<PrivacyPolicyView> createState() => _PrivacyPolicyViewState();
}

class _PrivacyPolicyViewState extends State<PrivacyPolicyView> {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      appBar: const CommonAppBar(
        title: 'Privacy Policy',
      ),
      body: Stack(
        children: [
          // Top gradient fading softly to white
          GradientContainer(
            height: screenHeight * 0.2,
            width: double.infinity,
          ),

          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: screenHeight * 0.1),
                AboutUsSection(
                  title: 'Privacy Policy',
                  content: '''
Lorem ipsum dolor sit amet consectetur. Ultrices id feugiat venenatis habitant mattis viverra elementum purus volutpat. Lacus eu molestie pulvinar rhoncus integer proin elementum. Pretium sit fringilla massa tristique aenean commodo leo. Aliquet viverra amet sit porta elementum et pellentesque posuere. Ullamcorper viverra tortor lobortis viverra auctor egestas. Nulla condimentum ac metus quam turpis gravida ut velit. Porta justo lacus consequat sed platea. Ut dui massa quam elit faucibus consectetur sapien aenean auctor. Felis ipsum amet justo in. Netus amet in egestas sed auctor lorem.
''',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
