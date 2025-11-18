import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../common_widget/custom text/custom_text_widget.dart';
import '../../../uitilies/custom_loader.dart';
import '../../view_details/widgets/location_tile.dart';
import '../controllers/get_single_client.dart';
import '../../../uitilies/api/api_url.dart';
import '../../../uitilies/api/base_client.dart';
import '../model/single_client_model.dart';

class ClosedDealClintDeatilsView extends StatelessWidget {
  final String clientId;
  ClosedDealClintDeatilsView({
    super.key,
    required this.clientId,
  });

  final SingleSellerController closedClientsGetController =
  Get.put(SingleSellerController());

  /// ✅ Fixed & improved document launcher
  Future<void> _downloadDocument(String? url) async {
    if (url == null || url.isEmpty) {
      Get.snackbar('Error', 'Invalid document URL');
      return;
    }

    String fixedUrl = url.startsWith('http://') || url.startsWith('https://')
        ? url
        : 'https://$url';

    final Uri uri = Uri.parse(fixedUrl);

    try {
      final bool launched = await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      );
      if (!launched) {
        Get.snackbar('Error', 'Could not launch document');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to open link: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    closedClientsGetController.fetchSingleClient(clientId: clientId);

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

      return SingleChildScrollView(
        // padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            LocationTile(
              label: "Client Name",
              value: data.name ?? "N/A",
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
              text: data.offer ?? "N/A",
              fontSize: 16.sp,
              fontWeight: FontWeight.w300,
              color: Colors.white.withOpacity(0.82),
            ),
            Gap(10.h),
            buildRow(
              text: 'Commission Rate',
              text1: '${data.commissionRate ?? 0}%',
            ),
            Gap(10.h),
            buildRow(
              text: 'Assign Date',
              text1: data.createdAt != null
                  ? DateFormat('yyyy-MM-dd HH:mm').format(data.createdAt!)
                  : "N/A",
            ),
            if (hasCloser) ...[
              Gap(10.h),
              buildRow(
                text: 'Deal Date',
                text1: closer!.dealDate != null
                    ? DateFormat('yyyy-MM-dd HH:mm').format(closer.dealDate!)
                    : "N/A",
              ),
              Gap(10.h),
              LocationTile(
                label: 'Status',
                value: closer.status ?? "N/A",
              ),
              Gap(10.h),
              buildRow(
                text: 'Deal Prize',
                text1: '€${closer.amount ?? 0}',
              ),
              Gap(10.h),
              buildRow(
                text: 'Cash Collected',
                text1: closer.cashCollected?.toString() ?? "N/A",
              ),
              Gap(10.h),
              buildRow(
                text: 'Notes',
                text1: closer.notes ?? "N/A",
              ),
              if (closer.closerDocuments.isNotEmpty) ...[
                Gap(16.h),
                CustomText(
                  text: "Closer Documents",
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.amberAccent,
                ),
                Gap(12.h),
                ...closer.closerDocuments.map(
                      (doc) => Container(
                    margin: EdgeInsets.only(bottom: 10.h),
                    decoration: BoxDecoration(
                      color: Colors.blue.withOpacity(0.08),
                      borderRadius: BorderRadius.circular(10.r),
                      border: Border.all(color: Colors.blueAccent, width: 0.8),
                    ),
                    child: ListTile(
                      contentPadding:
                      EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
                      leading: Icon(
                        _getFileIcon(doc.path),
                        color: Colors.blueAccent,
                        size: 28.sp,
                      ),
                      title: Text(
                        doc.document ?? "Unnamed Document",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.blueAccent,
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      subtitle: Text(
                        doc.path ?? "N/A",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.7),
                          fontSize: 13.sp,
                        ),
                      ),
                      trailing: Icon(
                        Icons.open_in_new,
                        color: Colors.greenAccent,
                        size: 22.sp,
                      ),
                      onTap: () {
                        print('Tapped document: ${doc.path}');
                        _downloadDocument(doc.path);
                      },
                    ),
                  ),
                ),
              ],
            ],
          ],
        ),
      );
    });
  }

  /// 📂 Select icon based on file type
  IconData _getFileIcon(String? url) {
    if (url == null) return Icons.insert_drive_file_outlined;
    if (url.endsWith('.pdf')) return Icons.picture_as_pdf;
    if (url.endsWith('.doc') || url.endsWith('.docx')) return Icons.description;
    if (url.endsWith('.jpg') ||
        url.endsWith('.png') ||
        url.endsWith('.jpeg')) return Icons.image;
    return Icons.insert_drive_file_outlined;
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
        Flexible(
          child: CustomText(
            text: text1,
            fontWeight: FontWeight.w300,
            fontSize: 14.sp,
            color: Colors.white.withOpacity(0.82),
            textAlign: TextAlign.end,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
