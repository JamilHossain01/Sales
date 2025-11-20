import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:wolf_pack/app/common_widget/custom_app_bar_widget.dart';
import 'package:wolf_pack/app/modules/home/controllers/ny_clients_controller.dart';
import 'package:wolf_pack/app/modules/home/controllers/allDeals_controller.dart';
import 'package:wolf_pack/app/modules/home/widgets/target_widgets.dart';
import 'package:wolf_pack/app/modules/open_deal/views/new_deal_view.dart';
import 'package:wolf_pack/app/modules/open_deal/views/open_deal_view.dart';
import 'package:wolf_pack/app/modules/closed_deal/views/closed_deal_view.dart';
import 'package:wolf_pack/app/modules/profile/controllers/get_myProfile_controller.dart';
import '../../../common_widget/custom_button.dart';
import '../../../common_widget/custom_calender.dart';
import '../../../uitilies/date_time_formate.dart';
import '../../home/model/all_my_cleints_model.dart';
import '../../home/model/all_deal_model.dart';
import '../../home/widgets/rececnt_deatils_widgets.dart';

class SalesScreen extends StatefulWidget {
  const SalesScreen({super.key});

  @override
  State<SalesScreen> createState() => _SalesScreenState();
}

class _SalesScreenState extends State<SalesScreen> {
  final AllDealController allDealController = Get.put(AllDealController());
  final MyAllClientsGetController myDealController = Get.put(MyAllClientsGetController());
  final GetMyProfileController profileController = Get.put(GetMyProfileController());
  final NumberFormat currencyFormat = NumberFormat.currency(symbol: '€', decimalDigits: 2);
  DateTime? _selectedDate;
  String _searchQuery = '';
  String _selectedStatus = 'All';
  /// Toggle between deals
  var isAllDeals = true.obs;

  @override
  void initState() {
    super.initState();
    profileController.fetchMyProfile(); // Load profile for target progress
    // allDealController.fetchAllDeals(); // Corrected API call for all deals
  }

  // Format currency with proper decimals
  String _formatCurrencyDropDecimals(dynamic value) {
    if (value == null) return '0';
    double v;
    if (value is String) {
      v = double.tryParse(value) ?? 0.0;
    } else if (value is num) {
      v = value.toDouble();
    } else {
      return '0';
    }
    final intInt = v.truncate();
    return NumberFormat.decimalPattern().format(intInt);
  }

  // Filters clients based on search, status, and selected date
  List<Datum> _filterClients() {
    List<Datum> activeList;
    if (isAllDeals.value) {
      activeList = (allDealController.myAllClientData.value.data?.data as List?)?.cast<Datum>() ?? <Datum>[];
    } else {
      activeList = myDealController.myAllClientData.value.data?.data ?? <Datum>[];
    }
    return _applyFilters(activeList);
  }

  // Apply filters based on search query, status, and date
  List<Datum> _applyFilters(List<Datum> clients) {
    var filtered = clients;
    if (_searchQuery.isNotEmpty) {
      filtered = filtered.where((client) {
        return client.name?.toLowerCase().contains(_searchQuery.toLowerCase()) ?? false;
      }).toList();
    }
    if (_selectedStatus != 'All') {
      filtered = filtered.where((client) {
        final hasCloser = client.closer.isNotEmpty;
        final currentStatus = hasCloser ? client.closer.last.status?.toLowerCase() : null;
        if (_selectedStatus == 'New') {
          return !hasCloser;
        } else {
          return hasCloser && currentStatus == _selectedStatus.toLowerCase();
        }
      }).toList();
    }
    if (_selectedDate != null) {
      filtered = filtered.where((client) {
        final hasCloser = client.closer.isNotEmpty;
        final dealDate = hasCloser ? client.closer.last.dealDate : null;
        return dealDate != null &&
            dealDate.year == _selectedDate!.year &&
            dealDate.month == _selectedDate!.month &&
            dealDate.day == _selectedDate!.day;
      }).toList();
    }
    return filtered;
  }

