import 'package:get/get.dart';
import '../../../common_widget/customSnackBar.dart';
import '../../../uitilies/api/api_url.dart';
import '../../../uitilies/api/base_client.dart';
import '../../sales/model/recentview_model.dart';



class AllDealController extends GetxController {
  var isLoading = false.obs;

  // All deals stored here
  var myClosedAllClientData = Rxn<RecentDealModel>();

  @override
  void onInit() {
    super.onInit();
    fetchAllDeals();
  }

  Future<void> fetchAllDeals() async {
    try {
      isLoading(true);

      final response = await BaseClient.getRequest(api: ApiUrl.recentDeals);

      if (response.statusCode == 200) {
        final jsonData = await BaseClient.handleResponse(response);

        myClosedAllClientData.value = RecentDealModel.fromJson(jsonData);

        print("All Deals Loaded: ${myClosedAllClientData.value?.data.length ?? 0}");
      } else {
        throw "Failed to load All Deals (${response.statusCode})";
      }

    } catch (e) {
      CustomSnackbar.showError("Failed to load All Deals: $e");
      print("Error: $e");
    } finally {
      isLoading(false);
    }
  }
}
