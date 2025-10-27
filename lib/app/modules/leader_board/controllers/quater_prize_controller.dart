import 'package:get/get.dart';
import '../../../common_widget/customSnackBar.dart';
import '../../../uitilies/api/api_url.dart';
import '../../../uitilies/api/base_client.dart';
import '../modell/all_user_prize_winner_model.dart';
import '../modell/quater_prize_model.dart';

class AllQuaterPrizeWinnersController extends GetxController {
  var isLoading = false.obs;
  var userPrizeWinnerList  = GetQuaterPrizeWinnerModel(data: []).obs;
  var visibleWinnersCount = 5.obs;

  @override
  void onInit() {
    super.onInit();
    fetchPrizeWinners();
  }

  Future<void> fetchPrizeWinners() async {
    try {
      isLoading(true);
      final response = await BaseClient.getRequest(api: ApiUrl.quaterPrizeWinner);

      if (response.statusCode == 200) {
        final data = await BaseClient.handleResponse(response);
        if (data != null) {
          userPrizeWinnerList .value = GetQuaterPrizeWinnerModel.fromJson(data);
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
    if (visibleWinnersCount.value < userPrizeWinnerList.value.data.length) {
      visibleWinnersCount.value += 5;
    }
  }
}