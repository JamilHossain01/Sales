import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:wolf_pack/app/modules/home/controllers/ny_clients_controller.dart';
import 'package:wolf_pack/app/modules/home/model/my_clients_model.dart';
import 'package:wolf_pack/app/modules/home/widgets/rececnt_deatils_widgets.dart';
import 'package:wolf_pack/app/modules/home/widgets/target_widgets.dart';
import 'package:wolf_pack/app/modules/open_deal/views/new_deal_view.dart';
import 'package:wolf_pack/app/modules/open_deal/views/open_deal_view.dart';
import 'package:wolf_pack/app/modules/closed_deal/views/closed_deal_view.dart';
import 'package:wolf_pack/app/modules/profile/controllers/get_myProfile_controller.dart';
import 'package:wolf_pack/app/uitilies/app_colors.dart';
import 'package:wolf_pack/app/uitilies/custom_loader.dart';
import 'package:wolf_pack/app/uitilies/date_time_formate.dart';
import '../../../common_widget/custom_calender.dart';
import '../../../common_widget/nodata_wisgets.dart';
import '../../home/model/all_my_cleints_model.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:wolf_pack/app/modules/home/controllers/ny_clients_controller.dart';
import 'package:wolf_pack/app/modules/home/model/my_clients_model.dart';
import 'package:wolf_pack/app/modules/home/widgets/rececnt_deatils_widgets.dart';
import 'package:wolf_pack/app/modules/home/widgets/target_widgets.dart';
import 'package:wolf_pack/app/modules/open_deal/views/new_deal_view.dart';
import 'package:wolf_pack/app/modules/open_deal/views/open_deal_view.dart';
import 'package:wolf_pack/app/modules/closed_deal/views/closed_deal_view.dart';
import 'package:wolf_pack/app/modules/profile/controllers/get_myProfile_controller.dart';
import 'package:wolf_pack/app/uitilies/app_colors.dart';
import 'package:wolf_pack/app/uitilies/custom_loader.dart';
import 'package:wolf_pack/app/uitilies/date_time_formate.dart';
import '../../../common_widget/custom_calender.dart';
import '../../../common_widget/nodata_wisgets.dart';
import '../../home/model/all_my_cleints_model.dart';

class SalesContent extends StatefulWidget {
  const SalesContent({super.key});

  @override
  State<SalesContent> createState() => _SalesContentState();
}

class _SalesContentState extends State<SalesContent> {
  final MyAllClientsGetController dealController = Get.put(MyAllClientsGetController());
  final GetMyProfileController profileController = Get.put(GetMyProfileController());

  DateTime? _selectedDate;
  String _searchQuery = '';
  String _selectedStatus = 'All';

  @override
  void initState() {
    super.initState();
    profileController.fetchMyProfile();
    dealController.fetchMyAllClients();
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

  List<Datum> _filterClients() {
    var clients = dealController.myAllClientData.value.data?.data ?? [];
    // Search filter
    if (_searchQuery.isNotEmpty) {
      clients = clients.where((client) =>
      client.name?.toLowerCase().contains(_searchQuery.toLowerCase()) ?? false).toList();
    }
    // Status filter
    if (_selectedStatus != 'All') {
      clients = clients.where((client) {
        final hasCloser = client.closer.isNotEmpty;
        final currentStatus = hasCloser ? client.closer.last.status?.toLowerCase() : null;
        if (_selectedStatus == 'New') {
          return !hasCloser;
        } else {
          return hasCloser && currentStatus == _selectedStatus.toLowerCase();
        }
      }).toList();
    }
    // Date filter
    if (_selectedDate != null) {
      clients = clients.where((client) {
        final hasCloser = client.closer.isNotEmpty;
        final dealDate = hasCloser ? client.closer.last.dealDate : null;
        return dealDate != null &&
            dealDate.year == _selectedDate!.year &&
            dealDate.month == _selectedDate!.month &&
            dealDate.day == _selectedDate!.day;
      }).toList();
    }
    return clients;
  }

  // Get color for status
  Color _getStatusColor(String status) {
    switch (status.toUpperCase()) {
      case 'NEW':
        return const Color(0xFF16A34A);
      case 'OPEN':
        return Color(0Xff0094B5);
      case 'CLOSED':
        return const Color(0xFFE12728);
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (dealController.isLoading.value) {
        // Show shimmer/redacted placeholders
        return ListView.builder(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
          itemCount: 4,
          itemBuilder: (context, index) => RecentDetails(
            color: Colors.grey.shade800,
            tagLabel: 'Loading',
            companyName: 'Loading',
            assignDate: 'Loading',
            offer: '0',
            commissionRate: '0%',
            onViewDetailsTap: () {},
          ),
        );
      }

      final filteredClients = _filterClients();

      return SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TargetProgressCard(
              title: 'Deals Closed',
              progressValue: ((profileController.profileData.value.data?.monthlyTargetPercentage ?? 0) / 100),
              achievedText: 'Achieved: €${profileController.profileData.value.data?.salesCount ?? 0} '
                  'of €${profileController.profileData.value.data?.monthlyTarget ?? 0}',
              percentageLabel: '${profileController.profileData.value.data?.monthlyTargetPercentage ?? 0}%',
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
                      items: ['All', 'New', 'Open', 'Closed'].map((status) {
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
              Align(
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
            filteredClients.isEmpty
                ? Center(
              child: GestureDetector(
                child: NoDataWidget(text: _searchQuery.isNotEmpty ||
                    _selectedDate != null ||
                    _selectedStatus != 'All'
                    ? 'No matching results'
                    : 'No data available'),
              ),
            )
                : ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: filteredClients.length,
              itemBuilder: (context, index) {
                final client = filteredClients[index];
                final hasCloser = client.closer.isNotEmpty;
                final currentStatus = hasCloser ? client.closer.last.status ?? 'New' : 'New';
                final tagLabel = currentStatus.toUpperCase();
                final tagColor = _getStatusColor(tagLabel);
                final assignDate = client.createdAt != null ? DateFormat('yyyy-MM-dd hh:mm a').format(client.createdAt!) : 'N/A';                return RecentDetails(
                  color: tagColor,
                  tagLabel: tagLabel,
                  companyName: client.name ?? 'N/A',
                  assignDate: assignDate,
                  // offer: '€${_formatCurrencyDropDecimals(client.offer)}',
                  offer:  client.offer ?? 'N/A',

                  commissionRate: '${client.commissionRate ?? 0}%',
                  onViewDetailsTap: () {
                    switch (tagLabel.toUpperCase()) {
                      case "NEW":
                        Get.to(() => NewDealView(clientId: client.id ?? ''));
                        break;
                      case "OPEN":
                        Get.to(() => OpenDealView(clientId: client.id ?? ''));
                        break;
                      case "CLOSED":
                        Get.to(() => ClosedDealView(clientID: client.id ?? ''));
                        break;
                    }
                  },
                );
              },
            ),
          ],
        ),
      );
    });
  }
}