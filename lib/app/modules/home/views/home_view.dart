import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pet_donation/app/common%20widget/custom_button.dart';
import 'package:pet_donation/app/common%20widget/custom_tab_bar_view.dart';
import 'package:pet_donation/app/common%20widget/gradient.dart';
import 'package:pet_donation/app/modules/home/widgets/carosele_slider.dart';
import 'package:pet_donation/app/routes/app_pages.dart';
import 'package:pet_donation/app/uitilies/app_images.dart';

import '../../../common widget/custom text/custom_text_widget.dart';
import '../../../common widget/custom_header_widgets.dart';
import '../../../uitilies/app_colors.dart';
import '../controllers/home_controller.dart';
import '../widgets/trending_servoces.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final tabs = ['All', 'Cats', 'Dogs'];

    final data = {
      'All': ['Becon (Dog)', 'Mini (Cat)', 'Charlie (Dog)'],
      'Cats': ['Mini (Cat)'],
      'Dogs': ['Becon (Dog)', 'Charlie (Dog)'],
    };

    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      body:
      Stack(
        children: [
          GradientContainer(
            height: screenHeight * 0.2,
            width: double.infinity,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                SizedBox(height: screenHeight * 0.1),
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      child: Image.asset(
                        AppImages.profile,
                        height: 40.h,
                        width: 40,
                      ),
                    ),
                    Row(
                      children: [
                        SizedBox(
                          child: Image.asset(
                            AppImages.pin,
                            height: 15.h,
                            width: 13,
                          ),
                        ),
                        Gap(4.w),

                        CustomText(
                          text: 'Enable Location',
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                          fontSize: 20.sp,
                        ),
                        Gap(4.w),
                        SizedBox(
                          child: Image.asset(
                            AppImages.arrow,
                            height: 15.h,
                            width: 13,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      height: 40.h,
                      width: 40.w,                      decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(50.r),

                    ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset(
                          AppImages.bell,
                          height: 24.h,
                          width: 24.w,
                        ),
                      ),
                    ),
                  ],
                ),

                // ... আপনার header কোড এখানে (Row, Images, Text etc.) ...
                BannerCarousel(),
                SizedBox(height: 10),
                HeaderWidgets(title: 'Services', subTitle: 'See All'),
                SizedBox(height: 10),
                TrendingProvidersSection(),
                SizedBox(height: 10),
                HeaderWidgets(title: 'Categories', subTitle: 'See More'),
                SizedBox(height: 10),

                Expanded(   // <-- Expanded দিয়ে দিতে হবে
                  child: CustomTabView(
                    tabs: tabs,
                    data: data,
                  ),
                ),
              ],
            ),
          ),

        ],
      ),
    );
  }
}


