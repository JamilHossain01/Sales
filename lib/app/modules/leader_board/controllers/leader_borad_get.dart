import 'dart:convert';
import 'package:get/get.dart';
import '../../../common_widget/customSnackBar.dart';
import '../../../uitilies/api/api_url.dart';
import '../../../uitilies/api/base_client.dart';

class LeaderBoardGetController extends GetxController {
  var isLoading = false.obs;
  var rawData = <dynamic>[].obs;
  var currentUserId = ''.obs; // ✅ Add current user ID

  @override
  void onInit() {
    super.onInit();
    fetchLeaderBoard();
  }

  Future<void> fetchLeaderBoard() async {
    try {
      isLoading(true);
      final response = await BaseClient.getRequest(api: ApiUrl.leaderboardTop);

      if (response.statusCode == 200) {
        final data = await BaseClient.handleResponse(response);
        final List<dynamic> list = (data['data'] as List<dynamic>);
        rawData.value = list;
      } else {
        throw "Failed to load leaderboard (${response.statusCode})";
      }
    } catch (e) {
      CustomSnackbar.showError(e.toString());
    } finally {
      isLoading(false);
    }
  }

  List<dynamic> get sortedUsers {
    final sorted = [...rawData];
    sorted.sort((a, b) => (b['salesCount'] ?? 0).compareTo(a['salesCount'] ?? 0));
    return sorted.take(10).toList(); // ✅ Top 10 limit
  }

  dynamic get topUser =>
      sortedUsers.isNotEmpty ? sortedUsers.first : null; // ✅ Top 1

  List<dynamic> get otherTopUsers =>
      sortedUsers.length > 1 ? sortedUsers.sublist(1) : [];
}
