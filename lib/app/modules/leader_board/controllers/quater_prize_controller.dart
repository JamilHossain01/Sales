import 'package:get/get.dart';
import '../../../common_widget/customSnackBar.dart';
import '../../../uitilies/api/api_url.dart';
import '../../../uitilies/api/base_client.dart';
import '../modell/all_user_prize_winner_model.dart';
import '../modell/quater_prize_model.dart';

import 'package:get/get.dart';
import '../../../common_widget/customSnackBar.dart';
import '../../../uitilies/api/api_url.dart';
import '../../../uitilies/api/base_client.dart';
import '../modell/all_user_prize_winner_model.dart';
import '../modell/quater_prize_model.dart';

class AllQuaterPrizeWinnersController extends GetxController {
  var isLoading = false.obs;
  var userPrizeWinnerList = GetQuaterPrizeWinnerModel(data: []).obs;
  var backupPrizeWinnerList = GetQuaterPrizeWinnerModel(data: []).obs;
  var visibleWinnersCount = 5.obs;
  var selectedYear = DateTime.now().year.obs;

  @override
  void onInit() {
    super.onInit();
    fetchPrizeWinners();
  }

  Future<void> fetchPrizeWinners({int? year}) async {
    try {
      isLoading(true);
      final int currentYear = year ?? DateTime.now().year;

      final response = await BaseClient.getRequest(
        api: ApiUrl.quaterPrizeWinner(year: currentYear),
      );

      if (response.statusCode == 200) {
        final data = await BaseClient.handleResponse(response);
        if (data != null) {
          final newList = GetQuaterPrizeWinnerModel.fromJson(data);
          if (newList.data.isNotEmpty) {
            userPrizeWinnerList.value = newList;
            backupPrizeWinnerList.value = newList;
            selectedYear.value = currentYear;
          } else {
            userPrizeWinnerList.value = backupPrizeWinnerList.value;
          }
        } else {
          throw "Invalid response data";
        }
      } else {
        throw "Failed to load prize winners (${response.statusCode})";
      }
    } catch (e) {
      CustomSnackbar.showError("Error fetching prize winners: $e");
      userPrizeWinnerList.value = backupPrizeWinnerList.value;
    } finally {
      isLoading(false);
    }
  }

  void loadMoreWinners() {
    if (visibleWinnersCount.value < userPrizeWinnerList.value.data.length) {
      visibleWinnersCount.value += 5;
    }
  }

  void filterByYear(int year) {
    fetchPrizeWinners(year: year);
  }

  /// ✅ Added wrapper to match your UI function call
  Future<void> fetchPrizeWinnersForYear(int year) async {
    await fetchPrizeWinners(year: year);
  }
}
