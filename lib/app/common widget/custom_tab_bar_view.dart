import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pet_donation/app/modules/home/widgets/pet_card.dart';
import 'package:pet_donation/app/uitilies/app_images.dart';
import 'package:pet_donation/app/common widget/custom text/custom_text_widget.dart'; // Update path as needed

class AdoptionTabView extends StatefulWidget {
  const AdoptionTabView({super.key});

  @override
  State<AdoptionTabView> createState() => _AdoptionTabViewState();
}

class _AdoptionTabViewState extends State<AdoptionTabView> {
  int selectedIndex = 0;

  final List<String> tabs = ['All', 'Cats', 'Dogs'];

  Widget buildCustomTab(String text, bool selected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 102, // ✅ Fixed width for all tabs
        margin: const EdgeInsets.symmetric(horizontal: 10),
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        decoration: BoxDecoration(
          gradient: selected
              ? const LinearGradient(
            colors: [Color(0xFF8AD8C0), Color(0xFF19A2A5)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          )
              : null,
          color: selected ? null : Colors.white,
          borderRadius: BorderRadius.circular(30.0),
          border: Border.all(
            color: selected ? Colors.transparent : Colors.grey.shade300,
            width: 1.0,
          ),
          boxShadow: selected
              ? null
              : [
            BoxShadow(
              color: Color(0XFF00000000).withOpacity(0.08),
              offset: const Offset(0, 0),
              blurRadius: 1.r,
              spreadRadius: 0,
            ),
          ],
        ),
        child: Center(
          child: CustomText(
            text: text,
            color: selected ? Colors.white : Colors.black87,
            fontSize: 14.0,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final allPets = [
      AdoptionCard(
        type: 'Adoption',
        name: 'Becon',
        gender: 'Female',
        age: 2,
        imagePath: AppImages.pet1,
      ),
      AdoptionCard(
        type: 'Adoption',
        name: 'Mini',
        gender: 'Male',
        age: 2,
        imagePath: AppImages.pet2,
      ),
      AdoptionCard(
        type: 'Adoption',
        name: 'Miki',
        gender: 'Female',
        age: 2,
        imagePath: AppImages.pet3,
      ),
      AdoptionCard(
        type: 'Adoption',
        name: 'Charlie',
        gender: 'Male',
        age: 1,
        imagePath: AppImages.pet4,
      ),
    ];

    final catPets = allPets
        .where((p) =>
    (p.gender.toLowerCase() == 'male' && p.name == 'Mini') ||
        p.name == 'Miki')
        .toList();

    final dogPets = allPets
        .where((p) =>
    (p.gender.toLowerCase() == 'female' && p.name == 'Becon') ||
        p.name == 'Charlie')
        .toList();

    List<AdoptionCard> getPetsForTab(int index) {
      if (index == 1) return catPets;
      if (index == 2) return dogPets;
      return allPets;
    }

    return Column(
      children: [
        // ✅ Custom Tab Bar
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: List.generate(tabs.length, (index) {
              return buildCustomTab(
                tabs[index],
                selectedIndex == index,
                    () {
                  setState(() {
                    selectedIndex = index;
                  });
                },
              );
            }),
          ),
        ),
        // ✅ Pet Grid
        Expanded(
          child: GridView.count(

            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 0.7,
            children: getPetsForTab(selectedIndex),
          ),
        ),
      ],
    );
  }
}
