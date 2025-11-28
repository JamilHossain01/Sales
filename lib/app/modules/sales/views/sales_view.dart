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
import '../../home/model/all_closed_model.dart' as allDeals;
import '../../home/model/all_my_cleints_model.dart' as myClients;
import '../../home/widgets/rececnt_deatils_widgets.dart';

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

  List<dynamic> _getActiveList() {
    return isAllDeals.value
        ? allDealController.myClosedAllClientData.value?.data?.data ?? []
        : myDealController.myAllClientData.value?.data?.data ?? [];
  }

  List<dynamic> _applyFilters(List<dynamic> clients, bool allDealsTab) {
    var filtered = clients;

    // Search filter
    if (_searchQuery.isNotEmpty) {
      filtered = filtered.where((client) {
        final name = allDealsTab
            ? (client as allDeals.AllDealDatum).name ?? ''
            : (client as myClients.Datum).name ?? '';
        return name.toLowerCase().contains(_searchQuery.toLowerCase());
      }).toList();
    }

    // Status filter
    filtered = filtered.where((client) {
      final closers = _getClosersList(client, allDealsTab);

      if (allDealsTab) {
        // Only show CLOSED deals in All Deals
        return closers.any((c) => (c.status ?? '').toUpperCase() == 'CLOSED');
      } else {
        // My Deals tab: filter by selected status
        if (_selectedStatus == 'All') return true;
        if (_selectedStatus == 'New') return closers.isEmpty;
        return closers.isNotEmpty &&
            (closers.last.status ?? '').toUpperCase() ==
                _selectedStatus.toUpperCase();
      }
    }).toList();

    // Date filter
    if (_selectedDate != null) {
      filtered = filtered.where((client) {
        final closers = _getClosersList(client, allDealsTab);
        final dealDate = closers.isNotEmpty ? closers.last.dealDate : null;
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
        onViewDetailsTap: () {},
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
        final client = filteredList[index];
        final closers = _getClosersList(client, allDealsTab);
        final hasCloser = closers.isNotEmpty;
        final String status =
        hasCloser ? (closers.last.status ?? "New") : "New";
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

        // Only assign onTap for My Deals
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
          onViewDetailsTap: onTap, // null for All Deals → hides button
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
                        borderRadius: BorderRadius.circular(8)),
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
                      value: _selectedStatus,
                      icon: const Icon(Icons.keyboard_arrow_down,
                          color: Colors.white),
                      items: ['All', 'New', 'Open', 'Closed']
                          .map((s) => DropdownMenuItem(
                          value: s,
                          child: Text(s,
                              style: const TextStyle(color: Colors.white))))
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
                        ? Colors.amber
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


// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:gap/gap.dart';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';
// import 'package:wolf_pack/app/common_widget/custom_app_bar_widget.dart';
// import 'package:wolf_pack/app/modules/home/controllers/allDeals_controller.dart';
// import 'package:wolf_pack/app/modules/home/controllers/ny_clients_controller.dart';
// import 'package:wolf_pack/app/modules/home/widgets/target_widgets.dart';
// import 'package:wolf_pack/app/modules/open_deal/views/new_deal_view.dart';
// import 'package:wolf_pack/app/modules/open_deal/views/open_deal_view.dart';
// import 'package:wolf_pack/app/modules/closed_deal/views/closed_deal_view.dart';
// import 'package:wolf_pack/app/modules/profile/controllers/get_myProfile_controller.dart';
// import '../../../common_widget/custom_button.dart';
// import '../../../common_widget/custom_calender.dart';
// import '../../home/widgets/rececnt_deatils_widgets.dart';
//
// class SalesScreen extends StatefulWidget {
//   const SalesScreen({super.key});
//
//   @override
//   State<SalesScreen> createState() => _SalesScreenState();
// }
//
// class _SalesScreenState extends State<SalesScreen> {
//   final AllDealController allDealController = Get.put(AllDealController());
//   final MyAllClientsGetController myDealController = Get.put(MyAllClientsGetController());
//   final GetMyProfileController profileController = Get.put(GetMyProfileController());
//
//   DateTime? _selectedDate;
//   String _searchQuery = '';
//   String _selectedStatus = 'All';
//   var isAllDeals = true.obs;
//
//   @override
//   void initState() {
//     super.initState();
//     profileController.fetchMyProfile();
//     allDealController.fetchAllDeals();
//   }
//
//   String _formatCurrencyDropDecimals(dynamic value) {
//     if (value == null) return '0';
//     double v = value is String ? double.tryParse(value) ?? 0.0 : value.toDouble();
//     return NumberFormat.decimalPattern().format(v.truncate());
//   }
//
//   List<dynamic> _getActiveList() {
//     return isAllDeals.value
//         ? allDealController.myClosedAllClientData.value?.data?.data ?? []
//         : myDealController.myAllClientData.value?.data?.data ?? [];
//   }
//
//   List<dynamic> _applyFilters(List<dynamic> clients) {
//     var filtered = clients;
//
//     if (_searchQuery.isNotEmpty) {
//       filtered = filtered.where((client) {
//         final name = client.name?.toString() ?? '';
//         return name.toLowerCase().contains(_searchQuery.toLowerCase());
//       }).toList();
//     }
//
//     if (_selectedStatus != 'All') {
//       filtered = filtered.where((client) {
//         final closers = client.closer as List<dynamic>;
//         final hasCloser = closers.isNotEmpty;
//         final status = hasCloser ? (closers.last.status?.toLowerCase() ?? '') : '';
//         if (_selectedStatus == 'New') return !hasCloser;
//         return hasCloser && status == _selectedStatus.toLowerCase();
//       }).toList();
//     }
//
//     if (_selectedDate != null) {
//       filtered = filtered.where((client) {
//         final closers = client.closer as List<dynamic>;
//         final dealDate = closers.isNotEmpty ? closers.last.dealDate : null;
//         if (dealDate == null) return false;
//         return dealDate.year == _selectedDate!.year &&
//             dealDate.month == _selectedDate!.month &&
//             dealDate.day == _selectedDate!.day;
//       }).toList();
//     }
//
//     return filtered;
//   }
//
//   Color _getStatusColor(String status) {
//     switch (status.toUpperCase()) {
//       case 'NEW': return Colors.green;
//       case 'OPEN': return const Color(0xFF0094B5);
//       case 'CLOSED': return Colors.red;
//       default: return Colors.grey;
//     }
//   }
//
//   Widget _buildLoadingList() {
//     return ListView.builder(
//       physics: const NeverScrollableScrollPhysics(),
//       shrinkWrap: true,
//       itemCount: 6,
//       itemBuilder: (_, __) => RecentDetails(
//         color: Colors.grey,
//         tagLabel: 'Loading',
//         companyName: 'Loading...',
//         assignDate: 'Loading...',
//         offer: '0',
//         commissionRate: '0%',
//         onViewDetailsTap: () {},
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       appBar: CommonAppBar(title: 'Sales View'),
//       body: SingleChildScrollView(
//         padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             TargetProgressCard(
//               title: "Deals Closed",
//               progressValue: ((profileController.profileData.value.data?.monthlyTargetPercentage ?? 0) / 100).toDouble(),
//               achievedText: 'Achieved: €${profileController.profileData.value.data?.salesCount ?? "0"} of €${profileController.profileData.value.data?.monthlyTarget ?? "0"}',
//               percentageLabel: '${profileController.profileData.value.data?.monthlyTargetPercentage ?? "0"}%',
//             ),
//             Gap(20.h),
//             CustomCalendarWidget(
//               onDateSelected: (date) => setState(() => _selectedDate = date),
//               onClearDate: () => setState(() => _selectedDate = null),
//               selectedFilterDate: _selectedDate,
//             ),
//             Gap(20.h),
//             Row(
//               children: [
//                 Expanded(
//                   child: Container(
//                     height: 45.h,
//                     padding: EdgeInsets.symmetric(horizontal: 12.w),
//                     decoration: BoxDecoration(border: Border.all(color: Colors.amber), borderRadius: BorderRadius.circular(8.r)),
//                     child: Row(
//                       children: [
//                         const Icon(Icons.search, color: Colors.amber, size: 20),
//                         Gap(8.w),
//                         Expanded(
//                           child: TextField(
//                             onChanged: (v) => setState(() => _searchQuery = v),
//                             style: const TextStyle(color: Colors.white),
//                             cursorColor: Colors.amber,
//                             decoration: const InputDecoration(hintText: 'Search here..', hintStyle: TextStyle(color: Colors.amber), border: InputBorder.none),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 Gap(10.w),
//                 Container(
//                   height: 45.h,
//                   padding: EdgeInsets.symmetric(horizontal: 12.w),
//                   decoration: BoxDecoration(color: const Color(0xFF6C4D0C), borderRadius: BorderRadius.circular(8.r)),
//                   child: DropdownButtonHideUnderline(
//                     child: DropdownButton<String>(
//                       dropdownColor: const Color(0xFF6C4D0C),
//                       value: _selectedStatus,
//                       icon: const Icon(Icons.keyboard_arrow_down, color: Colors.white),
//                       items: ['All', 'New', 'Open', 'Closed'].map((s) => DropdownMenuItem(value: s, child: Text(s, style: const TextStyle(color: Colors.white)))).toList(),
//                       onChanged: (v) => setState(() => _selectedStatus = v ?? 'All'),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             Gap(20.h),
//             Row(
//               children: [
//                 Expanded(
//                   child: Obx(() => CustomButton(
//                     isGradient: false,
//                     buttonColor: isAllDeals.value ? Colors.amber : Colors.grey.shade900,
//                     titleColor: isAllDeals.value ? Colors.black : Colors.white,
//                     title: 'All Deals',
//                     onTap: () {
//                       if (!isAllDeals.value) {
//                         isAllDeals.value = true;
//                         allDealController.fetchAllDeals();
//                       }
//                     },
//                   )),
//                 ),
//                 Gap(12.w),
//                 Expanded(
//                   child: Obx(() => CustomButton(
//                     isGradient: false,
//                     buttonColor: !isAllDeals.value ? Colors.amber : Colors.grey.shade900,
//                     titleColor: !isAllDeals.value ? Colors.black : Colors.white,
//                     title: 'My Deals',
//                     onTap: () {
//                       if (isAllDeals.value) {
//                         isAllDeals.value = false;
//                         myDealController.fetchMyAllClients();
//                       }
//                     },
//                   )),
//                 ),
//               ],
//             ),
//             Gap(20.h),
//
//             // =================== Deals List ===================
//             Obx(() {
//               final bool currentTabIsAllDeals = isAllDeals.value; // এখানে ম্যাজিক – Obx এরর চলে গেছে
//               final loading = currentTabIsAllDeals ? allDealController.isLoading.value : myDealController.isLoading.value;
//
//               if (loading) return _buildLoadingList();
//
//               final List<dynamic> list = _getActiveList();
//               final filteredList = _applyFilters(list);
//
//               if (filteredList.isEmpty) {
//                 return Center(
//                   child: Padding(
//                     padding: EdgeInsets.only(top: 50.h),
//                     child: Text(
//                       _searchQuery.isNotEmpty || _selectedDate != null || _selectedStatus != 'All'
//                           ? "No matching results found"
//                           : "No deals available",
//                       style: TextStyle(color: Colors.white70, fontSize: 16.sp),
//                     ),
//                   ),
//                 );
//               }
//
//               return ListView.builder(
//                 physics: const NeverScrollableScrollPhysics(),
//                 shrinkWrap: true,
//                 itemCount: filteredList.length,
//                 itemBuilder: (context, index) {
//                   final client = filteredList[index];
//
//                   final closers = client.closer as List<dynamic>;
//                   final hasCloser = closers.isNotEmpty;
//                   final String status = hasCloser
//                       ? (closers.last.status ?? "New").toString()
//                       : "New";
//                   final String tagLabel = status.toUpperCase();
//
//                   final companyName = client.name?.toString() ?? 'Unknown';
//                   final offer = client.offer?.toString() ?? '0';
//                   final commissionRate = '${client.commissionRate ?? 0}%';
//                   final assignDate = client.createdAt != null
//                       ? DateFormat('yyyy-MM-dd hh:mm a').format(client.createdAt!)
//                       : 'N/A';
//                   final clientId = client.id?.toString() ?? '';
//
//                   // এখানে লজিক: কোন ট্যাবে আছি + কোন স্ট্যাটাস → বাটন দেখাবে কি না
//                   final bool showButton = currentTabIsAllDeals
//                       ? (tagLabel == "NEW" || tagLabel == "OPEN")
//                       : (tagLabel == "OPEN" || tagLabel == "CLOSED");
//
//                   VoidCallback? onTap;
//                   if (showButton) {
//                     onTap = () {
//                       switch (tagLabel) {
//                         case "NEW":
//                           Get.to(() => NewDealView(clientId: clientId));
//                           break;
//                         case "OPEN":
//                           Get.to(() => OpenDealView(clientId: clientId));
//                           break;
//                         case "CLOSED":
//                           Get.to(() => ClosedDealView(clientID: clientId));
//                           break;
//                       }
//                     };
//                   }
//
//                   return RecentDetails(
//                     color: _getStatusColor(tagLabel),
//                     tagLabel: tagLabel,
//                     companyName: companyName,
//                     assignDate: assignDate,
//                     offer: _formatCurrencyDropDecimals(offer),
//                     commissionRate: commissionRate,
//                     onViewDetailsTap: onTap,
//                   );
//                 },
//               );
//             }),
//           ],
//         ),
//       ),
//     );
//   }
// }
