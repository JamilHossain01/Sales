import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wolf_pack/app/uitilies/custom_loader.dart';

import '../../../common_widget/custom text/custom_text_widget.dart';
import '../../../common_widget/custom_app_bar_widget.dart';
import '../../../common_widget/custom_button.dart';
import '../../../common_widget/nodata_wisgets.dart';
import '../../../uitilies/app_colors.dart';
import '../../home/controllers/ny_clients_controller.dart';
import '../../home/model/all_my_cleints_model.dart';




// Note: Likely typo, should be my_clients_controller or similar
import '../../sales/views/add_deals.dart';

class MyAllDealsScreen extends StatefulWidget {
  const MyAllDealsScreen({super.key});

  @override
  State<MyAllDealsScreen> createState() => _MyAllDealsScreenState();
}

class _MyAllDealsScreenState extends State<MyAllDealsScreen> {
  final MyAllClientsGetController controller = Get.put(MyAllClientsGetController());

  // Pagination state
  int currentPage = 1;
  final int itemsPerPage = 10;

  // Track expanded proposition per deal
  final Map<String, bool> expandedPropositions = {};

  @override
  void initState() {
    super.initState();
    controller.fetchMyAllClients();
  }

  Color _getStatusColor(String? status) {
    switch (status?.toUpperCase() ?? '') {
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

  String _formatAmount(dynamic value) {
    if (value == null) return '0';
    num n = value is String ? num.tryParse(value) ?? 0 : value;
    return NumberFormat('#,##0').format(n);
  }

  String _formatDate(DateTime? date) {
    if (date == null) return 'No date';
    return DateFormat('dd-MM-yyyy').format(date);
  }

  List<Map<String, dynamic>> _getFlattenedDeals() {
    final clients = controller.myAllClientData.value.data?.data ?? [];
    List<Map<String, dynamic>> flattened = [];

    for (var client in clients) {
      final String clientName = client.name ?? 'Unknown Client';

      for (var userClient in client.userClients) {
        for (var closer in userClient.closers) {
          flattened.add({
            'clientName': clientName,
            'deal': closer,
          });
        }
      }
    }

    // Sort by deal date descending (most recent first)
    flattened.sort((a, b) {
      DateTime? da = (a['deal'] as Closer).dealDate;
      DateTime? db = (b['deal'] as Closer).dealDate;
      if (da == null && db == null) return 0;
      if (da == null) return 1;
      if (db == null) return -1;
      return db.compareTo(da);
    });

    return flattened;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: CommonAppBar(title: 'My All Deals',),
      body: Stack(
        children: [
          Obx(() {
            if (controller.isLoading.value) {
              return  Center(
                child: CustomLoader(),
              );
            }

            final allDeals = _getFlattenedDeals();

            if (allDeals.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    NoDataWidget(text: "No deals available"),
                    Gap(20.h),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: CustomButton(
                        leftIcon: const Icon(
                          Icons.add,
                          color: Colors.white,
                        ),
                        isGradient: false,
                        buttonColor: AppColors.orangeColor,
                        titleColor: Colors.white,
                        title: 'Add Deal',
                        onTap: () {
                          Get.to(() => AddDealView());
                        },
                      ),
                    ),
                  ],
                ),
              );
            }

            // Pagination calculations
            final totalDeals = allDeals.length;
            final totalPages = totalDeals == 0 ? 1 : (totalDeals / itemsPerPage).ceil();
            final startIndex = (currentPage - 1) * itemsPerPage;
            final endIndex = (startIndex + itemsPerPage).clamp(0, totalDeals);
            final paginatedDeals = allDeals.sublist(startIndex, endIndex);

            return Column(
              children: [
                Expanded(
                  child: RefreshIndicator(
                    onRefresh: () async {
                      await controller.refreshMyAllClients();
                      setState(() {
                        currentPage = 1;
                      });
                    },
                    color: Colors.amber,
                    child: ListView.separated(

                      physics: const AlwaysScrollableScrollPhysics(),
                      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
                      itemCount: paginatedDeals.length,
                      separatorBuilder: (_, __) => Gap(12.h),
                      itemBuilder: (context, index) {
                        final item = paginatedDeals[index];
                        final String clientName = item['clientName'];
                        final Closer deal = item['deal'];

                        final String dealId = deal.id ?? index.toString();
                        final bool isExpanded = expandedPropositions[dealId] ?? false;
                        final String prop = deal.proposition ?? '';
                        final bool canExpand = prop.isNotEmpty && prop.length > 120;

                        return Container(
                          padding: EdgeInsets.all(16.w),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade900,
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CustomText(
                                      text: clientName,
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      textAlign: TextAlign.left,
                                    ),
                                    Gap(8.h),
                                    CustomText(
                                      text: 'Date: ${_formatDate(deal.dealDate)}',
                                      fontSize: 14.sp,
                                      color: Colors.white70,
                                      textAlign: TextAlign.left,
                                    ),
                                    Gap(8.h),
                                    if (prop.isNotEmpty)
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          CustomText(
                                            text: prop,
                                            fontSize: 13.sp,
                                            color: Colors.white60,
                                            maxLines: isExpanded ? null : 3,
                                            overflow: isExpanded ? TextOverflow.visible : TextOverflow.ellipsis,
                                            textAlign: TextAlign.left,
                                          ),
                                          if (canExpand)
                                            Padding(
                                              padding: EdgeInsets.only(top: 4.h),
                                              child: GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    expandedPropositions[dealId] = !isExpanded;
                                                  });
                                                },
                                                child: CustomText(
                                                  text: isExpanded ? 'Show less' : 'Read more',
                                                  fontSize: 12.sp,
                                                  color: AppColors.orangeColor,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                        ],
                                      ),
                                    Gap(8.h),
                                    Container(
                                      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
                                      decoration: BoxDecoration(
                                        color: _getStatusColor(deal.status).withOpacity(0.2),
                                        borderRadius: BorderRadius.circular(20.r),
                                      ),
                                      child: CustomText(
                                        text: deal.status?.toUpperCase() ?? 'UNKNOWN',
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w600,
                                        color: _getStatusColor(deal.status),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CustomText(
                                    text: 'Amount',
                                    fontSize: 12.sp,
                                    color: Colors.white60,
                                    textAlign: TextAlign.end,
                                  ),
                                  CustomText(
                                    text: _formatAmount(deal.amount),
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    textAlign: TextAlign.end,
                                  ),
                                  Gap(8.h),
                                  CustomText(
                                    text: 'Cash Collected',
                                    fontSize: 12.sp,
                                    color: Colors.white60,
                                    textAlign: TextAlign.end,
                                  ),
                                  CustomText(
                                    text: _formatAmount(deal.cashCollected),
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green,
                                    textAlign: TextAlign.end,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
                // Pagination controls (only shown if more than one page)
                if (totalPages > 1)
                  Container(
                    color: Colors.black,
                    padding: EdgeInsets.symmetric(vertical: 16.h),
                    child: Column(

                      children: [
                        Padding(
                          padding:  EdgeInsets.only(bottom: 16.h,left: 16.w,right: 16.w),
                          child: CustomButton(
                            leftIcon: const Icon(
                              Icons.add,
                              color: Colors.white,
                            ),
                            isGradient: false,
                            buttonColor: AppColors.orangeColor,
                            titleColor: Colors.white,
                            title: 'Add Deal',
                            onTap: () {
                              Get.to(() => AddDealView());
                            },
                          ),
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: currentPage > 1
                                  ? () {
                                setState(() {
                                  currentPage--;
                                });
                              }
                                  : null,
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.chevron_left,
                                    color: currentPage > 1 ? AppColors.orangeColor : Colors.grey,
                                    size: 24.sp,
                                  ),
                                  CustomText(
                                    text: 'Previous',
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w600,
                                    color: currentPage > 1 ? AppColors.orangeColor : Colors.grey,
                                  ),
                                ],
                              ),
                            ),
                            Gap(40.w),
                            CustomText(
                              text: 'Page $currentPage of $totalPages',
                              fontSize: 15.sp,
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                            Gap(40.w),
                            GestureDetector(
                              onTap: currentPage < totalPages
                                  ? () {
                                setState(() {
                                  currentPage++;
                                });
                              }
                                  : null,
                              child: Row(
                                children: [
                                  CustomText(
                                    text: 'Next',
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w600,
                                    color: currentPage < totalPages ? AppColors.orangeColor : Colors.grey,
                                  ),
                                  Icon(
                                    Icons.chevron_right,
                                    color: currentPage < totalPages ? AppColors.orangeColor : Colors.grey,
                                    size: 24.sp,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
              ],
            );
          }),
          // Fixed Add Deal button at the very bottom

        ],
      ),
    );
  }
}


