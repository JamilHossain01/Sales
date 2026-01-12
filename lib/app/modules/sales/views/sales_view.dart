import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:wolf_pack/app/common_widget/custom_app_bar_widget.dart';
import 'package:wolf_pack/app/modules/home/controllers/allDeals_controller.dart';
import 'package:wolf_pack/app/modules/home/controllers/ny_clients_controller.dart';
import 'package:wolf_pack/app/modules/home/widgets/target_widgets.dart';
import 'package:wolf_pack/app/modules/open_deal/views/new_deal_view.dart';
import 'package:wolf_pack/app/modules/open_deal/views/open_deal_view.dart';
import 'package:wolf_pack/app/modules/closed_deal/views/closed_deal_view.dart';
import 'package:wolf_pack/app/modules/profile/controllers/get_myProfile_controller.dart';
import '../../../common_widget/custom_button.dart';
import '../../../common_widget/custom_calender.dart';
import '../../../uitilies/app_colors.dart';
import '../../home/model/all_closed_model.dart' as allDeals;
import '../../home/model/all_my_cleints_model.dart' as myClients;
import '../../home/widgets/rececnt_deatils_widgets.dart';
import '../model/recentview_model.dart';
import 'add_deals.dart';

class SalesScreen extends StatefulWidget {
  const SalesScreen({super.key});

  @override
  State<SalesScreen> createState() => _SalesScreenState();
}

