import 'package:get/get.dart';

import '../../../common_widget/customSnackBar.dart';
import '../../../uitilies/api/api_url.dart';
import '../../../uitilies/api/base_client.dart';
import '../modell/leader_board_model.dart';

class LeaderBoardController extends GetxController {
  var isLoading = false.obs;
  var leaderBoardData = LeaderBoardModel().obs;
  var othersVisibleCount = 5.obs; // 👈 for other performers pagination


  @override
  void onInit() {
    super.onInit();
    fetchMyProfile();
  }

  Future<void> fetchMyProfile() async {
    try {
      isLoading(true);
      final response = await BaseClient.getRequest(api: ApiUrl.leaderboard);

      if (response.statusCode == 200) {
        final data = await BaseClient.handleResponse(response);
        leaderBoardData.value = LeaderBoardModel.fromJson(data);
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
  void loadMoreOthers() {
    othersVisibleCount.value += 5;
  }
}
