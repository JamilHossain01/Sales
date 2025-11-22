import 'dart:convert';
import 'package:get/get.dart';
import '../../../common_widget/customSnackBar.dart';
import '../../../uitilies/api/api_url.dart';
import '../../../uitilies/api/base_client.dart';

import 'dart:convert';
import 'package:get/get.dart';
import '../../../common_widget/customSnackBar.dart';
import '../../../uitilies/api/api_url.dart';
import '../../../uitilies/api/base_client.dart';

class LeaderBoardGetController extends GetxController {
  var isLoading = false.obs;
  var rawData = <dynamic>[].obs;
  var currentUserId = ''.obs;

  // Filter observables
  var selectedMonth = Rxn<int>();
  var selectedYear = Rxn<int>();
  var selectedQuarter = Rxn<int>();

  @override
  void onInit() {
    super.onInit();
    selectedYear.value = DateTime.now().year; // Default to current year
    fetchLeaderBoard();
  }

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
        final List<dynamic> list = data['data'] ?? [];

        for (var user in list) {
          final closers = (user['closer'] as List<dynamic>?) ?? [];
          user['totalAmount'] = closers.fold<num>(0, (sum, c) => sum + (c['amount'] ?? 0));
          user['totalDeals'] = closers.length;
        }

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

  void applyFilters() => fetchLeaderBoard();

  List<dynamic> get sortedUsers {
    final sorted = List<dynamic>.from(rawData);
    sorted.sort((a, b) => (b['totalAmount'] as num).compareTo(a['totalAmount'] as num));
    return sorted.take(10).toList();
  }

  dynamic get topUser => sortedUsers.isNotEmpty ? sortedUsers.first : null;
  List<dynamic> get otherTopUsers => sortedUsers.length > 1 ? sortedUsers.sublist(1) : [];
}