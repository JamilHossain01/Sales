import 'package:flutter/material.dart';
import 'package:pet_donation/app/uitilies/app_colors.dart';

class CustomTabView extends StatefulWidget {
  final List<String> tabs;
  final Map<String, List<String>> data;

  const CustomTabView({
    Key? key,
    required this.tabs,
    required this.data,
  }) : super(key: key);

  @override
  _CustomTabViewState createState() => _CustomTabViewState();
}

class _CustomTabViewState extends State<CustomTabView> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: widget.tabs.length, vsync: this);
    _tabController.addListener(() {
      setState(() {}); // UI আপডেটের জন্য
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Widget _buildTab(String text, bool isSelected) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      decoration: BoxDecoration(
        color: isSelected ? AppColors.mainColor: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isSelected ? AppColors.mainColor : Colors.grey.shade300,
          width: 1,
        ),
        boxShadow: isSelected
            ? [
          BoxShadow(
            color:AppColors.mainColor.withOpacity(0.3),
            blurRadius: 8,
            offset: Offset(0, 3),
          )
        ]
            : [],
      ),
      child: Text(
        text,
        style: TextStyle(
          color: isSelected ? Colors.white : Colors.black87,
          fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
          fontSize: 16,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(25),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: TabBar(
            controller: _tabController,
            indicator: BoxDecoration(), // আন্ডারলাইন রিমুভ
            labelPadding: EdgeInsets.zero,
            tabs: List.generate(widget.tabs.length, (index) {
              final isSelected = _tabController.index == index;
              return Tab(
                child: _buildTab(widget.tabs[index], isSelected),
              );
            }),
          ),

        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: widget.tabs.map((tab) {
              return Padding(
                padding: const EdgeInsets.all(20.0),
                child: ListView(
                  children: widget.data[tab]!
                      .map((item) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Text(item, style: TextStyle(fontSize: 18)),
                  ))
                      .toList(),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
