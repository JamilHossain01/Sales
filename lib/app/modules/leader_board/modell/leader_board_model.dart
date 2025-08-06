class LeaderBoardModel {
  LeaderBoardModel({
     this.success,
     this.message,
     this.data,
  });

  final bool? success;
  final String? message;
  final Data? data;

  factory LeaderBoardModel.fromJson(Map<String, dynamic> json){
    return LeaderBoardModel(
      success: json["success"],
      message: json["message"],
      data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );
  }

}

class Data {
  Data({
     this.rank,
     this.upComingBadge,
    required this.leaderBoard,
  });

  final dynamic rank;
  final dynamic upComingBadge;
  final List<LeaderBoard> leaderBoard;

  factory Data.fromJson(Map<String, dynamic> json){
    return Data(
      rank: json["rank"],
      upComingBadge: json["upComingBadge"],
      leaderBoard: json["leaderBoard"] == null ? [] : List<LeaderBoard>.from(json["leaderBoard"]!.map((x) => LeaderBoard.fromJson(x))),
    );
  }

}

class LeaderBoard {
  LeaderBoard({
     this.id,
     this.name,
     this.profilePicture,
     this.salesCount,
  });

  final String? id;
  final String? name;
  final String? profilePicture;
  final dynamic salesCount;

  factory LeaderBoard.fromJson(Map<String, dynamic> json){
    return LeaderBoard(
      id: json["id"],
      name: json["name"],
      profilePicture: json["profilePicture"],
      salesCount: json["salesCount"],
    );
  }

}
