class NotificationModel {
  NotificationModel({
     this.success,
     this.message,
     this.data,
  });

  final bool? success;
  final String? message;
  final Data? data;

  factory NotificationModel.fromJson(Map<String, dynamic> json){
    return NotificationModel(
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
    required this.userId,
    required this.title,
    required this.body,
    required this.data,
    required this.link,
    required this.isRead,
    required this.createdAt,
    required this.updatedAt,
  });

  final String? id;
  final String? userId;
  final String? title;
  final String? body;
  final dynamic data;
  final dynamic link;
  final bool? isRead;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory Datum.fromJson(Map<String, dynamic> json){
    return Datum(
      id: json["id"],
      userId: json["userId"],
      title: json["title"],
      body: json["body"],
      data: json["data"],
      link: json["link"],
      isRead: json["isRead"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
    );
  }

}

class Meta {
  Meta({
    required this.total,
    required this.page,
    required this.limit,
  });

  final dynamic total;
  final dynamic page;
  final dynamic limit;

  factory Meta.fromJson(Map<String, dynamic> json){
    return Meta(
      total: json["total"],
      page: json["page"],
      limit: json["limit"],
    );
  }

}
