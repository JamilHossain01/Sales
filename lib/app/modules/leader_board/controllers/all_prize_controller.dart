import 'package:get/get.dart';
import 'package:wolf_pack/app/modules/leader_board/modell/all_prize_model.dart';
import '../../../common widget/customSnackBar.dart';
import '../../../uitilies/api/api_url.dart';
import '../../../uitilies/api/base_client.dart';
import '../modell/all_user_prize_winner_model.dart';

class AllPrizeController extends GetxController {
  var isLoading = false.obs;
  var allPrizeList  = AllPrizeModel(data: []).obs;
  var visibleWinnersCount = 5.obs;

  @override
  void onInit() {
    super.onInit();
    fetchAllPrize();
  }

  Future<void> fetchAllPrize() async {
    try {
      isLoading(true);
      final response = await BaseClient.getRequest(api: ApiUrl.allPrizewinner);

      if (response.statusCode == 200) {
        final data = await BaseClient.handleResponse(response);
        if (data != null) {
          allPrizeList .value = AllPrizeModel.fromJson(data);
        } else {
          throw "Invalid response data";
        }
      } else {
        throw "Failed to load prize winners (${response.statusCode})";
      }
    } catch (e) {
      CustomSnackbar.showError("Error fetching prize winners: $e");
    } finally {
      isLoading(false);
    }
  }

  void loadMoreWinners() {
    if (visibleWinnersCount.value < allPrizeList.value.data.length) {
      visibleWinnersCount.value += 5;
    }
  }
}