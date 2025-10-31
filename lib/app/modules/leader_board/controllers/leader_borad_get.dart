// lib/app/modules/leader_board/controllers/leader_board_get_controller.dart

import 'dart:convert';
import 'package:get/get.dart';
import '../../../common_widget/customSnackBar.dart';
import '../../../uitilies/api/api_url.dart';
import '../../../uitilies/api/base_client.dart';

class LeaderBoardGetController extends GetxController {
  var isLoading = false.obs;
  var rawData = <dynamic>[].obs; // Dynamic List

  @override
  void onInit() {
    super.onInit();
    fetchLeaderBoard();
  }

  Future<void> fetchLeaderBoard() async {
    try {
      isLoading(true);
      print("Fetching Leaderboard...");

      final response = await BaseClient.getRequest(api: ApiUrl.leaderboardTop);

      print("Status Code: ${response.statusCode}");
      print("Raw Body: ${response.body}");

      if (response.statusCode == 200) {
        final data = await BaseClient.handleResponse(response);
        print("Full Response: ${jsonEncode(data)}");

        // API returns {"data": []} → so take data['data']
        final List<dynamic> list = (data['data'] as List<dynamic>);
        rawData.value = list;

        print("Data Loaded: ${rawData.length} users");
      } else {
        throw "Failed to load leaderboard (${response.statusCode})";
      }
    } catch (e, stack) {
      print("Error: $e\n$stack");
      CustomSnackbar.showError(e.toString());
    } finally {
      isLoading(false);
      print("Loading Finished");
    }
  }

  Future<void> refreshLeaderBoard() async => await fetchLeaderBoard();
}