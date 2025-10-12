class GetPrizeWinnerModel {
  GetPrizeWinnerModel({
     this.success,
     this.message,
    required this.data,
  });

  final bool? success;
  final String? message;
  final List<Datum> data;

  factory GetPrizeWinnerModel.fromJson(Map<String, dynamic> json){
    return GetPrizeWinnerModel(
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
  final List<TopUser> topUsers;

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
      topUsers: json["topUsers"] == null ? [] : List<TopUser>.from(json["topUsers"]!.map((x) => TopUser.fromJson(x))),
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

class TopUser {
  TopUser({
    required this.id,
    required this.name,
    required this.profilePicture,
    required this.closer,
  });

  final String? id;
  final String? name;
  final String? profilePicture;
  final List<Closer> closer;

  factory TopUser.fromJson(Map<String, dynamic> json){
    return TopUser(
      id: json["id"],
      name: json["name"],
      profilePicture: json["profilePicture"],
      closer: json["closer"] == null ? [] : List<Closer>.from(json["closer"]!.map((x) => Closer.fromJson(x))),
    );
  }

}

class Closer {
  Closer({
    required this.id,
    required this.clientId,
    required this.userId,
    required this.proposition,
    required this.dealDate,
    required this.status,
    required this.amount,
    required this.notes,
    required this.createdAt,
    required this.updatedAt,
  });

  final String? id;
  final String? clientId;
  final String? userId;
  final String? proposition;
  final DateTime? dealDate;
  final String? status;
  final dynamic amount;
  final String? notes;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory Closer.fromJson(Map<String, dynamic> json){
    return Closer(
      id: json["id"],
      clientId: json["clientId"],
      userId: json["userId"],
      proposition: json["proposition"],
      dealDate: DateTime.tryParse(json["dealDate"] ?? ""),
      status: json["status"],
      amount: json["amount"],
      notes: json["notes"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
    );
  }

}
