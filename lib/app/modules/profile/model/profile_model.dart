class ProfileModel {
  ProfileModel({
    this.success,
    this.message,
    this.data,
  });

  final bool? success;
  final String? message;
  final Data? data;

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      success: json["success"] as bool?,
      message: json["message"] as String?,
      data: json["data"] == null ? null : Data.fromJson(json["data"] as Map<String, dynamic>),
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
    required this.league,
    required this.commission,
    required this.monthlyTargetPercentage,
    required this.avgDealAmount,
    required this.rank,
  });

  final String? id;
  final String? name;
  final String? email;
  final String? role;
  final String? profilePicture;
  final bool? isDelete;
  final bool? isActive;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? phoneNumber;
  final dynamic loginCount;
  final String? about;
  final dynamic dealCount;
  final dynamic salesCount;
  final dynamic monthlyTarget;
  final dynamic dealClosedCount;
  final League? league;
  final double? commission;
  final dynamic monthlyTargetPercentage;
  final dynamic avgDealAmount;
  final dynamic rank;

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      id: json["id"] as String?,
      name: json["name"] as String?,
      email: json["email"] as String?,
      role: json["role"] as String?,
      profilePicture: json["profilePicture"] as String?,
      isDelete: json["isDelete"] as bool?,
      isActive: json["isActive"] as bool?,
      createdAt: json["createdAt"] == null
          ? null
          : DateTime.tryParse(json["createdAt"] as String),
      updatedAt: json["updatedAt"] == null
          ? null
          : DateTime.tryParse(json["updatedAt"] as String),
      phoneNumber: json["phoneNumber"] as String?,
      loginCount: json["loginCount"],
      about: json["about"] as String?,
      dealCount: json["dealCount"],
      salesCount: json["salesCount"],
      monthlyTarget: json["monthlyTarget"],
      dealClosedCount: json["dealClosedCount"],
      league: json["league"] == null
          ? null
          : League.fromJson(json["league"] as Map<String, dynamic>),
      commission: json["commission"] == null
          ? null
          : double.tryParse(json["commission"].toString()),
      monthlyTargetPercentage: json["monthlyTargetPercentage"],
      avgDealAmount: json["avgDealAmount"],
      rank: json["rank"],
    );
  }
}

class League {
  League({
    required this.id,
    required this.name,
    required this.dealAmount,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
  });

  final String? id;
  final String? name;
  final dynamic dealAmount;
  final String? description;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory League.fromJson(Map<String, dynamic> json) {
    return League(
      id: json["id"] as String?,
      name: json["name"] as String?,
      dealAmount: json["dealAmount"],
      description: json["description"] as String?,
      createdAt: json["createdAt"] == null
          ? null
          : DateTime.tryParse(json["createdAt"] as String),
      updatedAt: json["updatedAt"] == null
          ? null
          : DateTime.tryParse(json["updatedAt"] as String),
    );
  }
}