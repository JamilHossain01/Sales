
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:wolf_pack/app/modules/home/controllers/allDeals_controller.dart';
import 'package:wolf_pack/app/modules/home/controllers/ny_clients_controller.dart';
import 'package:wolf_pack/app/modules/home/widgets/target_widgets.dart';
import 'package:wolf_pack/app/modules/closed_deal/views/closed_deal_view.dart';
import 'package:wolf_pack/app/modules/profile/controllers/get_myProfile_controller.dart';
import '../../../common_widget/custom_button.dart';
import '../../../common_widget/custom_calender.dart';
import '../../home/widgets/rececnt_deatils_widgets.dart';
import 'package:wolf_pack/app/modules/open_deal/views/new_deal_view.dart';
import 'package:wolf_pack/app/modules/open_deal/views/open_deal_view.dart';
import '../../home/model/all_closed_model.dart' as allDeals;
import '../../home/model/all_my_cleints_model.dart' as myClients;
class SalesContent extends StatelessWidget {
  SalesContent({super.key});

  final AllDealController allDealController = Get.put(AllDealController());
  final MyAllClientsGetController myDealController =
  Get.put(MyAllClientsGetController());
  final GetMyProfileController profileController =
  Get.put(GetMyProfileController());

  final Rx<DateTime?> _selectedDate = Rx<DateTime?>(null);
  final RxString _searchQuery = ''.obs;
  final RxString _selectedStatus = 'All'.obs;
  final RxBool isAllDeals = true.obs;

  String _formatCurrency(dynamic value) {
    if (value == null) return '0';
    double v = value is String ? double.tryParse(value) ?? 0.0 : value.toDouble();
    return NumberFormat.decimalPattern().format(v.truncate());
  }

  Color _getStatusColor(String status) {
    switch (status.toUpperCase()) {
      case 'NEW':
        return Colors.green;
      case 'OPEN':
        return const Color(0xFF0094B5);
      case 'CLOSED':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  List<dynamic> _getClosersList(dynamic client, bool allDealsTab) {
    if (allDealsTab) {
      return (client as allDeals.AllDealDatum)
          .userClients
          .expand((uc) => uc.closers)
          .toList();
    } else {
      return (client as myClients.Datum)
          .userClients
          .expand((uc) => uc.closers)
          .toList();
    }
  }

  List<dynamic> _getActiveList(bool allDealsTab) {
    return allDealsTab
        ? allDealController.myClosedAllClientData.value?.data?.data ?? []
        : myDealController.myAllClientData.value?.data?.data ?? [];
  }

  List<dynamic> _applyFilters(List<dynamic> clients, bool allDealsTab,
      String searchQuery, String selectedStatus, DateTime? selectedDate) {
    var filtered = clients;

    // Search filter
    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((client) {
        final name = allDealsTab
            ? (client as allDeals.AllDealDatum).name ?? ''
            : (client as myClients.Datum).name ?? '';
        return name.toLowerCase().contains(searchQuery.toLowerCase());
      }).toList();
    }

    // Status filter
    filtered = filtered.where((client) {
      final closers = _getClosersList(client, allDealsTab);

      if (allDealsTab) {
        return closers.any((c) => (c.status ?? '').toUpperCase() == 'CLOSED');
      } else {
        if (selectedStatus == 'All') return true;
        if (selectedStatus == 'New') return closers.isEmpty;
        return closers.isNotEmpty &&
            (closers.last.status ?? '').toUpperCase() ==
                selectedStatus.toUpperCase();
      }
    }).toList();

    // Date filter
    if (selectedDate != null) {
      filtered = filtered.where((client) {
        final closers = _getClosersList(client, allDealsTab);
        final dealDate = closers.isNotEmpty ? closers.last.dealDate : null;
        if (dealDate == null) return false;
        return dealDate.year == selectedDate.year &&
            dealDate.month == selectedDate.month &&
            dealDate.day == selectedDate.day;
      }).toList();
    }

    return filtered;
  }

  Widget _buildLoadingList() {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: 6,
      itemBuilder: (_, __) => RecentDetails(
        color: Colors.grey,
        tagLabel: 'Loading',
        companyName: 'Loading...',
        assignDate: 'Loading...',
        offer: '0',
        commissionRate: '0%',
        onViewDetailsTap: () {},
      ),
    );
  }

