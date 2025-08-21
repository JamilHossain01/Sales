import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:wolf_pack/app/common%20widget/custom_calender.dart';
import 'package:wolf_pack/app/common%20widget/custom_app_bar_widget.dart';
import 'package:wolf_pack/app/modules/closed_deal/model/single_client_model.dart' as closed_deal;
import 'package:wolf_pack/app/uitilies/date_time_formate.dart';
import 'package:wolf_pack/app/modules/home/controllers/ny_clients_controller.dart';
import 'package:wolf_pack/app/modules/home/widgets/target_widgets.dart';
import 'package:wolf_pack/app/modules/home/widgets/rececnt_deatils_widgets.dart';
import 'package:wolf_pack/app/modules/open_deal/views/new_deal_view.dart';
import 'package:wolf_pack/app/modules/closed_deal/views/closed_deal_view.dart';
import 'package:wolf_pack/app/modules/closed_deal/widgets/closed_deal_clients_details_widgets.dart';
import 'package:wolf_pack/app/modules/home/model/my_clients_model.dart' as home;
import 'package:wolf_pack/app/modules/open_deal/widgets/closed_deal_widgets.dart';
import 'package:wolf_pack/app/modules/open_deal/widgets/new_add_deals.dart';
import 'package:wolf_pack/app/modules/profile/controllers/get_myProfile_controller.dart';

import '../../open_deal/views/open_deal_view.dart';

class SalesScreen extends StatefulWidget {
  const SalesScreen({super.key});

  @override
  State<SalesScreen> createState() => _SalesScreenState();
}

class _SalesScreenState extends State<SalesScreen> {
  final MyAllClientsGetController dealController = Get.put(MyAllClientsGetController());
  final GetMyProfileController profileController = Get.put(GetMyProfileController());
  final NumberFormat currencyFormat = NumberFormat.currency(symbol: '€', decimalDigits: 2);

  DateTime? _selectedDate;
  String _searchQuery = '';
  String _selectedStatus = 'All';

  @override
  void initState() {
    super.initState();
    dealController.fetchMyProfile();
  }

  String _formatCurrency(num? value) {
    if (value == null) return '€0.00';
    return currencyFormat.format(value);
  }

  List<home.Datum> _filterClients() {
    var clients = dealController.myAllClientData.value.data?.data ?? [];

    if (_searchQuery.isNotEmpty) {
      clients = clients
          .where((client) => client.name?.toLowerCase().contains(_searchQuery.toLowerCase()) ?? false)
          .toList();
    }

    if (_selectedStatus != 'All') {
      clients = clients
          .where((client) => (client.closer?.status?.toLowerCase() == _selectedStatus.toLowerCase()) ??
          (_selectedStatus == 'New' && client.closer == null))
          .toList();
    }

    if (_selectedDate != null) {
      clients = clients.where((client) {
        final dealDate = client.closer?.dealDate;
        return dealDate != null &&
            dealDate.year == _selectedDate!.year &&
            dealDate.month == _selectedDate!.month &&
            dealDate.day == _selectedDate!.day;
      }).toList();
    }

    return clients;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(title: 'SalesView'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TargetProgressCard(
              title: 'Monthly Target',
              progressValue: (profileController.profileData.value.data?.monthlyTargetPercentage ?? 0).toDouble(),
              achievedText: 'Achieved: ${_formatCurrency(profileController.profileData.value.data?.salesCount)} '
                  'of ${_formatCurrency(profileController.profileData.value.data?.monthlyTarget)}',
              percentageLabel: '${profileController.profileData.value.data?.monthlyTargetPercentage ?? "N/A"}%',
              // footerMessage: "You're halfway there! 🎉",
            ),
            Gap(20.h),

            CustomCalendarWidget(
              onDateSelected: (date) => setState(() => _selectedDate = date),
              onClearDate: () => setState(() => _selectedDate = null),
              selectedFilterDate: _selectedDate,
            ),
            Gap(20.h),

            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 45.h,
                    padding: EdgeInsets.symmetric(horizontal: 12.w),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.orange),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.search, color: Colors.orange, size: 18.sp),
                        SizedBox(width: 8.w),
                        Expanded(
                          child: TextField(
                            onChanged: (value) => setState(() => _searchQuery = value),
                            style: TextStyle(color: Colors.orange),
                            cursorColor: Colors.orange,
                            decoration: InputDecoration(
                              hintText: 'Search by name..',
                              hintStyle: TextStyle(color: Colors.orange),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 10.w),
                Container(
                  height: 45.h,
                  padding: EdgeInsets.symmetric(horizontal: 12.w),
                  decoration: BoxDecoration(
                    color: const Color(0xFF6C4D0C),
                    borderRadius: BorderRadius.circular(8.r),
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
            Gap(20.h),

            if (_selectedDate != null || _searchQuery.isNotEmpty || _selectedStatus != 'All')
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () => setState(() {
                      _selectedDate = null;
                      _searchQuery = '';
                      _selectedStatus = 'All';
                    }),
                    child: Text('Clear Filters', style: TextStyle(color: Colors.orange)),
                  ),
                ),
              ),

            Obx(() {
              if (dealController.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }

              final filteredClients = _filterClients();
              if (filteredClients.isEmpty) {
                return Center(
                  child: Text(
                    _searchQuery.isNotEmpty || _selectedDate != null || _selectedStatus != 'All'
                        ? "No matching results"
                        : "No data available",
                  ),
                );
              }

              return ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: filteredClients.length,
                itemBuilder: (context, index) {
                  final client = filteredClients[index];
                  final status = (client.closer?.status ?? '').toUpperCase();
                  final tagLabel = status == 'CLOSED' ? 'Closed' :
                  status == 'OPEN' ? 'Open' :
                  status == 'NEW' ? 'New' : "New";

                  return RecentDetails(
                    color: const Color(0xFFE12728),
                    tagLabel: tagLabel,
                    companyName: client.name ?? 'N/A',
                    startDate: DateUtil.formatTimeAgo(client.createdAt?.toLocal()),
                    endDate: DateUtil.formatTimeAgo(client.updatedAt?.toLocal()),
                    revenueTarget: _formatCurrencyDropDecimals(client.revenueTarget),
                    revenueClosed: _formatCurrencyDropDecimals(client.closer?.amount),



                    commissionEarned: '${client.commissionRate ?? 0}%',
                    onViewDetailsTap: () {
                      switch (status) {
                        case "NEW":
                          Get.to(() => NewDealView(clientId: client.id ?? ''));
                          break;
                        case "OPEN":
                          Get.to(() => OpenDealView(clientId: client.id ?? ''));
                          break;
                        case "CLOSED":
                          Get.to(() => ClosedDealView(clientID: client.id ?? '',

                          ));
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

    final intInt = v.truncate(); // remove decimal part
    return NumberFormat.decimalPattern().format(intInt); // add commas if needed
  }


}