import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../../../common widget/custom text/custom_text_widget.dart';
import '../../../uitilies/custom_loader.dart';
import '../../../uitilies/date_time_formate.dart';
import '../../view_details/widgets/location_tile.dart';
import '../controllers/get_single_client.dart';

import 'package:get/get.dart';
import '../../../common widget/customSnackBar.dart';
import '../../../uitilies/api/api_url.dart';
import '../../../uitilies/api/base_client.dart';
import '../model/single_client_model.dart';

class ClosedDealClintDeatilsView extends StatelessWidget {
  final String? clientName;
  final String clientId;
  final String? serviceLine1;
  final String? serviceLine2;
  final String? targetAudienceLine1;
  final String? targetAudienceLine2;
  final String? contact;
  final String? dealDate;
  final String? dealAmount;
  final String? location;
  final String? revenueTarget;
  final String? revenueClosed;
  final String? commission;
  final String? status;

  ClosedDealClintDeatilsView({
    super.key,
    this.clientName,
    this.serviceLine1,
    this.serviceLine2,
    this.targetAudienceLine1,
    this.targetAudienceLine2,
    this.contact,
    this.dealDate,
    this.dealAmount,
    this.location,
    this.revenueTarget,
    this.revenueClosed,
    this.commission,
    this.status,
    required this.clientId,
  });

  final SingleSellerController closedClientsGetController =
  Get.put(SingleSellerController());

  @override
  Widget build(BuildContext context) {
    // Fetch data when the widget is built
    closedClientsGetController.fetchSingleClient(clientId: clientId);

    return Obx(() {
      if (closedClientsGetController.isLoading.value) {
        return CustomLoader();
      }
      final data = closedClientsGetController.myAllClientData.value.data;

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          LocationTile(
            label: "Client Name",
            value: data?.name ?? "N/A",
          ),
          Gap(10.h),
          CustomText(
            text: "Service",
            fontSize: 16.sp,
            color: Colors.white.withOpacity(0.82),
          ),
          Gap(10.h),
          CustomText(
            maxLines: 5,
            text: data?.offer ?? "N/A",
            fontSize: 16.sp,
            fontWeight: FontWeight.w300,
            color: Colors.white.withOpacity(0.82),
          ),
          Gap(10.h),
          LocationTile(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: "Target Audience",
                  fontSize: 16.sp,
                  color: Colors.white.withOpacity(0.82),
                ),
                Gap(5.h),
                CustomText(
                  text: data?.targetAudience ?? "N/A",
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w300,
                  color: Colors.white.withOpacity(0.82),
                ),
              ],
            ),
          ),
          Gap(10.h),
          buildRow(text: 'Contact', text1: data?.contact ?? "N/A"),
          Gap(10.h),

          LocationTile(
            label: 'Location',
            value: data?.location ?? "N/A",
          ),
          Gap(10.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(
                text: "Revenue Target",
                fontSize: 16.sp,
                color: Colors.white.withOpacity(0.82),
              ),
              CustomText(
                text: data?.revenueTarget != null
                    ? "€${data!.revenueTarget}"
                    : "N/A",
                fontSize: 16.sp,
                fontWeight: FontWeight.w300,
                color: Colors.white.withOpacity(0.82),
              ),

            ],
          ),
          Gap(10.h),
          LocationTile(
            label: 'Revenue Closed',
            value:"€${data!.closer?.amount}",
          ),
          Gap(10.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(
                text: "Commission",
                fontSize: 16.sp,
                color: Colors.white.withOpacity(0.82),
              ),
              CustomText(
                text: data?.commissionRate.toString()?? "N/A",
                fontSize: 16.sp,
                fontWeight: FontWeight.w300,
                color: Colors.white.withOpacity(0.82),
              ),
            ],
          ),
          Gap(10.h),
          LocationTile(
            label: 'Status',
            value: data?.closer?.status ?? "N/A",
          ),
        ],
      );
    });
  }

  Widget buildRow({String? text, String? text1}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomText(
          text: text ?? '',
          fontSize: 16.sp,
          fontWeight: FontWeight.w500,
          color: Colors.white.withOpacity(0.82),
        ),
        CustomText(
          text: text1 ?? '',
          fontWeight: FontWeight.w300,
          fontSize: 14.sp,
          color: Colors.white.withOpacity(0.82),
        ),
      ],
    );
  }
}