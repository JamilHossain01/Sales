class TopPerformersModel {
  TopPerformersModel({
     this.success,
     this.message,
    required this.data,
  });

  final bool? success;
  final String? message;
  final List<Datum> data;

  factory TopPerformersModel.fromJson(Map<String, dynamic> json){
    return TopPerformersModel(
      success: json["success"],
      message: json["message"],
      data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
    );
  }

}

class Datum {
  Datum({
    required this.label,
    required this.value,
  });

  final String? label;
  final Value? value;

  factory Datum.fromJson(Map<String, dynamic> json){
    return Datum(
      label: json["label"],
      value: json["value"] == null ? null : Value.fromJson(json["value"]),
    );
  }

}

class Value {
  Value({
    required this.id,
    required this.name,
    required this.profilePicture,
    required this.closer,
    required this.dealClosedCount,
    required this.salesCount,
    required this.revenue,
    required this.dealCount,
    required this.monthlyTarget,
    required this.startDate,
    required this.about,
    required this.count,
  });

  final String? id;
  final String? name;
  final String? profilePicture;
  final List<Closer> closer;
  final int? dealClosedCount;
  final int? salesCount;
  final int? revenue;
  final int? dealCount;
  final int? monthlyTarget;
  final DateTime? startDate;
  final String? about;
  final Count? count;

  factory Value.fromJson(Map<String, dynamic> json){
    return Value(
      id: json["id"],
      name: json["name"],
      profilePicture: json["profilePicture"],
      closer: json["closer"] == null ? [] : List<Closer>.from(json["closer"]!.map((x) => Closer.fromJson(x))),
      dealClosedCount: json["dealClosedCount"],
      salesCount: json["salesCount"],
      revenue: json["revenue"],
      dealCount: json["dealCount"],
      monthlyTarget: json["monthlyTarget"],
      startDate: DateTime.tryParse(json["startDate"] ?? ""),
      about: json["about"],
      count: json["_count"] == null ? null : Count.fromJson(json["_count"]),
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
  final int? amount;
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

class Count {
  Count({
    required this.closer,
  });

  final int? closer;

  factory Count.fromJson(Map<String, dynamic> json){
    return Count(
      closer: json["closer"],
    );
  }

}
