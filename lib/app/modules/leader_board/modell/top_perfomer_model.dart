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
    required this.dealClosedCount,
    required this.salesCount,
    required this.revenue,
    required this.dealCount,
    required this.monthlyTarget,
    required this.startDate,
    required this.about,
    required this.count,
    required this.totalAmount,
    required this.totalRevenue,
  });

  final String? id;
  final String? name;
  final String? profilePicture;
  final dynamic dealClosedCount;
  final dynamic salesCount;
  final dynamic revenue;
  final dynamic dealCount;
  final dynamic monthlyTarget;
  final DateTime? startDate;
  final String? about;
  final Count? count;
  final dynamic totalAmount;
  final dynamic totalRevenue;

  factory Value.fromJson(Map<String, dynamic> json){
    return Value(
      id: json["id"],
      name: json["name"],
      profilePicture: json["profilePicture"],
      dealClosedCount: json["dealClosedCount"],
      salesCount: json["salesCount"],
      revenue: json["revenue"],
      dealCount: json["dealCount"],
      monthlyTarget: json["monthlyTarget"],
      startDate: DateTime.tryParse(json["startDate"] ?? ""),
      about: json["about"],
      count: json["_count"] == null ? null : Count.fromJson(json["_count"]),
      totalAmount: json["totalAmount"],
      totalRevenue: json["totalRevenue"],
    );
  }

}

class Count {
  Count({
    required this.closer,
  });

  final dynamic closer;

  factory Count.fromJson(Map<String, dynamic> json){
    return Count(
      closer: json["closer"],
    );
  }

}
