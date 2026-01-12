import 'dart:convert';
import 'dart:io';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:get_storage/get_storage.dart';
import 'package:wolf_pack/app/routes/app_pages.dart';
import 'package:wolf_pack/app/uitilies/api/api_url.dart';
import '../../../common_widget/customSnackBar.dart';
import '../../../common_widget/successfull_view.dart';
import '../../../uitilies/api/app_constant.dart';
import '../../dashboard/views/dashboard_view.dart';

import 'dart:convert';
import 'dart:io';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:get_storage/get_storage.dart';
import 'package:wolf_pack/app/routes/app_pages.dart';
import 'package:wolf_pack/app/uitilies/api/api_url.dart';
import '../../../common_widget/customSnackBar.dart';
import '../../../uitilies/api/app_constant.dart';
import '../../dashboard/views/dashboard_view.dart';

class DealController extends GetxController {
  final isLoading = false.obs;

  // Format date for API
  String _formatDateForApi(String inputDate) {
    final parts = inputDate.split('-');
    if (parts.length != 3) return inputDate;
    return '${parts[2]}-${parts[1].padLeft(2, '0')}-${parts[0].padLeft(2, '0')}';
  }

  Future<void> createDeal({
    required String proposition,
    required String dealDate,
    required String clientId,
    required int cashCollected,
    required int amount,
    required String notes,
    required String filePath,
  }) async {
    isLoading(true);

    try {
      final box = GetStorage();
      final accessToken = box.read(AppConstant.accessToken);

      if (accessToken == null) {
        throw Exception('Access token not found');
      }

      String dataJson = jsonEncode({
        'proposition': proposition,
        'userClientId': clientId, // ✅ correct key
        'cashCollected': cashCollected,
        'dealDate': _formatDateForApi(dealDate),
        'amount': amount,
        'notes': notes,
      });


      print('--- Request Data ---');
      print(dataJson);

      var request = http.MultipartRequest('POST', Uri.parse(ApiUrl.closerCreate));
      request.headers.addAll({
        'Authorization': 'Bearer $accessToken',
        'Accept': 'application/json',
      });
      request.fields['data'] = dataJson;

      if (filePath.isNotEmpty) {
        var file = await http.MultipartFile.fromPath('files', filePath);
        request.files.add(file);
        print('File added: $filePath');
      }

      var response = await request.send();
      var responseData = await http.Response.fromStream(response);

      print('--- Response Status ---');
      print(responseData.statusCode);
      print('--- Response Body ---');
      print(responseData.body);

      if (responseData.statusCode == 200 || responseData.statusCode == 201) {
        final decoded = jsonDecode(responseData.body);
        print('Success: $decoded');
        // CustomSnackbar.showSuccess(decoded['message'] ?? 'Deal created!');
        Get.offAll(() => CustomSuccessScreen(
          title: 'Deal Created Successfully!',
          message: 'The new deal has been added to the system.',
          onContinue: () {
            // Example: Go back to dashboard or clients list
            Get.offAll(() => DashboardView());
            // Or Get.offAll(() => AllClientsScreen());
          },
        ));

      } else {
        final decoded = jsonDecode(responseData.body);
        print('Error: $decoded');
        CustomSnackbar.showError(decoded['message'] ?? 'Failed!');
      }
    } catch (e) {
      print('Exception caught: $e');
      CustomSnackbar.showError('Error: $e');
    } finally {
      isLoading(false);
    }
  }
}
