class ProfileModel {
  ProfileModel({
     this.success,
     this.message,
     this.data,
  });

  final bool? success;
  final String? message;
  final Data? data;

  factory ProfileModel.fromJson(Map<String, dynamic> json){
    return ProfileModel(
      success: json["success"],
      message: json["message"],
      data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );
  }

}

class Data {
  Data({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    required this.profilePicture,
    required this.isDelete,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
    required this.phoneNumber,
    required this.loginCount,
    required this.about,
    required this.dealCount,
    required this.salesCount,
    required this.monthlyTarget,
    required this.dealClosedCount,
    required this.myAchievements,
    required this.commission,
    required this.monthlyTargetPercentage,
    required this.avgDealAmount,
    required this.rank,
  });

  final String? id;
  final String? name;
  final String? email;
  final String? role;
  final dynamic profilePicture;
  final bool? isDelete;
  final bool? isActive;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final dynamic phoneNumber;
  final dynamic loginCount;
  final dynamic about;
  final dynamic dealCount;
  final dynamic salesCount;
  final dynamic monthlyTarget;
  final dynamic dealClosedCount;
  final List<MyAchievement> myAchievements;
  final dynamic commission;
  final dynamic monthlyTargetPercentage;
  final dynamic avgDealAmount;
  final dynamic rank;

  factory Data.fromJson(Map<String, dynamic> json){
    return Data(
      id: json["id"],
      name: json["name"],
      email: json["email"],
      role: json["role"],
      profilePicture: json["profilePicture"],
      isDelete: json["isDelete"],
      isActive: json["isActive"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
      phoneNumber: json["phoneNumber"],
      loginCount: json["loginCount"],
      about: json["about"],
      dealCount: json["dealCount"],
      salesCount: json["salesCount"],
      monthlyTarget: json["monthlyTarget"],
      dealClosedCount: json["dealClosedCount"],
      myAchievements: json["myAchievements"] == null ? [] : List<MyAchievement>.from(json["myAchievements"]!.map((x) => MyAchievement.fromJson(x))),
      commission: json["commission"],
      monthlyTargetPercentage: json["monthlyTargetPercentage"],
      avgDealAmount: json["avgDealAmount"],
      rank: json["rank"],
    );
  }

}

class MyAchievement {
  MyAchievement({
    required this.id,
    required this.userId,
    required this.achievementId,
    required this.createdAt,
    required this.updatedAt,
    required this.achievement,
  });

  final String? id;
  final String? userId;
  final String? achievementId;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final Achievement? achievement;

  factory MyAchievement.fromJson(Map<String, dynamic> json){
    return MyAchievement(
      id: json["id"],
      userId: json["userId"],
      achievementId: json["achievementId"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
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
