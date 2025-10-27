import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wolf_pack/app/modules/dashboard/views/dashboard_view.dart';
import 'package:wolf_pack/app/modules/profile/views/profile_view.dart';
import '../../../common_widget/customSnackBar.dart';
import '../../../uitilies/api/api_url.dart';
import '../../../uitilies/api/base_client.dart';
import '../../../uitilies/custom_toast.dart';

class ChangePasswordController extends GetxController {
  var isLoading = false.obs;

  Future<void> passwordChange({
    required String oldPassword,
    required String newPassword,
    required String confirmPassword,
  }) async {
    try {
      isLoading(true);

      // Validate that newPassword and confirmPassword match
      if (newPassword != confirmPassword) {
        CustomSnackbar.showError('New password and confirm password do not match.');
        isLoading(false);
        return;
      }

      var map = <String, dynamic>{
        "oldPassword": oldPassword,
        "newPassword": newPassword,
      };

      dynamic responseBody = await BaseClient.handleResponse(
        await BaseClient.patchRequest(
          api: ApiUrl.userChangePassword,
          body: map,
        ),
      );

      if (responseBody['success'] == true) {
        Get.offAll(() => DashboardView());
        CustomSnackbar.showSuccess("Password Changed Successfully");
      } else {
        // Try to get specific error from 'errorSources'
        String errorMessage = responseBody['message'] ?? 'Something went wrong.';

        if (responseBody['errorSources'] != null &&
            responseBody['errorSources'] is List &&
            responseBody['errorSources'].isNotEmpty &&
            responseBody['errorSources'][0]['message'] != null) {
          errorMessage = responseBody['errorSources'][0]['message'];
        }

        CustomSnackbar.showError(errorMessage);
      }

      isLoading(false);
    } catch (e) {
      CustomToast.showToast(e.toString());
    } finally {
      isLoading(false);
    }
  }
}