  // Get color for status
  Color _getStatusColor(String status) {
    switch (status.toUpperCase()) {
      case 'NEW':
        return Colors.green;
      case 'OPEN':
        return Color(0Xff0094B5);
      case 'CLOSED':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: CommonAppBar(title: 'Sales View'),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TargetProgressCard(
              title: "Deals Closed",
              progressValue: ((profileController.profileData.value.data?.monthlyTargetPercentage ?? 0) / 100).toDouble(),
              achievedText: 'Achieved: €${profileController.profileData.value.data?.salesCount ?? "N/A"} of €${profileController.profileData.value.data?.monthlyTarget ?? "N/A"}',
              percentageLabel: '${profileController.profileData.value.data?.monthlyTargetPercentage ?? "N/A"}%',
            ),
            SizedBox(height: 20),
            CustomCalendarWidget(
              onDateSelected: (date) => setState(() => _selectedDate = date),
              onClearDate: () => setState(() => _selectedDate = null),
              selectedFilterDate: _selectedDate,
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 45,
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      color: Colors.black,
                      border: Border.all(color: Colors.amber),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.search, color: Colors.amber, size: 18),
                        SizedBox(width: 8),
                        Expanded(
                          child: TextField(
                            onChanged: (value) => setState(() => _searchQuery = value),
                            style: const TextStyle(color: Colors.white),
                            cursorColor: Colors.amber,
                            decoration: const InputDecoration(
                              hintText: 'Search here..',
                              hintStyle: TextStyle(color: Colors.amber),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Container(
                  height: 45,
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    color: const Color(0xFF6C4D0C),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      dropdownColor: const Color(0xFF6C4D0C),
                      value: _selectedStatus,
                      icon: const Icon(Icons.keyboard_arrow_down, color: Colors.white),
                      items: ['All', 'New', 'Open', 'Closed'].map((String status) {
                        return DropdownMenuItem<String>(
                          value: status,
                          child: Text(status, style: const TextStyle(color: Colors.white)),
                        );
                      }).toList(),
                      onChanged: (value) => setState(() => _selectedStatus = value ?? 'All'),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: Obx(() => CustomButton(
                    isGradient: false,
                    buttonColor: isAllDeals.value ? Colors.amber : Colors.grey.shade900,
                    titleColor: isAllDeals.value ? Colors.black : Colors.white,
                    title: 'All Deals',
                    onTap: () {
                      isAllDeals.value = true;
                      allDealController.myAllClientData(); // Corrected API call
                    },
                  )),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Obx(() => CustomButton(
                    isGradient: false,
                    buttonColor: !isAllDeals.value ? Colors.amber : Colors.grey.shade900,
                    titleColor: !isAllDeals.value ? Colors.black : Colors.white,
                    title: 'My Deals',
                    onTap: () {
                      isAllDeals.value = false;
                      myDealController.fetchMyAllClients(); // Corrected API call
                    },
                  )),
                ),
              ],
            ),
            SizedBox(height: 20),
            Obx(() {
              final isLoading = isAllDeals.value
                  ? allDealController.isLoading.value
                  : myDealController.isLoading.value;
              if (isLoading) {
                return ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return RecentDetails(
                      color: Colors.grey.shade800,
                      tagLabel: 'Loading',
                      companyName: 'Loading',
                      assignDate: 'Loading',
                      offer: '0',
                      commissionRate: '0%',
                      onViewDetailsTap: () {},
                    );
                  },
                );
              }
              final filteredClients = _filterClients();
              if (filteredClients.isEmpty) {
                return Center(
                  child: Text(
                    _searchQuery.isNotEmpty ||
                        _selectedDate != null ||
                        _selectedStatus != 'All'
                        ? "No matching results"
                        : "No data available",
                    style: const TextStyle(color: Colors.white),
                  ),
                );
              }
              return ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: filteredClients.length,
                itemBuilder: (context, index) {
                  final client = filteredClients[index];
                  final hasCloser = client.closer.isNotEmpty;
                  final currentStatus = hasCloser ? client.closer.last.status ?? "New" : "New";
                  String tagLabel = currentStatus.toUpperCase();
                  String companyName = client.name ?? 'N/A';
                  String offer = _formatCurrencyDropDecimals(client.offer);
                  String commissionRate = '${client.commissionRate ?? 0}%';
                  final assignDate = client.createdAt != null ? DateFormat('yyyy-MM-dd hh:mm a').format(client.createdAt!) : 'N/A';                  String clientId = client.id ?? '';
                  return RecentDetails(
                    color: _getStatusColor(tagLabel),
                    tagLabel: tagLabel,
                    companyName: companyName,
                    assignDate: assignDate,
                    offer:  client.offer ?? 'N/A',
                    commissionRate: commissionRate,
                    onViewDetailsTap: () {
                      switch (tagLabel.toUpperCase()) {
                        case "NEW":
                          Get.to(() => NewDealView(clientId: clientId));
                          break;
                        case "OPEN":
                          Get.to(() => OpenDealView(clientId: clientId));
                          break;
                        case "CLOSED":
                          Get.to(() => ClosedDealView(clientID: clientId));
                          break;
                      }
                    },
                  );
                },
              );
            }),
          ],
        ),
      ),
    );
  }
}