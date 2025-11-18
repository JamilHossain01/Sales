import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:wolf_pack/app/modules/open_deal/widgets/export_widgets.dart';
import 'package:wolf_pack/app/modules/view_details/widgets/location_tile.dart';
import 'package:wolf_pack/app/uitilies/app_colors.dart';
import 'package:wolf_pack/app/uitilies/date_time_formate.dart';
import '../../../common_widget/custom text/custom_text_widget.dart';
import '../../../uitilies/custom_loader.dart';
import '../controllers/get_single_client.dart';
import '../model/single_client_model.dart';

class ClosedViewWidgets extends StatelessWidget {
  ClosedViewWidgets({super.key});

  final SingleSellerController closedClientsGetController = Get.put(SingleSellerController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (closedClientsGetController.isLoading.value) {
        return CustomLoader();
      }

      final data = closedClientsGetController.myAllClientData.value.data;
      if (data == null) {
        return const Center(child: Text("No data available"));
      }

      final hasCloser = data.closer.isNotEmpty;
      final closer = hasCloser ? data.closer.last : null;

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          LocationTile(
            label: "Client Name",
            value: data.name ?? "N/A",
          ),
          Gap(10.h),
          buildRow(
            text: 'Proposition',
            text1: closer?.proposition ?? "N/A",
          ),
          Gap(10.h),
          LocationTile(
            label: "Deal Date",
            value: closer?.dealDate != null ? DateUtil.formatTimeAgo(closer!.dealDate!.toLocal()) : "N/A",
          ),
          Gap(10.h),
          buildRow(
            text: 'Deal Amount',
            text1: "€${closer?.amount ?? 0}",
          ),
          Gap(10.h),
          LocationTile(
            label: 'Status',
            value: closer?.status ?? "N/A",
          ),
          Gap(10.h),
          CustomText(
            text: "Notes",
            fontSize: 16.sp,
            color: Colors.white.withOpacity(0.82),
          ),
          Gap(10.h),
          CustomText(
            text: closer?.notes ?? "N/A",
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
          if (closer?.closerDocuments.isNotEmpty ?? false) ...[
            ...closer!.closerDocuments.map((doc) => Column(
              children: [
                ExportContainerWidgets(
                  title: doc.document ?? 'Document',
                  butonText: doc.path ?? 'document_downloaded.pdf',
                  url: doc.path ?? 'N/A',
                ),
                Gap(10.h),
              ],
            )),
          ] else ...[
            ExportContainerWidgets(
              title: 'No Documents',
              butonText: 'N/A',
              url: 'N/A',
            ),
          ],
        ],
      );
    });
  }

  Widget buildRow({
    required String text,
    required String text1,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomText(
          text: text,
          fontSize: 16.sp,
          fontWeight: FontWeight.w500,
          color: Colors.white.withOpacity(0.82),
        ),
        CustomText(
          text: text1,
          fontWeight: FontWeight.w300,
          fontSize: 14.sp,
          color: Colors.white.withOpacity(0.82),
        ),
      ],
    );
  }
}