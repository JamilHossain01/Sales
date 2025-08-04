import 'package:get/get.dart';

import '../../../common widget/customSnackBar.dart';
import '../../../uitilies/api/api_url.dart';
import '../../../uitilies/api/base_client.dart';
import '../model/profile_model.dart';

class GetMyProfileController extends GetxController {
  var isLoading = false.obs;
  var profileData = ProfileModel().obs;

  @override
  void onInit() {
    super.onInit();
    fetchMyProfile();
  }

  Future<void> fetchMyProfile() async {
    try {
      isLoading(true);
      final response = await BaseClient.getRequest(api: ApiUrl.myProfile);

      if (response.statusCode == 200) {
        final data = await BaseClient.handleResponse(response);
        profileData.value = ProfileModel.fromJson(data);
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