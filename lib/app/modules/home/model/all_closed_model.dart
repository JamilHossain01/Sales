
class ClosedAllDealModel {
  bool? success;
  String? message;
  Data? data;

  ClosedAllDealModel({this.success, this.message, this.data});

  factory ClosedAllDealModel.fromJson(Map<String, dynamic> json) {
    return ClosedAllDealModel(
      success: json['success'],
      message: json['message'],
      data: json['data'] == null ? null : Data.fromJson(json['data']),
    );
  }
}

class Data {
  Meta? meta;
  List<AllDealDatum>? data;

  Data({this.meta, this.data});

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      meta: json['meta'] == null ? null : Meta.fromJson(json['meta']),
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => AllDealDatum.fromJson(e))
          .toList() ??
          [],
    );
  }
}

class AllDealDatum {
  String? id;
  String? name;
  String? offer;
  String? accountNumber;
  num? agencyRate;
  num? commissionRate;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<Closer> closer;
  List<dynamic> users;

  AllDealDatum({
    this.id,
    this.name,
    this.offer,
    this.accountNumber,
    this.agencyRate,
    this.commissionRate,
    this.createdAt,
    this.updatedAt,
    this.closer = const [],
    this.users = const [],
  });

  factory AllDealDatum.fromJson(Map<String, dynamic> json) {
    return AllDealDatum(
      id: json['id'],
      name: json['name'],
      offer: json['offer'],
      accountNumber: json['accountNumber'],
      agencyRate: json['agencyRate'],
      commissionRate: json['commissionRate'],
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt']),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt']),
      closer: (json['closer'] as List<dynamic>?)
          ?.map((e) => Closer.fromJson(e))
          .toList() ??
          [],
      users: json['users'] ?? [],
    );
  }
}

class Closer {
  String? id;
  String? clientId;
  String? userId;
  String? proposition;
  DateTime? dealDate;
  String? status;
  num? amount;
  num? cashCollected;
  String? notes;
  List<CloserDocument> closerDocuments;

  Closer({
    this.id,
    this.clientId,
    this.userId,
    this.proposition,
    this.dealDate,
    this.status,
    this.amount,
    this.cashCollected,
    this.notes,
    this.closerDocuments = const [],
  });

  factory Closer.fromJson(Map<String, dynamic> json) {
    return Closer(
      id: json['id'],
      clientId: json['clientId'],
      userId: json['userId'],
      proposition: json['proposition'],
      dealDate: json['dealDate'] == null
          ? null
          : DateTime.parse(json['dealDate']),
      status: json['status'],
      amount: json['amount'],
      cashCollected: json['cashCollected'],
      notes: json['notes'],
      closerDocuments: (json['closerDocuments'] as List<dynamic>?)
          ?.map((e) => CloserDocument.fromJson(e))
          .toList() ??
          [],
    );
  }
}

class CloserDocument {
  final String? id;
  final String? closerId;
  final String? document;
  final String? path;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  CloserDocument({
    this.id,
    this.closerId,
    this.document,
    this.path,
    this.createdAt,
    this.updatedAt,
  });

  factory CloserDocument.fromJson(Map<String, dynamic> json) {
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
  int? page;
  int? limit;
  int? total;
  int? totalPage;

  Meta({this.page, this.limit, this.total, this.totalPage});

  factory Meta.fromJson(Map<String, dynamic> json) {
    return Meta(
      page: json['page'],
      limit: json['limit'],
      total: json['total'],
      totalPage: json['totalPage'],
    );
  }
}
