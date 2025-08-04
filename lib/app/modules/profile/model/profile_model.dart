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
    required this.league,
    required this.commission,
    required this.monthlyTargetPercentage,
    required this.avgDealAmount,
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
  final dynamic league;
  final dynamic commission;
  final dynamic monthlyTargetPercentage;
  final dynamic avgDealAmount;

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
      league: json["league"],
      commission: json["commission"],
      monthlyTargetPercentage: json["monthlyTargetPercentage"],
      avgDealAmount: json["avgDealAmount"],
    );
  }

}
