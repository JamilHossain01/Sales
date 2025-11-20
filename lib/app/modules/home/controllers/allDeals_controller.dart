import 'package:get/get.dart';
import '../../../common_widget/customSnackBar.dart';
import '../../../uitilies/api/api_url.dart';
import '../../../uitilies/api/base_client.dart';
import '../model/all_closed_model.dart';
import '../model/all_deal_model.dart';
import '../model/my_clients_model.dart';

// file: lib/app/modules/home/controllers/allDeals_controller.dart

import 'package:get/get.dart';
import '../../../common_widget/customSnackBar.dart';
import '../../../uitilies/api/api_url.dart';
import '../../../uitilies/api/base_client.dart';
import '../model/all_deal_model.dart';

class AllDealController extends GetxController {
  var isLoading = false.obs;
  var myAllClientData = Rxn<ClosedAllDealModel>(); // সঠিক মডেল

  @override
  void onInit() {
    super.onInit();
    fetchAllDeals(); // প্রথমবার লোড
  }

  Future<void> fetchAllDeals() async {
    try {
      isLoading(true);
      final response = await BaseClient.getRequest(api: ApiUrl.allDeals);

      if (response.statusCode == 200) {
        final jsonData = await BaseClient.handleResponse(response);
        myAllClientData.value = ClosedAllDealModel.fromJson(jsonData);
        print("All Deals লোড হয়েছে: ${myAllClientData.value?.data?.data?.length ?? 0} টি");
      } else {
        throw "Failed to load All Deals (${response.statusCode})";
      }
    } catch (e) {
      CustomSnackbar.showError("All Deals লোড করতে সমস্যা: $e");
      print(e);
    } finally {
      isLoading(false);
    }
  }
}