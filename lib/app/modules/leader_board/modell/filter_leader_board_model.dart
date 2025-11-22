class LeaderBoardModel {
  LeaderBoardModel({
     this.success,
     this.message,
    required this.data,
  });

  final bool? success;
  final String? message;
  final List<Datum> data;

  factory LeaderBoardModel.fromJson(Map<String, dynamic> json){
    return LeaderBoardModel(
      success: json["success"],
      message: json["message"],
      data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
    );
  }

}

class Datum {
  Datum({
    required this.id,
    required this.name,
    required this.profilePicture,
    required this.totalDeals,
    required this.totalSales,
    required this.totalRevenue,
    required this.myAchievements,
  });

  final String? id;
  final String? name;
  final String? profilePicture;
  final dynamic totalDeals;
  final dynamic totalSales;
  final double? totalRevenue;
  final List<MyAchievement> myAchievements;

  factory Datum.fromJson(Map<String, dynamic> json){
    return Datum(
      id: json["id"],
      name: json["name"],
      profilePicture: json["profilePicture"],
      totalDeals: json["totalDeals"],
      totalSales: json["totalSales"],
      totalRevenue: json["totalRevenue"],
      myAchievements: json["myAchievements"] == null ? [] : List<MyAchievement>.from(json["myAchievements"]!.map((x) => MyAchievement.fromJson(x))),
    );
  }

}

class MyAchievement {
  MyAchievement({
    required this.achievement,
  });

  final Achievement? achievement;

  factory MyAchievement.fromJson(Map<String, dynamic> json){
    return MyAchievement(
      achievement: json["achievement"] == null ? null : Achievement.fromJson(json["achievement"]),
    );
  }

}

class Achievement {
  Achievement({
    required this.id,
    required this.name,
    required this.salesCount,
    required this.dealCount,
    required this.revenue,
    required this.createdAt,
    required this.updatedAt,
  });

  final String? id;
  final String? name;
  final dynamic salesCount;
  final dynamic dealCount;
  final dynamic revenue;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory Achievement.fromJson(Map<String, dynamic> json){
    return Achievement(
      id: json["id"],
      name: json["name"],
      salesCount: json["salesCount"],
      dealCount: json["dealCount"],
      revenue: json["revenue"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
    );
  }

}
