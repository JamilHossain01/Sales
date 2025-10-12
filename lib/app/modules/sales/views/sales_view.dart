import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import 'package:wolf_pack/app/common%20widget/custom_calender.dart';
import 'package:wolf_pack/app/modules/home/widgets/target_widgets.dart';
import 'package:wolf_pack/app/modules/home/widgets/rececnt_deatils_widgets.dart';
import 'package:wolf_pack/app/modules/home/controllers/ny_clients_controller.dart';
import 'package:wolf_pack/app/modules/open_deal/views/new_deal_view.dart';
import 'package:wolf_pack/app/modules/profile/controllers/get_myProfile_controller.dart';
import 'package:wolf_pack/app/uitilies/custom_loader.dart';
import 'package:wolf_pack/app/uitilies/date_time_formate.dart';
import 'package:wolf_pack/app/uitilies/app_colors.dart';
import 'package:wolf_pack/app/modules/home/model/my_clients_model.dart';

import '../../home/model/all_my_cleints_model.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart'; // For currency formatting

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart'; // For currency formatting

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
    dealController.fetchMyProfile();
  }

  // List<Datum> _filterClients() {
  //   var clients = dealController.myAllClientData.value.data?.data ?? [];
  //
  //   // Filter out clients with "closer": null
  //   clients = clients.where((client) => client.closer != null).toList();
  //
  //   // Search filter
  //   if (_searchQuery.isNotEmpty) {
  //     clients = clients.where((client) =>
  //     client.name?.toLowerCase().contains(_searchQuery.toLowerCase()) ?? false).toList();
  //   }
  //
  //   // Status filter
  //   if (_selectedStatus != 'All') {
  //     clients = clients.where((client) {
  //       final status = client.closer?.status?.toLowerCase();
  //       return (status == _selectedStatus.toLowerCase()) ||
  //           (_selectedStatus == 'New' && client.closer == null);
  //     }).toList();
  //   }
  //
  //   // Date filter
  //   if (_selectedDate != null) {
  //     clients = clients.where((client) {
  //       final dealDate = client.closer?.dealDate;
  //       return dealDate != null &&
  //           dealDate.year == _selectedDate!.year &&
  //           dealDate.month == _selectedDate!.month &&
  //           dealDate.day == _selectedDate!.day;
  //     }).toList();
  //   }
  //
  //   return clients;
  // }
  List<Datum> _filterClients() {
    var clients = dealController.myAllClientData.value.data?.data ?? [];

    // ✅ Remove this line (it was excluding closer == null)
    // clients = clients.where((client) => client.closer != null).toList();

    // 🔍 Search filter
    if (_searchQuery.isNotEmpty) {
      clients = clients.where((client) =>
      client.name?.toLowerCase().contains(_searchQuery.toLowerCase()) ?? false).toList();
    }

    // 📊 Status filter
    if (_selectedStatus != 'All') {
      clients = clients.where((client) {
        final status = client.closer?.status?.toLowerCase();
        if (_selectedStatus == 'New') {
          return client.closer == null;
        }
        return status == _selectedStatus.toLowerCase();
      }).toList();
    }

    // 📅 Date filter
    if (_selectedDate != null) {
      clients = clients.where((client) {
        final dealDate = client.closer?.dealDate;
        if (dealDate == null) return false;
        return dealDate.year == _selectedDate!.year &&
            dealDate.month == _selectedDate!.month &&
            dealDate.day == _selectedDate!.day;
      }).toList();
    }

    return clients;
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
            // isRedacted: true,
            tagLabel: '',
            companyName: '',
            startDate: '',
            endDate: '',
            revenueTarget: '',
            revenueClosed: '',
            commissionEarned: '',
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
              achievedText:
              'Achieved: €${profileController.profileData.value.data?.salesCount ?? 0} '
                  'of €${profileController.profileData.value.data?.monthlyTarget ?? 0}',
              percentageLabel:
              '${profileController.profileData.value.data?.monthlyTargetPercentage ?? 0}%',
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
                ? Center(child: Text('No matching results'))
                : ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: filteredClients.length,
              itemBuilder: (context, index) {
                final client = filteredClients[index];
                final status = (client.closer?.status ?? 'New').toUpperCase();
                final tagLabel = status;

                Color tagColor = status == 'CLOSED'
                    ? const Color(0xFFE12728)
                    : status == 'OPEN'
                    ? const Color(0xFF0094B5)
                    : const Color(0xFF16A34A);

                return RecentDetails(
                  color: tagColor,
                  tagLabel: tagLabel,
                  companyName: client.name ?? 'N/A',
                  startDate: DateUtil.formatTimeAgo(client.createdAt?.toLocal()),
                  endDate: DateUtil.formatTimeAgo(client.updatedAt?.toLocal()),
                  revenueTarget: '€${client.revenueTarget ?? 0}',
                  revenueClosed: '€${client.closer?.amount ?? 0}',
                  commissionEarned: '€${client.commissionRate ?? 0}',
                  onViewDetailsTap: () => Get.to(() => NewDealView(clientId: client.id ?? '')),
                );
              },
            ),
          ],
        ),
      );
    });
  }
}


