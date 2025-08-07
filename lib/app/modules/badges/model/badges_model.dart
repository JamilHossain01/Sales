class Badges {
  Badges({
     this.success,
     this.message,
     this.data,
  });

  final bool? success;
  final String? message;
  final Data? data;

  factory Badges.fromJson(Map<String, dynamic> json){
    return Badges(
      success: json["success"],
      message: json["message"],
      data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );
  }

}

class Data {
  Data({
    required this.currentBadge,
    required this.upComingBadge,
    required this.progressToNext,
    required this.data,
  });

  final CurrentBadge? currentBadge;
  final CurrentBadge? upComingBadge;
  final dynamic progressToNext;
  final List<CurrentBadge> data;

  factory Data.fromJson(Map<String, dynamic> json){
    return Data(
      currentBadge: json["currentBadge"] == null ? null : CurrentBadge.fromJson(json["currentBadge"]),
      upComingBadge: json["upComingBadge"] == null ? null : CurrentBadge.fromJson(json["upComingBadge"]),
      progressToNext: json["progressToNext"],
      data: json["data"] == null ? [] : List<CurrentBadge>.from(json["data"]!.map((x) => CurrentBadge.fromJson(x))),
    );
  }

}

class CurrentBadge {
  CurrentBadge({
    required this.id,
    required this.name,
    required this.dealCount,
    required this.description,
    required this.icon,
    required this.iconPath,
    required this.createdAt,
    required this.updatedAt,
  });

  final String? id;
  final String? name;
  final dynamic dealCount;
  final String? description;
  final String? icon;
  final String? iconPath;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory CurrentBadge.fromJson(Map<String, dynamic> json){
    return CurrentBadge(
      id: json["id"],
      name: json["name"],
      dealCount: json["dealCount"],
      description: json["description"],
      icon: json["icon"],
      iconPath: json["iconPath"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
    );
  }

}
