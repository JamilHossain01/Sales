import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:pet_donation/app/common%20widget/custom_dropdown_controller.dart';
import 'package:pet_donation/app/modules/explore/widgets/pety_filter_widgets.dart';
import 'package:pet_donation/app/uitilies/app_colors.dart';

import '../../../common widget/custom text/custom_text_widget.dart';
import '../../../common widget/custom_app_bar_widget.dart';
import '../../../common widget/gradient.dart';

class FilterView extends StatefulWidget {
  const FilterView({super.key});

  @override
  State<FilterView> createState() => _FilterViewState();
}

class _FilterViewState extends State<FilterView> {
  String selectedPetType = 'Both'; // Default selected option
  String selectedValue = 'Option 1'; // Initial selected value
  final List<String> dropdownItems = ['Option 1', 'Option 2', 'Option 3'];
  void onDropdownChanged(String? newValue) {
    if (newValue != null) {
      setState(() {
        selectedValue = newValue;
      });
      print('Selected value: $selectedValue'); // Example action on change
    }
  }
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      appBar: CommonAppBar(
        title: 'Explore',
      ),
      body: Stack(
        children: [
          // Top gradient fading softly to white
          GradientContainer(
            height: screenHeight * 0.2,
            width: double.infinity,
          ),
          // UI elements over the gradient
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: screenHeight * 0.1),
               PetTypeSelector(text1: 'Both', text2: 'Cat', text3: 'Dog', mainText: 'Pet Type',),
               Gap(10.h),
               PetTypeSelector(text1: 'Both', text2: 'Cat', text3: 'Dog', mainText: 'Gender',),
                Gap(10.h),
                SizedBox(
                  width: double.infinity,
                  child: CustomDropdown(
                    initialValue: selectedValue, // Initial value
                    items: dropdownItems, // List of items
                    onChanged: onDropdownChanged, // Callback for value changes
                  ),
                ),
                PetTypeSelector(text1: 'Both', text2: 'Cat', text3: 'Dog', mainText: 'Age',),
                Gap(10.h),

                PetTypeSelector(text1: 'Both', text2: 'Cat', text3: 'Dog', mainText: 'Maximum Distance',),
              ],
            ),
          ),
        ],
      ),
    );
  }
}