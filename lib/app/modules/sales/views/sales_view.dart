import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import 'package:pet_donation/app/common%20widget/common_search_bar.dart';
import 'package:pet_donation/app/common%20widget/custom_calender.dart';
import 'package:pet_donation/app/modules/view_details/views/view_details_view.dart';
import 'package:pet_donation/app/modules/home/widgets/target_widgets.dart';
import 'package:pet_donation/app/modules/view_details/controllers/image_controller.dart';
import 'package:pet_donation/app/modules/sales/controllers/sales_controller.dart';
import 'package:pet_donation/app/modules/home/widgets/rececnt_deatils_widgets.dart';
import 'package:pet_donation/app/modules/sales/widgets/common_search_bar_with_filter.dart';
import 'package:pet_donation/app/common%20widget/custom_app_bar_widget.dart';
import 'package:pet_donation/app/uitilies/date_time_formate.dart';
import 'package:pet_donation/app/modules/home/controllers/ny_clients_controller.dart';
import 'package:pet_donation/app/modules/open_deal/views/new_deal_view.dart';
import 'package:pet_donation/app/modules/home/model/my_clients_model.dart';
import 'package:pet_donation/app/modules/profile/controllers/get_myProfile_controller.dart';
class SalesContent extends StatefulWidget {
  const SalesContent({super.key});

  @override
  State<SalesContent> createState() => _SalesContentState();
}

class _SalesContentState extends State<SalesContent> {
  final SalesController controller = Get.put(SalesController());
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

  List<Datum> _filterClients() {
    var clients = dealController.myAllClientData.value.data?.data ?? [];

    if (_searchQuery.isNotEmpty) {
      clients = clients.where((client) =>
      client.name?.toLowerCase().contains(_searchQuery.toLowerCase()) ?? false)
          .toList();
    }

    if (_selectedStatus != 'All') {
      clients = clients.where((client) =>
      (client.closer?.status?.toLowerCase() == _selectedStatus.toLowerCase()) ??
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
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TargetProgressCard(
            title: 'Monthly Target',
            progressValue: (profileController
                .profileData.value.data?.monthlyTargetPercentage ?? 0)
                .toDouble(),
            achievedText: 'Achieved: €${profileController.profileData.value.data?.salesCount ?? "N/A"} '
                'of €${profileController.profileData.value.data?.monthlyTarget ?? "N/A"}',
            percentageLabel: '${profileController.profileData.value.data?.monthlyTargetPercentage ?? "N/A"}%',
            footerMessage: "You're halfway there! 🎉",
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
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: filteredClients.length,
              itemBuilder: (context, index) {
                final client = filteredClients[index];
                final status = (client.closer?.status ?? '').toUpperCase();
                final tagLabel = status == 'CLOSED' ? 'Closed' :
                status == 'OPEN' ? 'Open' :
                status == 'NEW' ? 'New' : "New";

                return RecentDetails(
                  color: status == 'CLOSED' ? const Color(0xFFE12728) :
                  status == 'OPEN' ? const Color(0xFF0094B5) :
                  const Color(0xFF16A34A),
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
            );
          }),
        ],
      ),
    );
  }
}
