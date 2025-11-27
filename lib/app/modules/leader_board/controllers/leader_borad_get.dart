import 'dart:convert';
import 'package:get/get.dart';
import '../../../common_widget/customSnackBar.dart';
import '../../../uitilies/api/api_url.dart';
import '../../../uitilies/api/base_client.dart';


import '../modell/filter_leader_board_model.dart';



class LeaderBoardGetController extends GetxController {
  var isLoading = false.obs;
  var rawData = <Datum>[].obs;
  var currentUserId = ''.obs;

  // Filter variables
  var selectedMonth = Rxn<int>();
  var selectedYear = Rxn<int>();
  var selectedQuarter = Rxn<int>();

  @override
  void onInit() {
    super.onInit();
    fetchLeaderBoard();
  }

  /// Fetch leaderboard data from API
  Future<void> fetchLeaderBoard() async {
    try {
      isLoading(true);

      final response = await BaseClient.getRequest(
        api: ApiUrl.leaderboardTop(
          month: selectedMonth.value,
          year: selectedYear.value,
          quarter: selectedQuarter.value,
        ),
      );

      if (response.statusCode == 200) {
        final data = await BaseClient.handleResponse(response);
        final model = LeaderBoardModel.fromJson(data);

        // Ensure totalRevenue is not null
        for (var user in model.data) {
          user.totalRevenue ??= 0;
        }

        rawData.value = model.data;
      } else {
        throw "Failed to load leaderboard (${response.statusCode})";
      }
    } catch (e) {
      CustomSnackbar.showError(e.toString());
    } finally {
      isLoading(false);
    }
  }

  /// Top 10 users sorted by totalRevenue
  List<Datum> get sortedUsers {
    final sorted = [...rawData];
    sorted.sort((a, b) => (b.totalRevenue ?? 0).compareTo(a.totalRevenue ?? 0));
    return sorted.take(10).toList();
  }

  /// Top user (rank 1)
  Datum? get topUser => sortedUsers.isNotEmpty ? sortedUsers.first : null;

  /// Other top users (rank 2–10)
  List<Datum> get otherTopUsers =>
      sortedUsers.length > 1 ? sortedUsers.sublist(1) : [];

  /// Apply filters
  void applyFilters() {
    fetchLeaderBoard();
  }

  /// Refresh data manually
  void refresh() {
    fetchLeaderBoard();
  }

  /// Clear all filters
  void clearFilters() {
    selectedMonth.value = null;
    selectedYear.value = null;
    selectedQuarter.value = null;
    fetchLeaderBoard();
  }
}
