class ApiUrl {
  static const String baseUrl = "http://10.10.10.3:4000/api/v1";
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
  static String allClients= "$baseUrl/client";
  static String myClients = "$baseUrl/client/my-clients?limit=3";





}
