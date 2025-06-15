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

import '../widgets/petFilter2.dart';

class FilterView extends StatefulWidget {
  const FilterView({super.key});

  @override
  State<FilterView> createState() => _FilterViewState();
}

class _FilterViewState extends State<FilterView> {
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
                PetTypeSelector(
                  text1: 'Both',
                  text2: 'Cat',
                  text3: 'Dog',
                  mainText: 'Pet Type',
                ),
                Gap(20.h),
                CustomText(
                  text: 'Breed',
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                  fontSize: 16.sp,
                ),
                Gap(10.h),
                SizedBox(
                  width: double.infinity,
                  height: 45.h,
                  child: CustomDropdown(
                    focusedBorderColor: Colors.transparent,
                    borderColor: Colors.transparent,
                    value: selectedBreed,
                    hint: 'Select Breed',
                    items: breedItems,
                    onChanged: (value) {
                      setState(() {
                        selectedBreed = value;
                      });
                    },
                  ),
                ),
                Gap(20.h),
                PetTypeSelector(
                  text1: 'Both',
                  text2: 'Male',
                  text3: 'Female',
                  mainText: 'Gender',
                ),
                Gap(20.h),
                PetTypeSelectors(
                  text1: 'Puppy',
                  text2: 'Young',
                  text3: 'Adult',
                  mainText: 'Maximum Distance',
                  text4: 'Senior',
                ),
                Gap(20.h),
                CustomText(
                  text: 'Location',
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                  fontSize: 16.sp,
                ),
                SizedBox(
                  width: double.infinity,
                  height: 45.h,
                  child: CustomDropdown(
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
                Gap(20.h),
                PetTypeSelectors(
                  text1: '500m',
                  text2: '1KM',
                  text3: '2KM',
                  mainText: 'Maximum Distance',
                  text4: '3KM',
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 32),
                  child: Row(
                    children: [
                      Expanded(
                          child: CustomButton(
                              isGradient: false,
                              border: Border.all(color: AppColors.mainColor),
                              title: 'Reset All',
                              fontWeight: FontWeight.w500,
                              fontSize: 12.sp,
                              titleColor: AppColors.mainColor,
                              onTap: () {})),
                      Gap(20.w),
                      Expanded(
                          child: CustomButton(
                              fontWeight: FontWeight.w500,
                              fontSize: 12.sp,
                              title: 'Search',
                              onTap: () {}))
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
