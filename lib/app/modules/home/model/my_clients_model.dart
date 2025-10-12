// My clients model (unique class names to avoid collisions)

class MyClientModel {
  MyClientModel({
    this.success,
    this.message,
    this.data,
  });

  final bool? success;
  final String? message;
  final MyClientData? data;

  factory MyClientModel.fromJson(Map<String, dynamic> json) {
    return MyClientModel(
      success: json["success"] as bool?,
      message: json["message"] as String?,
      data: json["data"] == null
          ? null
          : MyClientData.fromJson(Map<String, dynamic>.from(json["data"] as Map)),
    );
  }
}

class MyClientData {
  MyClientData({
    required this.meta,
    required this.data,
  });

  final MyClientMeta? meta;
  final List<MyClientDatum> data;

  factory MyClientData.fromJson(Map<String, dynamic> json) {
    final list = json["data"] as List<dynamic>?;
    return MyClientData(
      meta: json["meta"] == null ? null : MyClientMeta.fromJson(Map<String, dynamic>.from(json["meta"] as Map)),
      data: list == null ? <MyClientDatum>[] : list.map((e) => MyClientDatum.fromJson(Map<String, dynamic>.from(e as Map))).toList(),
    );
  }
}

class MyClientDatum {
  MyClientDatum({
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
  final MyClientCloser? closer;

  factory MyClientDatum.fromJson(Map<String, dynamic> json) {
    return MyClientDatum(
      id: json["id"] as String?,
      name: json["name"] as String?,
      offer: json["offer"] as String?,
      userId: json["userId"] as String?,
      targetAudience: json["targetAudience"] as String?,
      contact: json["contact"] as String?,
      location: json["location"] as String?,
      revenueTarget: json["revenueTarget"],
      commissionRate: json["commissionRate"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
      closer: json["closer"] == null ? null : MyClientCloser.fromJson(Map<String, dynamic>.from(json["closer"] as Map)),
    );
  }
}

class MyClientCloser {
  MyClientCloser({
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
  final List<MyClientCloserDocument> closerDocuments;

  factory MyClientCloser.fromJson(Map<String, dynamic> json) {
    final closerDocs = json["closerDocuments"] as List<dynamic>?;
    return MyClientCloser(
      id: json["id"] as String?,
      clientId: json["clientId"] as String?,
      userId: json["userId"] as String?,
      proposition: json["proposition"] as String?,
      dealDate: DateTime.tryParse(json["dealDate"] ?? ""),
      status: json["status"] as String?,
      amount: json["amount"],
      notes: json["notes"] as String?,
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
      closerDocuments: closerDocs == null ? <MyClientCloserDocument>[] : closerDocs.map((e) => MyClientCloserDocument.fromJson(Map<String, dynamic>.from(e as Map))).toList(),
    );
  }
}

class MyClientCloserDocument {
  MyClientCloserDocument({
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

  factory MyClientCloserDocument.fromJson(Map<String, dynamic> json) {
    return MyClientCloserDocument(
      id: json["id"] as String?,
      closerId: json["closerId"] as String?,
      document: json["document"] as String?,
      path: json["path"] as String?,
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
    );
  }
}

class MyClientMeta {
  MyClientMeta({
    required this.page,
    required this.limit,
    required this.total,
    required this.totalPage,
  });

  final dynamic page;
  final dynamic limit;
  final dynamic total;
  final dynamic totalPage;

  factory MyClientMeta.fromJson(Map<String, dynamic> json) {
    return MyClientMeta(
      page: json["page"],
      limit: json["limit"],
      total: json["total"],
      totalPage: json["totalPage"],
    );
  }
}
