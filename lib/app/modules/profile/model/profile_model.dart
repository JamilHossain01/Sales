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
  final int? loginCount;
  final dynamic about;

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
    );
  }

}
