class RecentDealModel {
  RecentDealModel({
     this.success,
     this.message,
     this.meta,
    required this.data,
  });

  final bool? success;
  final String? message;
  final Meta? meta;
  final List<AllRecentDealDatum> data;

  factory RecentDealModel.fromJson(Map<String, dynamic> json){
    return RecentDealModel(
      success: json["success"],
      message: json["message"],
      meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
      data: json["data"] == null ? [] : List<AllRecentDealDatum>.from(json["data"]!.map((x) => AllRecentDealDatum.fromJson(x))),
    );
  }

}

class AllRecentDealDatum {
  AllRecentDealDatum({
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
    required this.userClient,
    required this.closerDocuments,
    required this.user,
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
  final UserClient? userClient;
  final List<dynamic> closerDocuments;
  final User? user;

  factory AllRecentDealDatum.fromJson(Map<String, dynamic> json){
    return AllRecentDealDatum(
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
      userClient: json["userClient"] == null ? null : UserClient.fromJson(json["userClient"]),
      closerDocuments: json["closerDocuments"] == null ? [] : List<dynamic>.from(json["closerDocuments"]!.map((x) => x)),
      user: json["user"] == null ? null : User.fromJson(json["user"]),
    );
  }

}

class User {
  User({
    required this.id,
    required this.name,
    required this.email,
    required this.profilePicture,
    required this.about,
    required this.registeredId,
  });

  final String? id;
  final String? name;
  final String? email;
  final dynamic profilePicture;
  final dynamic about;
  final String? registeredId;

  factory User.fromJson(Map<String, dynamic> json){
    return User(
      id: json["id"],
      name: json["name"],
      email: json["email"],
      profilePicture: json["profilePicture"],
      about: json["about"],
      registeredId: json["registeredId"],
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
    required this.id,
    required this.name,
    required this.offer,
    required this.accountNumber,
    required this.agencyRate,
    required this.commissionRate,
    required this.createdAt,
    required this.updatedAt,
  });

  final String? id;
  final String? name;
  final String? offer;
  final String? accountNumber;
  final dynamic agencyRate;
  final dynamic commissionRate;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory Client.fromJson(Map<String, dynamic> json){
    return Client(
      id: json["id"],
      name: json["name"],
      offer: json["offer"],
      accountNumber: json["accountNumber"],
      agencyRate: json["agencyRate"],
      commissionRate: json["commissionRate"],
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
