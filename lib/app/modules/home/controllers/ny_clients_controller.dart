import 'package:get/get.dart';
import '../../../common_widget/customSnackBar.dart';
import '../../../uitilies/api/api_url.dart';
import '../../../uitilies/api/base_client.dart';
import '../model/all_my_cleints_model.dart';
import '../model/my_clients_model.dart';

import 'package:get/get.dart';
import '../../../common_widget/customSnackBar.dart';
import '../../../uitilies/api/api_url.dart';
import '../../../uitilies/api/base_client.dart';

class MyAllClientsGetController extends GetxController {
  var isLoading = false.obs;
  var myAllClientData = AllMyClientModel().obs;

  @override
  void onInit() {
    super.onInit();
    fetchMyAllClients();
  }

  Future<void> fetchMyAllClients() async {
    try {
      isLoading(true);
      final response = await BaseClient.getRequest(api: ApiUrl.myDeals);
      if (response.statusCode == 200) {
        final data = await BaseClient.handleResponse(response);
        // Convert the data into a model and assign it to the observable
        myAllClientData.value = AllMyClientModel.fromJson(data);
        // Print the fetched data to console for debugging
        print("Fetched client data: ${myAllClientData.value}");
        // You can also print specific fields from the data for better clarity
        // Example: print("Client name: ${myAllClientData.value.data?.data[0].name}");
      } else {
        throw "Failed to load my deals (${response.statusCode})";
      }
    } catch (e) {
      CustomSnackbar.showError(e.toString());
      rethrow;
    } finally {
      isLoading(false);
    }
  }

  Future<void> refreshMyAllClients() async {
    await fetchMyAllClients();
  }
}