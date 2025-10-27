import 'package:get/get.dart';

import '../../../common_widget/customSnackBar.dart';
import '../../../uitilies/api/api_url.dart';
import '../../../uitilies/api/base_client.dart';
import '../../profile/model/setting_model.dart';

class GetMyProfileSettingController extends GetxController {
  var isLoading = false.obs;
  var profileSettingData = ProfileSettingModel().obs;

  @override
  void onInit() {
    super.onInit();
    fetchMyProfileSetting();
  }

  Future<void> fetchMyProfileSetting() async {
    try {
      isLoading(true);
      final response = await BaseClient.getRequest(api: ApiUrl.updateProfileSetting);

      if (response.statusCode == 200) {
        final data = await BaseClient.handleResponse(response);
        profileSettingData.value = ProfileSettingModel.fromJson(data);
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
    await fetchMyProfileSetting();
  }
}