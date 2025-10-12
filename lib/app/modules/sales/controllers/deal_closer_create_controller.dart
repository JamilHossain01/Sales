import 'dart:convert';
import 'dart:io';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:get_storage/get_storage.dart';
import 'package:wolf_pack/app/routes/app_pages.dart';
import 'package:wolf_pack/app/uitilies/api/api_url.dart';
import '../../../common widget/customSnackBar.dart';
import '../../../uitilies/api/app_constant.dart';

class DealController extends GetxController {
  final isLoading = false.obs;

  Future<void> createDeal({
    required String proposition,
    required String dealDate,
    required String clientId,
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

      // 📦 Bundle all required data into the `data` field
      String dataJson = jsonEncode({
        'proposition': proposition,
        'clientId': clientId,
        'dealDate': dealDate,
        'amount': amount,
        'notes': notes,
      });

      var request = http.MultipartRequest(
        'POST',
        Uri.parse(ApiUrl.closerCreate),
      );

      request.headers.addAll({
        'Authorization': 'Bearer $accessToken',
        'Accept': 'application/json',
      });

      request.fields['data'] = dataJson;

      if (filePath.isNotEmpty) {
        var file = await http.MultipartFile.fromPath('files', filePath);
        request.files.add(file);
      }

      print('--- REQUEST ---');
      print('URL: ${request.url}');
      print('Headers: ${request.headers}');
      print('Fields: ${request.fields}');
      print('Files: ${request.files.map((f) => f.filename).toList()}');

      var response = await request.send();
      var responseData = await http.Response.fromStream(response);

      print('--- RESPONSE ---');
      print('Status Code: ${response.statusCode}');
      print('Body: ${responseData.body}');

      if (responseData.statusCode == 200 || responseData.statusCode == 201) {
        final decoded = jsonDecode(responseData.body);
        final message = decoded['message'] ?? 'Deal created successfully!';
        CustomSnackbar.showSuccess(message);
        Get.offAllNamed(Routes.DASHBOARD);
      } else {
        final decoded = jsonDecode(responseData.body);
        final message = decoded['message'] ?? 'Something went wrong!';
        CustomSnackbar.showError(message);
      }
    } catch (e) {
      CustomSnackbar.showError('An error occurred: $e');
    } finally {
      isLoading(false);
    }
  }

}
