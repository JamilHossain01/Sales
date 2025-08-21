class AllPrizeModel {
  AllPrizeModel({
     this.success,
     this.message,
    required this.data,
  });

  final bool? success;
  final String? message;
  final List<Datum> data;

  factory AllPrizeModel.fromJson(Map<String, dynamic> json){
    return AllPrizeModel(
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

  factory Datum.fromJson(Map<String, dynamic> json){
    return Datum(
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
