import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pet_donation/app/modules/home/widgets/pet_card.dart';
import 'package:pet_donation/app/uitilies/app_images.dart';

class AdoptionTabView extends StatefulWidget {
  const AdoptionTabView({super.key});

  @override
  _AdoptionTabViewState createState() => _AdoptionTabViewState();
}

class _AdoptionTabViewState extends State<AdoptionTabView> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int selectedIndex = 0;

  final List<String> tabs = ['All', 'Cats', 'Dogs'];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: tabs.length, vsync: this);
    _tabController.addListener(() {
      setState(() {
        selectedIndex = _tabController.index;
      });
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Widget buildCustomTab(String text, bool selected) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
      decoration: BoxDecoration(
        color: selected ? Colors.teal.shade400 : Colors.white,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: selected ? Colors.teal.shade400 : Colors.grey.shade300),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: selected ? Colors.white : Colors.black87,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final allPets = [
      AdoptionCard(type: 'Adoption', name: 'Becon', gender: 'Female', age: 2, imagePath: AppImages.pet1),
      AdoptionCard(type: 'Adoption', name: 'Mini', gender: 'Male', age: 2, imagePath:  AppImages.pet2),
      AdoptionCard(type: 'Adoption', name: 'Miki', gender: 'Female', age: 2, imagePath:  AppImages.pet3),
      AdoptionCard(type: 'Adoption', name: 'Charlie', gender: 'Male', age: 1, imagePath:  AppImages.pet4),
    ];

    final catPets = allPets.where((p) => p.gender.toLowerCase() == 'male' && p.name == 'Mini' || p.name == 'Miki').toList();
    final dogPets = allPets.where((p) => p.gender.toLowerCase() == 'female' && p.name == 'Becon' || p.name == 'Charlie').toList();

    List<AdoptionCard> getPetsForTab(int index) {
      if (index == 1) return catPets;
      if (index == 2) return dogPets;
      return allPets;
    }

    return Column(
      children: [
        TabBar(
          controller: _tabController,
          indicatorColor: Colors.transparent,
          tabs: List.generate(tabs.length, (index) {
            return Tab(child: buildCustomTab(tabs[index], selectedIndex == index));
          }),
        ),
        Expanded(
          child: GridView.count(
            crossAxisCount: 2,
            // padding: const EdgeInsets.all(),
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 0.7, // width/height, 0.7 হলে উচ্চতা বাড়বে
            children: getPetsForTab(selectedIndex),
          )


        ),
      ],
    );
  }
}