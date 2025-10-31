import 'dart:convert';
import 'dart:io';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:get_storage/get_storage.dart';
import 'package:wolf_pack/app/routes/app_pages.dart';
import 'package:wolf_pack/app/uitilies/api/api_url.dart';
import '../../../common_widget/customSnackBar.dart';
import '../../../uitilies/api/app_constant.dart';

class DealController extends GetxController {
  final isLoading = false.obs;

  // ← এই ফাংশন যোগ করুন
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
        'clientId': clientId,
        'cashCollected': cashCollected,
        'dealDate': _formatDateForApi(dealDate), // ← এই লাইন চেঞ্জ
        'amount': amount,
        'notes': notes,
      });

      var request = http.MultipartRequest('POST', Uri.parse(ApiUrl.closerCreate));
      request.headers.addAll({
        'Authorization': 'Bearer $accessToken',
        'Accept': 'application/json',
      });
      request.fields['data'] = dataJson;

      if (filePath.isNotEmpty) {
        var file = await http.MultipartFile.fromPath('files', filePath);
        request.files.add(file);
      }

      var response = await request.send();
      var responseData = await http.Response.fromStream(response);

      if (responseData.statusCode == 200 || responseData.statusCode == 201) {
        final decoded = jsonDecode(responseData.body);
        CustomSnackbar.showSuccess(decoded['message'] ?? 'Deal created!');
        Get.offAllNamed(Routes.DASHBOARD);
      } else {
        final decoded = jsonDecode(responseData.body);
        CustomSnackbar.showError(decoded['message'] ?? 'Failed!');
      }
    } catch (e) {
      CustomSnackbar.showError('Error: $e');
    } finally {
      isLoading(false);
    }
  }
}