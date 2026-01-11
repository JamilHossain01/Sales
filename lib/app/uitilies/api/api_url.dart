class ApiUrl {
  // static const String baseUrl = "http://10.10.10.3:4000/api/v1";
  //  static const String baseUrl = "http://10.10.10.3:4003/api/v1";
 static const String baseUrl = "https://wolfpack.thewolfpackgroup.com/api/v1";

  // static const String baseUrl = "https://mu-prospects-wage-publicly.trycloudflare.com/api/v1";
  static const String socketGlobal = "https://renti-socket.techcrafters.tech";


  static String signIn = "$baseUrl/auth/sign-in";
  static String myProfile = "$baseUrl/user/profile";
  static String updateProfile = "$baseUrl/user/profile";
  static String updateProfileSetting = "$baseUrl/settings";
  static String userChangePassword = "$baseUrl/auth/change-password";
  static String forgotPassword = "$baseUrl/auth/forget-password";
  static String setNewPassword = "$baseUrl/auth/reset-password";
  static String verifyOtp  = "$baseUrl/auth/verify-account";
  static String resendEmail  = "$baseUrl/auth/forget-password";

  // Client
  static String allDeals= "$baseUrl/client?status=CLOSED";
  static String recentDeals= "$baseUrl/closer/recent-deals?status=CLOSED";
  static String myDeals= "$baseUrl/client/my-clients";
  static String myClients = "$baseUrl/client/my-clients?limit=3";
  // static String myAllClients = "$baseUrl/client/my-clients";
  static String closerCreate = "$baseUrl/closer/create";
  static String allPrizewinner = "$baseUrl/prize";
  // static String topPrizewinner = "$baseUrl/prize/winners";

 static String getTopPrizeWinners({
   required int year,
   required int month,
 }) {
   return '$baseUrl/prize/winners?year=$year&month=$month';
 }
  static String userPrizeWinner = "$baseUrl/user/prize-winner";
  // static String quaterPrizeWinner = "$baseUrl/quarter-prize/winners";
 static String quaterPrizeWinner({required int year}) => "$baseUrl/quarter-prize?year=$year";
  static String topPerformers = "$baseUrl/user/top-performers";
  static String leaderBoard = "$baseUrl/user/top-users";
  static String nextAchievements = "$baseUrl/user/next-achievement";



  //leaderboard
  static String leaderboard = "$baseUrl/user/leaderboard";
 // static String leaderboardTop = "$baseUrl/user/top-users";
  static String top3 = "$baseUrl/user/leaderboard?limit=3";

  static String singleClients({required dynamic clientId}) {
    return '$baseUrl/client/$clientId'; // Ensure BASE_URL is prepended
  } static String singlePrize({required dynamic clientId}) {
    return '$baseUrl/prize$clientId'; // Ensure BASE_URL is prepended
  }
   static String leaderboardTop({int? month, int? year, int? quarter}) {
     final params = <String>[];
     if (month != null) params.add("month=$month");
     if (year != null) params.add("year=$year");
     if (quarter != null) params.add("quarter=$quarter");

     final query = params.isEmpty ? "" : "?${params.join("&")}";
     return "$baseUrl/user/top-users$query";
   }
  static String supportCreate = "$baseUrl/settings/send-support-message";


  //Badges
  static String badges  = "$baseUrl/user/badges";

  //Notification
   static String notification  = "$baseUrl/notification/notifications";





}
