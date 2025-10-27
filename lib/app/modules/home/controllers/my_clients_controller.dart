import 'package:get/get.dart';

import '../../../common_widget/customSnackBar.dart';
import '../../../uitilies/api/api_url.dart';
import '../../../uitilies/api/base_client.dart';
import '../model/all_my_cleints_model.dart';
import '../model/my_clients_model.dart';

class MyClientGetController extends GetxController {
  var isLoading = false.obs;
  var dealData = AllMyClientModel().obs;

  @override
  void onInit() {
    super.onInit();
    fetchMyProfile();
  }

  Future<void> fetchMyProfile() async {
    try {
      isLoading(true);
      final response = await BaseClient.getRequest(api: ApiUrl.myClients);

      if (response.statusCode == 200) {
        final data = await BaseClient.handleResponse(response);
        dealData.value = AllMyClientModel.fromJson(data);
      } else {
        throw "Failed to load profile (${response.statusCode})";
      }
    } catch (e) {
      CustomSnackbar.showError(e.toString());
      rethrow;
    } finally {
      isLoading(false);
    }
  }

  Future<void> refreshProfile() async {
    await fetchMyProfile();
  }
}