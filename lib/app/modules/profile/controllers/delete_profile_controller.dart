// import 'dart:convert';
// import 'package:get/get.dart';
//
// import '../../../common widget/customSnackBar.dart';
//
// class DeleteProfileController extends GetxController {
//   var isLoading = false.obs;
//
//   Future<void> deleteProfile() async {
//     isLoading(true);
//
//     try {
//       final response = await BaseClient.deleteRequest(
//         api: ApiUrl.deleteProfile(profileId: ''),
//         body: {}, // If your API requires a body, add it here. Otherwise can be null or empty
//       );
//
//       final responseBody = jsonDecode(response.body);
//
//       if (response.statusCode == 200 && responseBody['success'] == true) {
//         CustomSnackbar.showSuccess(responseBody['message'] ?? "Profile deleted successfully.");
//         // You can add logout or navigation logic here if needed
//       } else {
//         throw responseBody['message'] ?? "Failed to delete profile";
//       }
//     } catch (e) {
//       CustomSnackbar.showError(e.toString());
//     } finally {
//       isLoading(false);
//     }
//   }
// }
