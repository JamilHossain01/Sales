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

import '../../../common_widget/custom_calender.dart';
import '../../../common_widget/nodata_wisgets.dart';
import '../../home/model/all_my_cleints_model.dart';

class SalesContent extends StatefulWidget {
  const SalesContent({super.key});

  @override
  State<SalesContent> createState() => _SalesContentState();
}

class _SalesContentState extends State<SalesContent> {
  final MyAllClientsGetController dealController =
  Get.put(MyAllClientsGetController());
  final GetMyProfileController profileController =
  Get.put(GetMyProfileController());

  DateTime? _selectedDate;
  String _searchQuery = '';
  String _selectedStatus = 'All';

  @override
  void initState() {
    super.initState();
    // profileController.fetchMyProfile();
    dealController.fetchMyAllClients();
  }

  List<Datum> _filterClients() {
    var clients = dealController.myAllClientData.value.data?.data ?? [];

    if (_searchQuery.isNotEmpty) {
      clients = clients
          .where((c) =>
      c.name?.toLowerCase().contains(_searchQuery.toLowerCase()) ?? false)
          .toList();
    }

    if (_selectedStatus != 'All') {
      clients = clients.where((client) {
        final hasCloser = client.closer.isNotEmpty;
        final status = hasCloser ? client.closer.last.status?.toLowerCase() : 'new';

        return _selectedStatus == 'New'
            ? !hasCloser
            : status == _selectedStatus.toLowerCase();
      }).toList();
    }

    if (_selectedDate != null) {
      clients = clients.where((client) {
        if (client.closer.isEmpty) return false;
        final dealDate = client.closer.last.dealDate;
        if (dealDate == null) return false;

        return dealDate.year == _selectedDate!.year &&
            dealDate.month == _selectedDate!.month &&
            dealDate.day == _selectedDate!.day;
      }).toList();
    }

    return clients;
  }

  Color _getStatusColor(String status) {
    switch (status.toUpperCase()) {
      case 'NEW':
        return const Color(0xFF16A34A);
      case 'OPEN':
        return const Color(0xFF0094B5);
      case 'CLOSED':
        return const Color(0xFFE12728);
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      // ======================================================================
      // LOADING STATE (NO LISTVIEW → FIXED)
      // ======================================================================
      if (dealController.isLoading.value) {
        return SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
          child: Column(
            children: List.generate(
              8,
                  (i) => Padding(
                padding: EdgeInsets.only(bottom: 12.h),
                child: RecentDetails(
                  color: Colors.grey,
                  tagLabel: 'Loading',
                  companyName: 'Loading...',
                  assignDate: 'Loading...',
                  offer: '0',
                  commissionRate: '0%',
                  onViewDetailsTap: () {},
                ),
              ),
            ),
          ),
        );
      }

      final filteredClients = _filterClients();

      return SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ================= TARGET CARD ========================
            TargetProgressCard(
              title: 'Deals Closed',
              progressValue:
              (profileController.profileData.value.data?.monthlyTargetPercentage ?? 0) /
                  100,
              achievedText:
              'Achieved: €${profileController.profileData.value.data?.salesCount ?? 0} '
                  'of €${profileController.profileData.value.data?.monthlyTarget ?? 0}',
              percentageLabel:
              '${profileController.profileData.value.data?.monthlyTargetPercentage ?? 0}%',
            ),
            Gap(20.h),

            // ================= CALENDAR ============================
            CustomCalendarWidget(
              onDateSelected: (date) => setState(() => _selectedDate = date),
              onClearDate: () => setState(() => _selectedDate = null),
              selectedFilterDate: _selectedDate,
            ),
            Gap(20.h),

            // ================= FILTERS: Search + Status =====================
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
                            onChanged: (v) => setState(() => _searchQuery = v),
                            style: const TextStyle(color: Colors.orange),
                            cursorColor: Colors.orange,
                            decoration: const InputDecoration(
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
                      items: ['All', 'New', 'Open', 'Closed']
                          .map((s) => DropdownMenuItem(
                        value: s,
                        child: Text(
                          s,
                          style: const TextStyle(color: Colors.white),
                        ),
                      ))
                          .toList(),
                      onChanged: (v) => setState(() => _selectedStatus = v ?? 'All'),
                    ),
                  ),
                ),
              ],
            ),
            Gap(20.h),

            // ================= CLEAR FILTERS ======================
            if (_selectedDate != null ||
                _searchQuery.isNotEmpty ||
                _selectedStatus != 'All')
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () => setState(() {
                    _selectedDate = null;
                    _searchQuery = '';
                    _selectedStatus = 'All';
                  }),
                  child: const Text(
                    'Clear Filters',
                    style: TextStyle(color: Colors.orange),
                  ),
                ),
              ),
            Gap(10.h),

            // ================= RESULTS LIST ========================
            filteredClients.isEmpty
                ? Center(
              child: NoDataWidget(
                text: _searchQuery.isNotEmpty ||
                    _selectedDate != null ||
                    _selectedStatus != 'All'
                    ? 'No matching results'
                    : 'No data available',
              ),
            )
                : Column(
              children: filteredClients.map((client) {
                final hasCloser = client.closer.isNotEmpty;
                final status = hasCloser
                    ? (client.closer.last.status ?? 'New')
                    : 'New';

                final tagLabel = status.toUpperCase();
                final tagColor = _getStatusColor(tagLabel);

                final assignDate = client.createdAt != null
                    ? DateFormat('yyyy-MM-dd hh:mm a').format(client.createdAt!)
                    : 'N/A';

                return Padding(
                  padding: EdgeInsets.only(bottom: 12.h),
                  child: RecentDetails(
                    color: tagColor,
                    tagLabel: tagLabel,
                    companyName: client.name ?? 'N/A',
                    assignDate: assignDate,
                    offer: client.offer ?? 'N/A',
                    commissionRate: '${client.commissionRate ?? 0}%',
                    onViewDetailsTap: () {
                      final id = client.id ?? '';

                      switch (tagLabel) {
                        case 'NEW':
                          Get.to(() => NewDealView(clientId: id));
                          break;
                        case 'OPEN':
                          Get.to(() => OpenDealView(clientId: id));
                          break;
                        case 'CLOSED':
                          Get.to(() => ClosedDealView(clientID: id));
                          break;
                      }
                    },
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      );
    });
  }
}
