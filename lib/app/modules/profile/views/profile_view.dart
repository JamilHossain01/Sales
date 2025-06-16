import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import 'package:pet_donation/app/common%20widget/gradient.dart';
import 'package:pet_donation/app/modules/profile/controllers/porfile_image_controller.dart';
import 'package:pet_donation/app/modules/profile/controllers/profile_controller.dart';
import 'package:pet_donation/app/modules/profile/views/about_us.dart';
import 'package:pet_donation/app/modules/profile/views/edite_profile.dart';
import 'package:pet_donation/app/modules/profile/views/notification_view.dart';
import 'package:pet_donation/app/modules/profile/views/privacy_policy.dart';
import 'package:pet_donation/app/modules/profile/views/setting.dart';
import 'package:pet_donation/app/modules/profile/views/terms_of_use_view.dart';
import 'package:pet_donation/app/uitilies/app_images.dart';

import '../../../common widget/custom_app_bar_widget.dart';
import '../../../common widget/show_alert_dialog.dart';
import '../../dashboard/views/dashboard_view.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final ProfileImageController _imageController = Get.put(ProfileImageController());

    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      appBar:  CommonAppBar(
        title: 'Profile',
        onBackPressed: () => Get.to(DashboardView()), // Correct back behavior


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
              children: [
                SizedBox(height: screenHeight * 0.1),
                Obx(() {
                  return Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundImage: _imageController.selectedImagePath.value.isEmpty
                            ? const AssetImage(AppImages.profile)
                            : FileImage(File(_imageController.selectedImagePath.value)) as ImageProvider,
                      ),
                      GestureDetector(
                        onTap: () async {
                          final source = await showModalBottomSheet<ImageSource>(
                            context: context,
                            builder: (_) => SafeArea(
                              child: Wrap(
                                children: [
                                  ListTile(
                                    leading: const Icon(Icons.camera_alt),
                                    title: const Text('Camera'),
                                    onTap: () => Navigator.pop(context, ImageSource.camera),
                                  ),
                                  ListTile(
                                    leading: const Icon(Icons.photo_library),
                                    title: const Text('Gallery'),
                                    onTap: () => Navigator.pop(context, ImageSource.gallery),
                                  ),
                                ],
                              ),
                            ),
                          );
                          if (source != null) {
                            await _imageController.pickImage(source);
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.tealAccent,
                            border: Border.all(color: Colors.white, width: 2),
                          ),
                          child: const Icon(Icons.camera_alt, color: Colors.black),
                        ),
                      ),
                    ],
                  );
                }),

                const SizedBox(height: 10),

                const Text(
                  'Mantas Kuneika',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),


                Expanded(
                  child: ListView(
                    children: [
                      _buildMenuItem(Icons.person_outline, 'Edit Profile', () {
                        Get.to(EditeProfileView());
                      }),
                      _buildMenuItem(Icons.settings_outlined, 'Settings', () {
                        Get.to(SettingView());
                      }),
                      _buildMenuItem(Icons.info_outline, 'About Us', () {
                        Get.to(AboutUSView());

                      }),
                      _buildMenuItem(Icons.shield_outlined, 'Privacy Policy', () {
                        Get.to(PrivacyPolicyView ());

                      }),
                      _buildMenuItem(Icons.rule, 'Terms of Services', () {
                        Get.to(TermsOfUseView ());

                      }),

                      _buildMenuItem(Icons.logout, 'Sign Out', () {
                        showDialog(

                          context:context,
                          barrierDismissible: false,
                          builder: (_) => SignOutDialog(
                            title: 'Do you want to sign out your profile?',
                            onConfirm: () {
                              // Sign out logic here
                            },
                            onCancel: () {
                              // Optional cancel logic
                            },
                          ),
                        );


                      }, textColor: Colors.red),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem(IconData icon, String title, VoidCallback onTap, {Color? textColor}) {
    return ListTile(
      leading: Icon(icon, color: textColor ?? Color(0xFF666666)),
      title: Text(
        title,
        style: TextStyle(color: textColor ??  Color(0xFF484848), fontWeight: FontWeight.w500),
      ),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: onTap,
    );
  }
}
