class SingePrizeModel {
  SingePrizeModel({
     this.success,
     this.message,
     this.data,
  });

  final bool? success;
  final String? message;
  final Data? data;

  factory SingePrizeModel.fromJson(Map<String, dynamic> json){
    return SingePrizeModel(
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
  final int? tierLevel;
  final DateTime? startDate;
  final DateTime? endDate;
  final bool? isActive;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory Data.fromJson(Map<String, dynamic> json){
    return Data(
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
