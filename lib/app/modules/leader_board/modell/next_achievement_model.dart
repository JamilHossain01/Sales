class NextAchievementModel {
  NextAchievementModel({
     this.success,
     this.message,
    required this.data,
  });

  final bool? success;
  final String? message;
  final List<Datum> data;

  factory NextAchievementModel.fromJson(Map<String, dynamic> json){
    return NextAchievementModel(
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

  factory Datum.fromJson(Map<String, dynamic> json){
    return Datum(
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
