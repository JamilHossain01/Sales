// lib/app/modules/leader_board/modell/leader_board_model.dart

class LeaderBoardModels {
  final List<LeaderBoardUser>? leaderBoard;

  LeaderBoardModels({this.leaderBoard});

  // API returns List directly → no fromJson needed
  factory LeaderBoardModels.fromList(List<dynamic> list) {
    return LeaderBoardModels(
      leaderBoard: list
          .map((e) => LeaderBoardUser.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

class LeaderBoardUser {
  final String? id;
  final String? name;
  final String? profilePicture;
  final int? salesCount;
  final int? dealCount;

  LeaderBoardUser({
    this.id,
    this.name,
    this.profilePicture,
    this.salesCount,
    this.dealCount,
  });

  factory LeaderBoardUser.fromJson(Map<String, dynamic> json) {
    return LeaderBoardUser(
      id: json['id'],
      name: json['name'],
      profilePicture: json['profilePicture'],
      salesCount: json['salesCount'],
      dealCount: json['dealCount'],
    );
  }
}