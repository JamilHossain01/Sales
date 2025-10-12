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
    required this.userId,
    required this.targetAudience,
    required this.contact,
    required this.location,
    required this.revenueTarget,
    required this.commissionRate,
    required this.createdAt,
    required this.updatedAt,
    required this.closer,
  });

  final String? id;
  final String? name;
  final String? offer;
  final String? userId;
  final String? targetAudience;
  final String? contact;
  final String? location;
  final dynamic revenueTarget;
  final dynamic commissionRate;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final Closer? closer;

  factory Datum.fromJson(Map<String, dynamic> json){
    return Datum(
      id: json["id"],
      name: json["name"],
      offer: json["offer"],
      userId: json["userId"],
      targetAudience: json["targetAudience"],
      contact: json["contact"],
      location: json["location"],
      revenueTarget: json["revenueTarget"],
      commissionRate: json["commissionRate"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
      closer: json["closer"] == null ? null : Closer.fromJson(json["closer"]),
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
    required this.closerDocuments,
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
  final List<CloserDocument> closerDocuments;

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
