import 'package:get/get.dart';
import 'package:wolf_pack/app/modules/badges/model/badges_model.dart';

import '../../../common_widget/customSnackBar.dart';
import '../../../uitilies/api/api_url.dart';
import '../../../uitilies/api/base_client.dart';

class BadgesController extends GetxController {
  var isLoading = false.obs;
  var badgesData = Badges().obs;

  @override
  void onInit() {
    super.onInit();
    fetchMyProfile();
  }

  Future<void> fetchMyProfile() async {
    try {
      isLoading(true);
      final response = await BaseClient.getRequest(api: ApiUrl.badges);

      if (response.statusCode == 200) {
        final data = await BaseClient.handleResponse(response);
        badgesData.value = Badges.fromJson(data);
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
