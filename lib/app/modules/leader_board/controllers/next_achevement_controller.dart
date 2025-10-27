import 'package:get/get.dart';

import '../../../common_widget/customSnackBar.dart';
import '../../../uitilies/api/api_url.dart';
import '../../../uitilies/api/base_client.dart';
import '../modell/next_achievement_model.dart'; // make sure this exists

class NextAchievementGetController extends GetxController {
  var isLoading = false.obs;
  var nextAchievementsData = NextAchievementModel(data: []).obs; // Observable for achievements

  @override
  void onInit() {
    super.onInit();
    fetchNextAchievements();
  }

  Future<void> fetchNextAchievements() async {
    try {
      isLoading(true);
      final response = await BaseClient.getRequest(api: ApiUrl.nextAchievements); // new API

      if (response.statusCode == 200) {
        final data = await BaseClient.handleResponse(response);
        nextAchievementsData.value = NextAchievementModel.fromJson(data ?? {});
      } else {
        throw "Failed to load next achievements (${response.statusCode})";
      }
    } catch (e) {
      CustomSnackbar.showError(e.toString());
      rethrow;
    } finally {
      isLoading(false);
    }
  }

  Future<void> refreshNextAchievements() async {
    await fetchNextAchievements();
  }
}