  Widget _buildDealsList(bool allDealsTab, String searchQuery, String selectedStatus,
      DateTime? selectedDate) {
    final list = _getActiveList(allDealsTab);
    final filteredList = _applyFilters(list, allDealsTab, searchQuery, selectedStatus, selectedDate);

    if (filteredList.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 50),
          child: Text(
            searchQuery.isNotEmpty || selectedDate != null || selectedStatus != 'All'
                ? "No matching results found"
                : "No deals available",
            style: const TextStyle(color: Colors.white70, fontSize: 16),
          ),
        ),
      );
    }

    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: filteredList.length,
      itemBuilder: (context, index) {
        final client = filteredList[index];
        final closers = _getClosersList(client, allDealsTab);
        final hasCloser = closers.isNotEmpty;
        final String status = hasCloser ? (closers.last.status ?? "New") : "New";
        final String tagLabel = status.toUpperCase();

        final companyName = allDealsTab
            ? (client as allDeals.AllDealDatum).name ?? 'Unknown'
            : (client as myClients.Datum).name ?? 'Unknown';
        final offer = allDealsTab
            ? (client as allDeals.AllDealDatum).offer ?? '0'
            : (client as myClients.Datum).offer ?? '0';
        final commissionRate = allDealsTab
            ? '${(client as allDeals.AllDealDatum).commissionRate ?? 0}%'
            : '${(client as myClients.Datum).commissionRate ?? 0}%';
        final assignDate = allDealsTab
            ? (client as allDeals.AllDealDatum).createdAt != null
            ? DateFormat('yyyy-MM-dd hh:mm a')
            .format((client as allDeals.AllDealDatum).createdAt!)
            : 'N/A'
            : (client as myClients.Datum).createdAt != null
            ? DateFormat('yyyy-MM-dd hh:mm a')
            .format((client as myClients.Datum).createdAt!)
            : 'N/A';
        final clientId = allDealsTab
            ? (client as allDeals.AllDealDatum).id ?? ''
            : (client as myClients.Datum).id ?? '';

        VoidCallback? onTap;
        if (!allDealsTab) {
          switch (tagLabel) {
            case "NEW":
              onTap = () => Get.to(() => NewDealView(clientId: clientId));
              break;
            case "OPEN":
              onTap = () => Get.to(() => OpenDealView(clientId: clientId));
              break;
            case "CLOSED":
              onTap = () => Get.to(() => ClosedDealView(clientID: clientId));
              break;
          }
        }

        return RecentDetails(
          color: _getStatusColor(tagLabel),
          tagLabel: tagLabel,
          companyName: companyName,
          assignDate: assignDate,
          offer: _formatCurrency(offer),
          commissionRate: commissionRate,
          onViewDetailsTap: onTap,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
          () {
        final loading = isAllDeals.value
            ? allDealController.isLoading.value
            : myDealController.isLoading.value;

        if (loading) return _buildLoadingList();

        return SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TargetProgressCard(
                title: "Deals Closed",
                progressValue: ((profileController.profileData.value.data
                    ?.monthlyTargetPercentage ??
                    0) /
                    100)
                    .toDouble(),
                achievedText:
                'Achieved: €${profileController.profileData.value.data?.salesCount ?? "0"} of €${profileController.profileData.value.data?.monthlyTarget ?? "0"}',
                percentageLabel:
                '${profileController.profileData.value.data?.monthlyTargetPercentage ?? "0"}%',
              ),
              const Gap(20),
              CustomCalendarWidget(
                onDateSelected: (date) => _selectedDate.value = date,
                onClearDate: () => _selectedDate.value = null,
                selectedFilterDate: _selectedDate.value,
              ),
              const Gap(20),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 45,
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.amber),
                          borderRadius: BorderRadius.circular(8)),
                      child: Row(
                        children: [
                          const Icon(Icons.search, color: Colors.amber, size: 20),
                          const Gap(8),
                          Expanded(
                            child: TextField(
                              onChanged: (v) => _searchQuery.value = v,
                              style: const TextStyle(color: Colors.white),
                              cursorColor: Colors.amber,
                              decoration: const InputDecoration(
                                  hintText: 'Search here..',
                                  hintStyle: TextStyle(color: Colors.amber),
                                  border: InputBorder.none),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Gap(10),
                  Container(
                    height: 45,
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                        color: const Color(0xFF6C4D0C),
                        borderRadius: BorderRadius.circular(8)),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        dropdownColor: const Color(0xFF6C4D0C),
                        value: _selectedStatus.value,
                        icon: const Icon(Icons.keyboard_arrow_down,
                            color: Colors.white),
                        items: ['All', 'New', 'Open', 'Closed']
                            .map((s) => DropdownMenuItem(
                            value: s,
                            child: Text(s,
                                style:
                                const TextStyle(color: Colors.white))))
                            .toList(),
                        onChanged: (v) => _selectedStatus.value = v ?? 'All',
                      ),
                    ),
                  ),
                ],
              ),
              const Gap(20),
              Row(
                children: [
                  Expanded(
                    child: CustomButton(
                      isGradient: false,
                      buttonColor:
                      isAllDeals.value ? Colors.amber : Colors.grey.shade900,
                      titleColor: isAllDeals.value ? Colors.black : Colors.white,
                      title: 'All Deals',
                      onTap: () {
                        if (!isAllDeals.value) {
                          isAllDeals.value = true;
                          allDealController.fetchAllDeals();
                        }
                      },
                    ),
                  ),
                  const Gap(12),
                  Expanded(
                    child: CustomButton(
                      isGradient: false,
                      buttonColor:
                      !isAllDeals.value ? Colors.amber : Colors.grey.shade900,
                      titleColor: !isAllDeals.value ? Colors.black : Colors.white,
                      title: 'My Deals',
                      onTap: () {
                        if (isAllDeals.value) {
                          isAllDeals.value = false;
                          myDealController.fetchMyAllClients();
                        }
                      },
                    ),
                  ),
                ],
              ),
              const Gap(20),
              _buildDealsList(
                  isAllDeals.value,
                  _searchQuery.value,
                  _selectedStatus.value,
                  _selectedDate.value),
            ],
          ),
        );
      },
    );
  }
}




