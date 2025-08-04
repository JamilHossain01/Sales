
class ProfileSettingModel {
  ProfileSettingModel({
     this.success,
     this.message,
     this.data,
  });

  final bool? success;
  final String? message;
  final Data? data;

  factory ProfileSettingModel.fromJson(Map<String, dynamic> json){
    return ProfileSettingModel(
      success: json["success"],
      message: json["message"],
      data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );
  }

}

class Data {
  Data({
    required this.id,
    required this.privacy,
    required this.terms,
    required this.about,
  });

  final String? id;
  final String? privacy;
  final String? terms;
  final String? about;

  factory Data.fromJson(Map<String, dynamic> json){
    return Data(
      id: json["id"],
      privacy: json["privacy"],
      terms: json["terms"],
      about: json["about"],
    );
  }

}
