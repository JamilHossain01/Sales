import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:pet_donation/app/common%20widget/custom%20text/custom_text_widget.dart';
import 'package:pet_donation/app/common%20widget/custom_button.dart';
import 'package:pet_donation/app/common%20widget/custom_dropdown_controller.dart';
import 'package:pet_donation/app/modules/explore/widgets/pety_filter_widgets.dart';
import 'package:pet_donation/app/uitilies/app_colors.dart';
import 'package:pet_donation/app/common%20widget/custom_app_bar_widget.dart';
import 'package:pet_donation/app/common%20widget/gradient.dart';

import '../../explore/widgets/petFilter2.dart';

class FilterView2 extends StatefulWidget {
  const FilterView2({super.key});

  @override
  State<FilterView2> createState() => _FilterView2State();
}

class _FilterView2State extends State<FilterView2> {
  String selectedPetType = 'Both';
  String? selectedBreed;
  String? selectedLocation;

  final List<String> breedItems = [
    'Labrador',
    'German Shepherd',
    'Golden Retriever',
    'Bulldog',
  ];

  final List<String> locationItems = [
    'New York',
    'Los Angeles',
    'Chicago',
    'Houston',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      appBar: CommonAppBar(title: 'Explore'),
      body: Stack(
        children: [
          GradientContainer(
            height: MediaQuery.of(context).size.height * 0.2,
            width: double.infinity,
          ),
          Padding(
            padding: EdgeInsets.all(16.0.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.1),

                PetTypeSelectors(
                  text1: 'Puppy',
                  text2: 'Young',
                  text3: 'Adult',
                  mainText: 'Pet Type',
                  text4: 'Senior',
                ),
                Gap(20.h),
                CustomText(
                  text: 'Location',
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                  fontSize: 16.sp,
                ),
                SizedBox(height: 8.h),
                SizedBox(
                  width: double.infinity,
                  height: 45.h,
                  child: CustomDropdown(
                    focusedBorderColor: Colors.transparent,
                    borderColor: Colors.transparent,
                    value: selectedLocation,
                    hint: 'Select Location',
                    items: locationItems,
                    onChanged: (value) {
                      setState(() {
                        selectedLocation = value;
                      });
                    },
                  ),
                ),
                Gap(50.h),

                Row(
                  children: [
                    Expanded(child: CustomButton( isGradient: false,titleColor: AppColors.mainColor, border: Border.all(color: AppColors.mainColor),

                        title: 'Reset All', onTap:(){})),
                    Gap(20.w),
                    Expanded(child: CustomButton(title: 'Search', onTap:(){})),

                  ],
                )

              ],
            ),
          ),
        ],
      ),
    );
  }
}
