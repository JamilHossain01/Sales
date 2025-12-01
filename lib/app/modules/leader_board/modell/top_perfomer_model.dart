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
    required this.closer,
    required this.totalAmount,
    required this.totalRevenue,
    required this.totalDealCount,
  });

  final String? id;
  final String? name;
  final dynamic profilePicture;
  final dynamic dealClosedCount;
  final dynamic salesCount;
  final dynamic revenue;
  final dynamic dealCount;
  final dynamic monthlyTarget;
  final DateTime? startDate;
  final dynamic about;
  final List<Closer> closer;
  final dynamic totalAmount;
  final dynamic totalRevenue;
  final dynamic totalDealCount;

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
      closer: json["closer"] == null ? [] : List<Closer>.from(json["closer"]!.map((x) => Closer.fromJson(x))),
      totalAmount: json["totalAmount"],
      totalRevenue: json["totalRevenue"],
      totalDealCount: json["totalDealCount"],
    );
  }

}

class Closer {
  Closer({
    required this.id,
    required this.userId,
    required this.amount,
    required this.createdAt,
    required this.dealDate,
    required this.userClient,
  });

  final String? id;
  final String? userId;
  final dynamic amount;
  final DateTime? createdAt;
  final DateTime? dealDate;
  final UserClient? userClient;

  factory Closer.fromJson(Map<String, dynamic> json){
    return Closer(
      id: json["id"],
      userId: json["userId"],
      amount: json["amount"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      dealDate: DateTime.tryParse(json["dealDate"] ?? ""),
      userClient: json["userClient"] == null ? null : UserClient.fromJson(json["userClient"]),
    );
  }

}

class UserClient {
  UserClient({
    required this.id,
    required this.userId,
    required this.clientId,
    required this.createdAt,
    required this.updatedAt,
    required this.client,
  });

  final String? id;
  final String? userId;
  final String? clientId;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final Client? client;

  factory UserClient.fromJson(Map<String, dynamic> json){
    return UserClient(
      id: json["id"],
      userId: json["userId"],
      clientId: json["clientId"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
      client: json["client"] == null ? null : Client.fromJson(json["client"]),
    );
  }

}

class Client {
  Client({
    required this.commissionRate,
  });

  final dynamic commissionRate;

  factory Client.fromJson(Map<String, dynamic> json){
    return Client(
      commissionRate: json["commissionRate"],
    );
  }

}
