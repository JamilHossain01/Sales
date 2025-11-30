import 'dart:convert';
import 'package:get/get.dart';
import '../../../common_widget/customSnackBar.dart';
import '../../../uitilies/api/api_url.dart';
import '../../../uitilies/api/base_client.dart';


import '../modell/filter_leader_board_model.dart';



import 'dart:convert';
import 'package:get/get.dart';
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

      final url = ApiUrl.leaderboardTop(
        month: selectedMonth.value,
        year: selectedYear.value,
        quarter: selectedQuarter.value,
      );

      // 🔍 Print API URL
      print("📡 Fetching Leaderboard: $url");

      final response = await BaseClient.getRequest(api: url);

      // 🔍 Print raw response
      print("📥 Raw Response Status: ${response.statusCode}");
      print("📥 Raw Body: ${response.body}");

      if (response.statusCode == 200) {
        final data = await BaseClient.handleResponse(response);

        // 🔍 Pretty JSON Print
        print("📄 Pretty JSON:\n${const JsonEncoder.withIndent('  ').convert(data)}");

        final model = LeaderBoardModel.fromJson(data);

        // Ensure totalRevenue is not null
        for (var user in model.data) {
          user.totalRevenue ??= 0;
        }

        rawData.value = model.data;

        // 🔍 Debug print number of users
        print("👥 Loaded Users: ${rawData.length}");
      } else {
        print("❌ API Error: Status ${response.statusCode}");
        print("❌ Body: ${response.body}");
      }
    } catch (e, stack) {
      // 🔥 Print errors only (NO snackbar)
      print("❌ Exception Occurred: $e");
      print("📍 Stacktrace:\n$stack");
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
  void applyFilters() => fetchLeaderBoard();

  /// Refresh data manually
  void refresh() => fetchLeaderBoard();

  /// Clear all filters
  void clearFilters() {
    selectedMonth.value = null;
    selectedYear.value = null;
    selectedQuarter.value = null;
    fetchLeaderBoard();
  }
}
