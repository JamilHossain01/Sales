// class UserModel {
//   final String id;
//   final String name;
//   final String? profilePicture;
//   final List<Closer> closer;
//   final dynamic totalDeals;
//   final dynamic totalSales;
//   final dynamic totalRevenue;
//   final List<MyAchievement> myAchievements;
//
//   UserModel({
//     required this.id,
//     required this.name,
//     this.profilePicture,
//     required this.closer,
//     required this.totalDeals,
//     required this.totalSales,
//     required this.totalRevenue,
//     required this.myAchievements,
//   });
//
//   factory UserModel.fromJson(Map<String, dynamic> json) {
//     return UserModel(
//       id: json['id'],
//       name: json['name'],
//       profilePicture: json['profilePicture'],
//       closer: (json['closer'] as List)
//           .map((e) => Closer.fromJson(e))
//           .toList(),
//       totalDeals: json['totalDeals'],
//       totalSales: json['totalSales'],
//       totalRevenue: json['totalRevenue'],
//       myAchievements: (json['myAchievements'] as List)
//           .map((e) => MyAchievement.fromJson(e))
//           .toList(),
//     );
//   }
//
//   Map<String, dynamic> toJson() => {
//     'id': id,
//     'name': name,
//     'profilePicture': profilePicture,
//     'closer': closer.map((e) => e.toJson()).toList(),
//     'totalDeals': totalDeals,
//     'totalSales': totalSales,
//     'totalRevenue': totalRevenue,
//     'myAchievements': myAchievements.map((e) => e.toJson()).toList(),
//   };
// }
//
// class Closer {
//   final String id;
//   final String clientId;
//   final String userId;
//   final String proposition;
//   final DateTime dealDate;
//   final String status;
//   final dynamic amount;
//   final dynamic cashCollected;
//   final String notes;
//   final DateTime createdAt;
//   final DateTime updatedAt;
//
//   Closer({
//     required this.id,
//     required this.clientId,
//     required this.userId,
//     required this.proposition,
//     required this.dealDate,
//     required this.status,
//     required this.amount,
//     required this.cashCollected,
//     required this.notes,
//     required this.createdAt,
//     required this.updatedAt,
//   });
//
//   factory Closer.fromJson(Map<String, dynamic> json) {
//     return Closer(
//       id: json['id'],
//       clientId: json['clientId'],
//       userId: json['userId'],
//       proposition: json['proposition'],
//       dealDate: DateTime.parse(json['dealDate']),
//       status: json['status'],
//       amount: json['amount'],
//       cashCollected: json['cashCollected'],
//       notes: json['notes'],
//       createdAt: DateTime.parse(json['createdAt']),
//       updatedAt: DateTime.parse(json['updatedAt']),
//     );
//   }
//
//   Map<String, dynamic> toJson() => {
//     'id': id,
//     'clientId': clientId,
//     'userId': userId,
//     'proposition': proposition,
//     'dealDate': dealDate.toIso8601String(),
//     'status': status,
//     'amount': amount,
//     'cashCollected': cashCollected,
//     'notes': notes,
//     'createdAt': createdAt.toIso8601String(),
//     'updatedAt': updatedAt.toIso8601String(),
//   };
// }
//
// class MyAchievement {
//   final Achievement achievement;
//
//   MyAchievement({required this.achievement});
//
//   factory MyAchievement.fromJson(Map<String, dynamic> json) {
//     return MyAchievement(
//       achievement: Achievement.fromJson(json['achievement']),
//     );
//   }
//
//   Map<String, dynamic> toJson() => {
//     'achievement': achievement.toJson(),
//   };
// }
//
// class Achievement {
//   final String id;
//   final String name;
//   final dynamic salesCount;
//   final dynamic dealCount;
//   final dynamic revenue;
//   final DateTime createdAt;
//   final DateTime updatedAt;
//
//   Achievement({
//     required this.id,
//     required this.name,
//     required this.salesCount,
//     required this.dealCount,
//     required this.revenue,
//     required this.createdAt,
//     required this.updatedAt,
//   });
//
//   factory Achievement.fromJson(Map<String, dynamic> json) {
//     return Achievement(
//       id: json['id'],
//       name: json['name'],
//       salesCount: json['salesCount'],
//       dealCount: json['dealCount'],
//       revenue: json['revenue'],
//       createdAt: DateTime.parse(json['createdAt']),
//       updatedAt: DateTime.parse(json['updatedAt']),
//     );
//   }
//
//   Map<String, dynamic> toJson() => {
//     'id': id,
//     'name': name,
//     'salesCount': salesCount,
//     'dealCount': dealCount,
//     'revenue': revenue,
//     'createdAt': createdAt.toIso8601String(),
//     'updatedAt': updatedAt.toIso8601String(),
//   };
// }
