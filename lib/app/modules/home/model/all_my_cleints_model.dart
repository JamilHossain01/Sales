class AllMyClientModel {
  AllMyClientModel({
     this.success,
     this.message,
     this.data,
  });

  final bool? success;
  final String? message;
  final Data? data;

  factory AllMyClientModel.fromJson(Map<String, dynamic> json){
    return AllMyClientModel(
      success: json["success"],
      message: json["message"],
      data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );
  }

}

class Data {
  Data({
    required this.meta,
    required this.data,
  });

  final Meta? meta;
  final List<Datum> data;

  factory Data.fromJson(Map<String, dynamic> json){
    return Data(
      meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
      data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
    );
  }

}

class Datum {
  Datum({
    required this.id,
    required this.name,
    required this.offer,
    required this.accountNumber,
    required this.agencyRate,
    required this.commissionRate,
    required this.createdAt,
    required this.updatedAt,
    required this.userClients,
  });

  final String? id;
  final String? name;
  final String? offer;
  final String? accountNumber;
  final dynamic agencyRate;
  final dynamic commissionRate;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final List<UserClient> userClients;

  factory Datum.fromJson(Map<String, dynamic> json){
    return Datum(
      id: json["id"],
      name: json["name"],
      offer: json["offer"],
      accountNumber: json["accountNumber"],
      agencyRate: json["agencyRate"],
      commissionRate: json["commissionRate"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
      userClients: json["userClients"] == null ? [] : List<UserClient>.from(json["userClients"]!.map((x) => UserClient.fromJson(x))),
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
    required this.closers,
  });

  final String? id;
  final String? userId;
  final String? clientId;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final List<Closer> closers;

  factory UserClient.fromJson(Map<String, dynamic> json){
    return UserClient(
      id: json["id"],
      userId: json["userId"],
      clientId: json["clientId"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
      closers: json["closers"] == null ? [] : List<Closer>.from(json["closers"]!.map((x) => Closer.fromJson(x))),
    );
  }

}

class Closer {
  Closer({
    required this.id,
    required this.userId,
    required this.userClientId,
    required this.proposition,
    required this.dealDate,
    required this.status,
    required this.amount,
    required this.cashCollected,
    required this.notes,
    required this.createdAt,
    required this.updatedAt,
    required this.closerDocuments,
  });

  final String? id;
  final String? userId;
  final String? userClientId;
  final String? proposition;
  final DateTime? dealDate;
  final String? status;
  final dynamic amount;
  final dynamic cashCollected;
  final String? notes;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final List<CloserDocument> closerDocuments;

  factory Closer.fromJson(Map<String, dynamic> json){
    return Closer(
      id: json["id"],
      userId: json["userId"],
      userClientId: json["userClientId"],
      proposition: json["proposition"],
      dealDate: DateTime.tryParse(json["dealDate"] ?? ""),
      status: json["status"],
      amount: json["amount"],
      cashCollected: json["cashCollected"],
      notes: json["notes"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
      closerDocuments: json["closerDocuments"] == null ? [] : List<CloserDocument>.from(json["closerDocuments"]!.map((x) => CloserDocument.fromJson(x))),
    );
  }

}

class CloserDocument {
  CloserDocument({
    required this.id,
    required this.closerId,
    required this.document,
    required this.path,
    required this.createdAt,
    required this.updatedAt,
  });

  final String? id;
  final String? closerId;
  final String? document;
  final String? path;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory CloserDocument.fromJson(Map<String, dynamic> json){
    return CloserDocument(
      id: json["id"],
      closerId: json["closerId"],
      document: json["document"],
      path: json["path"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
    );
  }

}

class Meta {
  Meta({
    required this.page,
    required this.limit,
    required this.total,
    required this.totalPage,
  });

  final dynamic page;
  final dynamic limit;
  final dynamic total;
  final dynamic totalPage;

  factory Meta.fromJson(Map<String, dynamic> json){
    return Meta(
      page: json["page"],
      limit: json["limit"],
      total: json["total"],
      totalPage: json["totalPage"],
    );
  }

}
