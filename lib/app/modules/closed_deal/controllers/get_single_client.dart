 import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:pet_donation/app/uitilies/api/api_url.dart';
import 'dart:convert';
import '../../../uitilies/api/base_client.dart';
import '../model/single_client_model.dart';

class SingleSellerController extends GetxController {
  var isLoading = false.obs;
  var myAllClientData = SingleClientModel().obs;

  Future<void> fetchSingleClient( {required String clientId}) async {
    try {
      isLoading(true);


      http.Response response = await BaseClient.getRequest(
        api: ApiUrl.singleClients(clientId: clientId),
        params: null, // No query parameters needed for this endpoint
      );

      final responseData = await BaseClient.handleResponse(response);

      myAllClientData.value = SingleClientModel.fromJson(responseData);

    } catch (e) {
      Get.snackbar(
        'Error',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      // Set loading to false
      isLoading(false);
    }
  }


}