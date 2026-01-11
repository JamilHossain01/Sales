import 'package:get/get.dart';
import 'package:wolf_pack/app/modules/leader_board/modell/all_prize_model.dart';
import '../../../common_widget/customSnackBar.dart';
import '../../../uitilies/api/api_url.dart';
import '../../../uitilies/api/base_client.dart';
import '../modell/all_user_prize_winner_model.dart';
import '../modell/all_winner_model.dart';

class AllPrizeWinnerController extends GetxController {
  // loading state
  final RxBool isLoading = false.obs;

  // API response data
  final Rx<GetPrizeWinnerModel> allPrizeList =
      GetPrizeWinnerModel(data: []).obs;

  // visible item count
  final RxInt visibleWinnersCount = 5.obs;

  /// DEFAULT LOAD (current year & month)
  @override
  void onInit() {
    super.onInit();
    final now = DateTime.now();
    fetchAllPrize(
      year: now.year,
      month: now.month,
    );
  }

  /// FETCH DATA FROM API
  Future<void> fetchAllPrize({
    required int year,
    required int month,
  }) async {
    try {
      isLoading(true);

      // Clear old data BEFORE loading new
      allPrizeList.value = GetPrizeWinnerModel(data: []);
      visibleWinnersCount.value = 5;

      final response = await BaseClient.getRequest(
        api: ApiUrl.getTopPrizeWinners(
          year: year,
          month: month,
        ),
      );

      if (response.statusCode == 200) {
        final data = await BaseClient.handleResponse(response);

        if (data != null &&
            data['data'] != null &&
            (data['data'] as List).isNotEmpty) {
          allPrizeList.value = GetPrizeWinnerModel.fromJson(data);
        }
        // 👉 if data empty → nothing will be shown (EXPECTED)
      } else {
        throw "Failed to load prize winners (${response.statusCode})";
      }
    } catch (e) {
      CustomSnackbar.showError("Error fetching prize winners");
    } finally {
      isLoading(false);
    }
  }

  /// CALL WHEN USER CHANGES YEAR OR MONTH
  void refreshWinners({
    required int year,
    required int month,
  }) {
    fetchAllPrize(year: year, month: month);
  }

  /// LOAD MORE BUTTON
  void loadMoreWinners() {
    if (visibleWinnersCount.value <
        allPrizeList.value.data.length) {
      visibleWinnersCount.value += 5;
    }
  }
}
