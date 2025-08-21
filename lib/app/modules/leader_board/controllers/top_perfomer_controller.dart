import 'package:get/get.dart';

import '../../../common widget/customSnackBar.dart';
import '../../../uitilies/api/api_url.dart';
import '../../../uitilies/api/base_client.dart';
import '../modell/top_perfomer_model.dart';

class TopPerformersGetController extends GetxController {
  var isLoading = false.obs;
  var topPerformersData = TopPerformersModel(data: []).obs; // Observable for top performers data

  @override
  void onInit() {
    super.onInit();
    fetchTopPerformers();
  }

  Future<void> fetchTopPerformers() async {
    try {
      isLoading(true);
      final response = await BaseClient.getRequest(api: ApiUrl.topPerformers);

      if (response.statusCode == 200) {
        final data = await BaseClient.handleResponse(response);
        topPerformersData.value = TopPerformersModel.fromJson(data ?? {});
      } else {
        throw "Failed to load top performers (${response.statusCode})";
      }
    } catch (e) {
      CustomSnackbar.showError(e.toString());
      rethrow;
    } finally {
      isLoading(false);
    }
  }

  Future<void> refreshTopPerformers() async {
    await fetchTopPerformers();
  }
}