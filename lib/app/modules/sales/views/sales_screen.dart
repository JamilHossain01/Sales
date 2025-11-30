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
import '../../home/model/all_my_cleints_model.dart' as myClients;
import '../model/recentview_model.dart';

class SalesContent extends StatefulWidget {
  const SalesContent({super.key});

  @override
  State<SalesContent> createState() => _SalesContentState();
}

class _SalesContentState extends State<SalesContent> {
  final AllDealController allDealController = Get.put(AllDealController());
  final MyAllClientsGetController myDealController =
      Get.put(MyAllClientsGetController());
  final GetMyProfileController profileController =
      Get.put(GetMyProfileController());

  Rx<DateTime?> _selectedDate = Rx<DateTime?>(null);
  RxString _searchQuery = ''.obs;
  RxString _selectedStatus = 'All'.obs;
  RxBool isAllDeals = true.obs;

  @override
  void initState() {
    super.initState();
    profileController.fetchMyProfile();
    allDealController.fetchAllDeals();
  }

  String _formatCurrency(dynamic value) {
    if (value == null) return '0';
    double v =
        value is String ? double.tryParse(value) ?? 0.0 : value.toDouble();
    return NumberFormat.decimalPattern().format(v.truncate());
  }

  List<AllRecentDealDatum> _getActiveList() {
    if (isAllDeals.value) {
      return allDealController.myClosedAllClientData.value?.data ?? [];
    } else {
      final myData = myDealController.myAllClientData.value?.data;
      if (myData == null) return [];
      return List<AllRecentDealDatum>.from(myData.data ?? []);
    }
  }

  List<AllRecentDealDatum> _applyFilters(List<AllRecentDealDatum> clients) {
    var filtered = clients;

    // Search filter
    if (_searchQuery.value.isNotEmpty) {
      filtered = filtered.where((client) {
        final name = client.user?.name ?? '';
        return name.toLowerCase().contains(_searchQuery.value.toLowerCase());
      }).toList();
    }

    // Status filter
    filtered = filtered.where((client) {
      final status = client.status ?? 'NEW';
      if (isAllDeals.value) {
        return status.toUpperCase() == 'CLOSED';
      } else {
        if (_selectedStatus.value == 'All') return true;
        if (_selectedStatus.value == 'New')
          return status.toUpperCase() == 'NEW';
        return status.toUpperCase() == _selectedStatus.value.toUpperCase();
      }
    }).toList();

    // Date filter
    if (_selectedDate.value != null) {
      filtered = filtered.where((client) {
        final dealDate = client.dealDate;
        if (dealDate == null) return false;
        return dealDate.year == _selectedDate.value!.year &&
            dealDate.month == _selectedDate.value!.month &&
            dealDate.day == _selectedDate.value!.day;
      }).toList();
    }

    return filtered;
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

  Widget _buildDealsList() {
    final list = _getActiveList();
    final filteredList = _applyFilters(list);

    if (filteredList.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 50),
          child: Text(
            _searchQuery.value.isNotEmpty ||
                    _selectedDate.value != null ||
                    _selectedStatus.value != 'All'
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
        final deal = filteredList[index];
        final status = deal.status?.toUpperCase() ?? 'NEW';
        final tagLabel = status;

        final companyName = deal.userClient?.client?.name;
        final offer =  deal.userClient?.client?.offer;
        final commissionPercent = deal.userClient?.client?.commissionRate ?? 0;
        final offerAmount = deal.amount ?? 0;

        final commissionAmount = (offerAmount * commissionPercent / 100);        final assignDate = deal.createdAt != null
            ? DateFormat('yyyy-MM-dd hh:mm a').format(deal.createdAt!)
            : null;
        final clientId = deal.id ?? '';

        final userName = deal.userClient?.client?.name;
        final profileImage = deal.user?.profilePicture;
        final cashCollected = deal.cashCollected != null ? _formatCurrency(deal.cashCollected) : null;
        final amount = deal.amount !=null ? _formatCurrency(deal.amount) : null;
        final commission = commissionAmount != null ? _formatCurrency(commissionAmount) : null;


        // Only assign onTap for My Deals
        VoidCallback? onTap;
        if (!isAllDeals.value) {
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
          // companyName: companyName,
          assignDate: assignDate,
          offer: offer,
          amount: amount,

          commissionRate: commission,
          userName: userName,
          profileImage: profileImage,
          cashCollected: cashCollected,
          onViewDetailsTap: onTap,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => SingleChildScrollView(
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
            _buildDealsList(),
          ],
        ),
      ),
    );
  }
}
