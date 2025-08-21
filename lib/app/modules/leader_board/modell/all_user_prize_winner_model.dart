class UserPrizeWinnerModel {
  UserPrizeWinnerModel({
     this.success,
     this.message,
    required this.data,
  });

  final bool? success;
  final String? message;
  final List<Datum> data;

  factory UserPrizeWinnerModel.fromJson(Map<String, dynamic> json){
    return UserPrizeWinnerModel(
      success: json["success"],
      message: json["message"],
      data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
    );
  }

}

class Datum {
  Datum({
    required this.id,
    required this.prizeId,
    required this.userId,
    required this.position,
    required this.createdAt,
    required this.user,
    required this.prize,
  });

  final String? id;
  final String? prizeId;
  final String? userId;
  final dynamic position;
  final DateTime? createdAt;
  final User? user;
  final Prize? prize;

  factory Datum.fromJson(Map<String, dynamic> json){
    return Datum(
      id: json["id"],
      prizeId: json["prizeId"],
      userId: json["userId"],
      position: json["position"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      user: json["user"] == null ? null : User.fromJson(json["user"]),
      prize: json["prize"] == null ? null : Prize.fromJson(json["prize"]),
    );
  }

}

class Prize {
  Prize({
    required this.id,
    required this.name,
    required this.icon,
    required this.iconPath,
    required this.tierLevel,
    required this.startDate,
    required this.endDate,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
  });

  final String? id;
  final String? name;
  final String? icon;
  final String? iconPath;
  final dynamic tierLevel;
  final DateTime? startDate;
  final DateTime? endDate;
  final bool? isActive;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory Prize.fromJson(Map<String, dynamic> json){
    return Prize(
      id: json["id"],
      name: json["name"],
      icon: json["icon"],
      iconPath: json["iconPath"],
      tierLevel: json["tierLevel"],
      startDate: DateTime.tryParse(json["startDate"] ?? ""),
      endDate: DateTime.tryParse(json["endDate"] ?? ""),
      isActive: json["isActive"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
    );
  }

}

class User {
  User({
    required this.id,
    required this.name,
    required this.profilePicture,
    required this.dealClosedCount,
    required this.salesCount,
    required this.dealCount,
  });

  final String? id;
  final String? name;
  final String? profilePicture;
  final dynamic dealClosedCount;
  final dynamic salesCount;
  final dynamic dealCount;

  factory User.fromJson(Map<String, dynamic> json){
    return User(
      id: json["id"],
      name: json["name"],
      profilePicture: json["profilePicture"],
      dealClosedCount: json["dealClosedCount"],
      salesCount: json["salesCount"],
      dealCount: json["dealCount"],
    );
  }

}
