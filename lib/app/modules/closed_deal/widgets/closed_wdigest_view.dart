import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import 'package:pet_donation/app/common%20widget/custom%20text/custom_text_widget.dart';
import 'package:pet_donation/app/modules/open_deal/widgets/export_widgets.dart';
import 'package:pet_donation/app/modules/view_details/widgets/location_tile.dart';
import 'package:pet_donation/app/uitilies/app_colors.dart';
import 'package:pet_donation/app/uitilies/date_time_formate.dart';
import '../../../uitilies/custom_loader.dart';
import '../controllers/get_single_client.dart';

class ClosedViewWidgets extends StatelessWidget {
  ClosedViewWidgets({super.key});

  final SingleSellerController closedClientsGetController =
  Get.put(SingleSellerController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (closedClientsGetController.isLoading.value) {
        return  CustomLoader();
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
          buildRow(text: 'Proposition', text1: 'XYZ Coaching Academy'),
          Gap(10.h),
           LocationTile(
            label: "Deal Date",
            value:DateUtil.formatTimeAgo(data?.createdAt?.toLocal()),
          ),
          Gap(10.h),
          buildRow(text: 'Deal Amount', text1: "€${data?.closer?.amount}",),
          Gap(10.h),
           LocationTile(
            label: 'Status',
            value: data?.closer?.status ?? "N/A",
          ),
          Gap(10.h),
          CustomText(
            text: "Notes",
            fontSize: 16.sp,
            color: Colors.white.withOpacity(0.82),
          ),
          Gap(10.h),
          CustomText(
            text:data?.closer?.notes ?? "N/A",
            textAlign: TextAlign.start,
            fontSize: 16.sp,
            fontWeight: FontWeight.w300,
            color: Colors.white.withOpacity(0.82),
          ),

          Divider(color: AppColors.textGray),
          CustomText(
            text: "Document",
            fontSize: 16.sp,
            fontWeight: FontWeight.w300,
            color: Colors.white.withOpacity(0.82),
          ),
          Gap(10.h),
          ExportContainerWidgets(
            title: 'Invoice.pdf',
            butonText: 'invoice_downloaded.pdf',
            url:data?.closer?.closerDocuments[0].document?? 'N/A',

          ),
          // Gap(10.h),
          // ExportContainerWidgets(title: 'Invoice.pdf'),
          // Gap(10.h),
          // ExportContainerWidgets(title: 'Image1.jpg'),
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
