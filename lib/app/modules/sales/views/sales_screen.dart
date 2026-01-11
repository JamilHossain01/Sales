import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:wolf_pack/app/modules/home/controllers/allDeals_controller.dart';
import 'package:wolf_pack/app/modules/home/controllers/ny_clients_controller.dart';
import 'package:wolf_pack/app/modules/home/widgets/target_widgets.dart';
import 'package:wolf_pack/app/modules/closed_deal/views/closed_deal_view.dart';
import 'package:wolf_pack/app/modules/profile/controllers/get_myProfile_controller.dart';
import 'package:wolf_pack/app/uitilies/api/app_constant.dart';
import 'package:wolf_pack/app/uitilies/app_colors.dart';
import '../../../common_widget/custom_button.dart';
import '../../../common_widget/custom_calender.dart';
import '../../home/widgets/rececnt_deatils_widgets.dart';
import 'package:wolf_pack/app/modules/open_deal/views/new_deal_view.dart';
import 'package:wolf_pack/app/modules/open_deal/views/open_deal_view.dart';
import '../../home/model/all_my_cleints_model.dart' as myClients;
import '../model/recentview_model.dart';
import 'package:wolf_pack/app/common_widget/custom_app_bar_widget.dart';
import '../../home/model/all_closed_model.dart' as allDeals;
import '../../sales/model/recentview_model.dart';
import 'add_deals.dart';

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
    // profileController.fetchMyProfile();
    // allDealController.fetchAllDeals();
  }

  String _formatCurrency(dynamic value) {
    if (value == null) return '0';
    double v =
        value is String ? double.tryParse(value) ?? 0.0 : value.toDouble();
    return NumberFormat.decimalPattern().format(v.truncate());
  }

  // Flatten the list of deals for My Deals
  List<AllRecentDealDatum> _getActiveList() {
    if (isAllDeals.value) {
      return allDealController.myClosedAllClientData.value?.data ?? [];
    } else {
      final myData = myDealController.myAllClientData.value?.data;
      if (myData == null || myData.data.isEmpty) return [];

      List<AllRecentDealDatum> deals = [];
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
            // Add dummy NEW deal
            deals.add(AllRecentDealDatum(
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
            ));
          } else {
            for (final closer in uc.closers) {
              deals.add(AllRecentDealDatum(
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
              ));
            }
          }
        }
      }

      return deals;
    }
  }

  List<AllRecentDealDatum> _applyFilters(List<AllRecentDealDatum> deals) {
    var filtered = deals;

    // Search filter
    if (_searchQuery.value.isNotEmpty) {
      filtered = filtered.where((deal) {
        final name = deal.userClient?.client?.name ?? '';
        return name.toLowerCase().contains(_searchQuery.value.toLowerCase());
      }).toList();
    }

    // Status filter
    filtered = filtered.where((deal) {
      final status = (deal.status ?? 'NEW').toUpperCase();
      if (isAllDeals.value) {
        return status == 'CLOSED';
      } else {
        if (_selectedStatus.value == 'All') return true;
        if (_selectedStatus.value == 'New') return status == 'NEW';
        return status == _selectedStatus.value.toUpperCase();
      }
    }).toList();

    // Date filter
    if (_selectedDate.value != null) {
      filtered = filtered.where((deal) {
        final dealDate = deal.dealDate;
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
        final status = (deal.status ?? 'NEW').toUpperCase();
        final tagLabel = status;

        final companyName = deal.userClient?.client?.name;
        final offer = deal.userClient?.client?.offer;
        final commissionPercent = deal.userClient?.client?.commissionRate ?? 0;
        final offerAmount = deal.amount ?? 0;
        final commissionAmount = (offerAmount * commissionPercent / 100);

        final assignDate = deal.createdAt != null
            ? DateFormat('yyyy-MM-dd hh:mm a').format(deal.createdAt!)
            : null;
        final clientDetailsViewId = deal.userClient?.clientId ?? '';
        final userName = deal.userClient?.client?.name;
        final profileImage = deal.user?.profilePicture;
        final clientId = deal.userClient?.id ?? '';

        final cashCollected = deal.cashCollected != null
            ? _formatCurrency(deal.cashCollected)
            : null;
        final amount =
            deal.amount != null ? _formatCurrency(deal.amount) : null;
        final commission =
            commissionAmount != null ? _formatCurrency(commissionAmount) : null;

        // Only assign onTap for My Deals
        VoidCallback? onTap;
        if (!isAllDeals.value && clientDetailsViewId.isNotEmpty) {
          switch (tagLabel) {
            case "NEW":
              onTap = () => Get.to(() => NewDealView(
                    clientId: clientDetailsViewId,
                    clientName: userName ?? "N/A", clientDealCreateId: clientId,
                  ));
              break;
            case "OPEN":
              onTap = () => Get.to(
                    () => OpenDealView(
                      clientId: clientDetailsViewId,
                      clientName: userName ?? "N/A", clientNewDealCreateId: clientId,
                    ),
                  );
              break;
            case "CLOSED":
              onTap = () => Get.to(
                    () => ClosedDealView(clientID: clientDetailsViewId),
                  );
              break;
          }
        }

        return RecentDetails(
          color: _getStatusColor(tagLabel),
          tagLabel: tagLabel,
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
              title: "Monthly Target",
              progressValue: ((profileController.profileData.value.data?.monthlyTargetPercentage ?? 0) / 100).toDouble(),
              achievedText: 'Achieved: €${profileController.profileData.value.data?.thisMonthSales ?? "N/A"} of €${profileController.profileData.value.data?.monthlyTarget ?? "N/A"}',
              percentageLabel: '${(profileController.profileData.value.data?.monthlyTargetPercentage ?? 0).toStringAsFixed(2)}%',
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

            CustomButton(
              leftIcon: Icon(Icons.add,color:isAllDeals.value ? Colors.black : Colors.white ,),
              isGradient: false,
              buttonColor:AppColors.orangeColor,
              titleColor: isAllDeals.value ? Colors.black : Colors.white,
              title: 'Add Deal',
              onTap: () {
                Get.to(() => AddDealView(
                ));

              },
            ),
            const Gap(20),
            _buildDealsList(),
          ],
        ),
      ),
    );
  }
}
