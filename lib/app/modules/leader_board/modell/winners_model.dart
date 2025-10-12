class GetWinnerModel {
  GetWinnerModel({
     this.success,
     this.message,
    required this.data,
  });

  final bool? success;
  final String? message;
  final List<Datum> data;

  factory GetWinnerModel.fromJson(Map<String, dynamic> json){
    return GetWinnerModel(
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
    required this.month,
    required this.year,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
    required this.entries,
    required this.topUsers,
  });

  final String? id;
  final String? name;
  final dynamic month;
  final dynamic year;
  final bool? isActive;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final List<Entry> entries;
  final List<dynamic> topUsers;

  factory Datum.fromJson(Map<String, dynamic> json){
    return Datum(
      id: json["id"],
      name: json["name"],
      month: json["month"],
      year: json["year"],
      isActive: json["isActive"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
      entries: json["entries"] == null ? [] : List<Entry>.from(json["entries"]!.map((x) => Entry.fromJson(x))),
      topUsers: json["topUsers"] == null ? [] : List<dynamic>.from(json["topUsers"]!.map((x) => x)),
    );
  }

}

class Entry {
  Entry({
    required this.id,
    required this.rank,
    required this.name,
    required this.icon,
    required this.iconPath,
    required this.prizeId,
    required this.createdAt,
    required this.updatedAt,
  });

  final String? id;
  final dynamic rank;
  final String? name;
  final String? icon;
  final String? iconPath;
  final String? prizeId;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory Entry.fromJson(Map<String, dynamic> json){
    return Entry(
      id: json["id"],
      rank: json["rank"],
      name: json["name"],
      icon: json["icon"],
      iconPath: json["iconPath"],
      prizeId: json["prizeId"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
    );
  }

}