class _SalesScreenState extends State<SalesScreen> {
  final AllDealController allDealController = Get.put(AllDealController());
  final MyAllClientsGetController myDealController =
      Get.put(MyAllClientsGetController());
  final GetMyProfileController profileController =
      Get.put(GetMyProfileController());
  DateTime? _selectedDate;
  String _searchQuery = '';
  String _selectedStatus = 'All';
  var isAllDeals = true.obs;

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
      return _getMyDealsFlattened();
    }
  }

  List<AllRecentDealDatum> _getMyDealsFlattened() {
    final myData = myDealController.myAllClientData.value?.data;
    if (myData == null || myData.data.isEmpty) return [];
    List<AllRecentDealDatum> deals = <AllRecentDealDatum>[];
    for (final client in myData.data) {
      final clientObj = Client(
        id: client.id,
        name: client.name,
        offer: client.offer,
        accountNumber: client.accountNumber,
        agencyRate: client.agencyRate,
        commissionRate: client.commissionRate,
        createdAt: client.createdAt,
        updatedAt: client.updatedAt,
      );
      for (final uc in client.userClients) {
        final allUserClient = UserClient(
          id: uc.id,
          userId: uc.userId,
          clientId: uc.clientId,
          createdAt: uc.createdAt,
          updatedAt: uc.updatedAt,
          client: clientObj,
        );
        if (uc.closers.isEmpty) {
          // Add a dummy NEW deal if no closers exist
          deals.add(
            AllRecentDealDatum(
              id: 'dummy-${uc.id}',
              userId: uc.userId,
              userClientId: uc.id,
              proposition: '',
              dealDate: null,
              status: 'NEW',
              amount: 0,
              cashCollected: 0,
              notes: '',
              createdAt: uc.createdAt,
              updatedAt: uc.updatedAt,
              userClient: allUserClient,
              closerDocuments: [],
              user: null,
            ),
          );
        } else {
          for (final closer in uc.closers) {
            deals.add(
              AllRecentDealDatum(
                id: closer.id,
                userId: closer.userId,
                userClientId: closer.userClientId,
                proposition: closer.proposition,
                dealDate: closer.dealDate,
                status: closer.status,
                amount: closer.amount,
                cashCollected: closer.cashCollected,
                notes: closer.notes,
                createdAt: closer.createdAt,
                updatedAt: closer.updatedAt,
                userClient: allUserClient,
                closerDocuments: List<dynamic>.from(closer.closerDocuments),
                user: null,
              ),
            );
          }
        }
      }
    }
    print("Flattened deals count: ${deals.length}");
    return deals;
  }

  List<AllRecentDealDatum> _applyFilters(
      List<AllRecentDealDatum> deals, bool allDealsTab) {
    var filtered = deals;
    // Search filter
    if (_searchQuery.isNotEmpty) {
      filtered = filtered.where((deal) {
        final name = deal.userClient?.client?.name ?? '';
        return name.toLowerCase().contains(_searchQuery.toLowerCase());
      }).toList();
    }
    // Status filter
    filtered = filtered.where((deal) {
      final status = deal.status?.toUpperCase() ?? 'NEW';
      if (allDealsTab) return status == 'CLOSED';
      if (_selectedStatus == 'All') return true;
      if (_selectedStatus == 'New') return status == 'NEW';
      return status == _selectedStatus.toUpperCase();
    }).toList();
    // Date filter
    if (_selectedDate != null) {
      filtered = filtered.where((deal) {
        final dealDate = deal.dealDate;
        if (dealDate == null) return false;
        return dealDate.year == _selectedDate!.year &&
            dealDate.month == _selectedDate!.month &&
            dealDate.day == _selectedDate!.day;
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
      ),
    );
  }

  Widget _buildDealsList(bool allDealsTab) {
    final list = _getActiveList();
    final filteredList = _applyFilters(list, allDealsTab);
    if (filteredList.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 50),
          child: Text(
            _searchQuery.isNotEmpty ||
                    _selectedDate != null ||
                    _selectedStatus != 'All'
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
        final offer = deal.userClient?.client?.offer;
        final commissionPercent = deal.userClient?.client?.commissionRate ?? 0;
        final offerAmount = deal.amount ?? 0;
        final commissionAmount = (offerAmount * commissionPercent / 100);
        final assignDate = deal.createdAt != null
            ? DateFormat('yyyy-MM-dd hh:mm a').format(deal.createdAt!)
            : null;
        final clientId = deal.userClient?.id ?? '';
        final clientDetailsViewId = deal.userClient?.clientId ?? '';
        final userName = deal.userClient?.client?.name;
        final profileImage = deal.user?.profilePicture;
        final cashCollected = deal.cashCollected != null
            ? _formatCurrency(deal.cashCollected)
            : null;
        final amount =
            deal.amount != null ? _formatCurrency(deal.amount) : null;
        final commission =
            commissionAmount != null ? _formatCurrency(commissionAmount) : null;
        // Only assign onTap for My Deals
        VoidCallback? onTap;
        if (!allDealsTab) {
          switch (tagLabel) {
            case "NEW":
              onTap = () => Get.to(() => NewDealView(
                    clientId: clientDetailsViewId,
                    clientName: userName ?? "N/A",
                  ));
              break;
            case "OPEN":
              onTap = () => Get.to(
                    () => OpenDealView(
                      clientNewDealCreateId: clientId,
                      clientId: clientDetailsViewId,
                      clientName: userName ?? "N/A",
                    ),
                  );
              break;
            case "CLOSED":
              onTap = () =>
                  Get.to(() => ClosedDealView(clientID: clientDetailsViewId));
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
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: CommonAppBar(title: 'Sales View'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TargetProgressCard(
              title: "Monthly Target",
              progressValue: ((profileController.profileData.value.data
                              ?.monthlyTargetPercentage ??
                          0) /
                      100)
                  .toDouble(),
              achievedText:
                  'Achieved: €${profileController.profileData.value.data?.thisMonthSales ?? "N/A"} of €${profileController.profileData.value.data?.monthlyTarget ?? "N/A"}',
              percentageLabel:
                  '${(profileController.profileData.value.data?.monthlyTargetPercentage ?? 0).toStringAsFixed(2)}%',
            ),
            const Gap(20),
            CustomCalendarWidget(
              onDateSelected: (date) => setState(() => _selectedDate = date),
              onClearDate: () => setState(() => _selectedDate = null),
              selectedFilterDate: _selectedDate,
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
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.search, color: Colors.amber, size: 20),
                        const Gap(8),
                        Expanded(
                          child: TextField(
                            onChanged: (v) => setState(() => _searchQuery = v),
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
                const Gap(10),
                Container(
                  height: 45,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    color: const Color(0xFF6C4D0C),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      dropdownColor: const Color(0xFF6C4D0C),
                      value: _selectedStatus,
                      icon: const Icon(Icons.keyboard_arrow_down,
                          color: Colors.white),
                      items: ['All', 'New', 'Open', 'Closed']
                          .map((s) => DropdownMenuItem(
                                value: s,
                                child: Text(s,
                                    style:
                                        const TextStyle(color: Colors.white)),
                              ))
                          .toList(),
                      onChanged: (v) =>
                          setState(() => _selectedStatus = v ?? 'All'),
                    ),
                  ),
                ),
              ],
            ),
            const Gap(20),
            Row(
              children: [
                Expanded(
                  child: Obx(() => CustomButton(
                        isGradient: false,
                        buttonColor: isAllDeals.value
                            ? AppColors.orangeColor
                            : Colors.grey.shade900,
                        titleColor:
                            isAllDeals.value ? Colors.black : Colors.white,
                        title: 'All Deals',
                        onTap: () {
                          if (!isAllDeals.value) {
                            isAllDeals.value = true;
                            allDealController.fetchAllDeals();
                          }
                        },
                      )),
                ),
                const Gap(12),
                Expanded(
                  child: Obx(() => CustomButton(
                        isGradient: false,
                        buttonColor: !isAllDeals.value
                            ? Colors.amber
                            : Colors.grey.shade900,
                        titleColor:
                            !isAllDeals.value ? Colors.black : Colors.white,
                        title: 'My Deals',
                        onTap: () {
                          if (isAllDeals.value) {
                            isAllDeals.value = false;
                            myDealController.fetchMyAllClients();
                          }
                        },
                      )),
                ),
              ],
            ),
            const Gap(20),
            CustomButton(
              isGradient: false,
              buttonColor: Color(0xFF3AE600),
              titleColor: Colors.white,
              title: 'ADD DEAL',
              onTap: () {
                Get.to(() => AddDealView());
              },
            ),
            const Gap(20),
            Obx(() {
              final loading = isAllDeals.value
                  ? allDealController.isLoading.value
                  : myDealController.isLoading.value;
              if (loading) return _buildLoadingList();
              return _buildDealsList(isAllDeals.value);
            }),
          ],
        ),
      ),
    );
  }
}
