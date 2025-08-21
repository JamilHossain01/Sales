import 'package:get/get.dart';
import 'package:wolf_pack/app/modules/home/model/my_clients_model.dart' as home;
import '../../../common widget/customSnackBar.dart';
import '../../../uitilies/api/api_url.dart';
import '../../../uitilies/api/base_client.dart';
import '../../profile/controllers/get_myProfile_controller.dart';

class DealsController extends GetxController {
  var isLoadingMyDeals = false.obs;
  var isLoadingAllDeals = false.obs;

  var myDeals = <home.Datum>[].obs;
  var allDeals = <home.Datum>[].obs;

  final GetMyProfileController profileController = Get.find();

  @override
  void onInit() {
    super.onInit();
    fetchMyDeals();
    fetchAllDeals();
  }

  Future<void> fetchMyDeals() async {
    try {
      isLoadingMyDeals(true);
      final response = await BaseClient.getRequest(api: ApiUrl.myClients);
      if (response.statusCode == 200) {
        final data = await BaseClient.handleResponse(response);
        final model = home.MyClientModel.fromJson(data);
        final currentUserId = profileController.profileData.value.data?.id;
        myDeals.value = model.data?.data
            ?.where((client) => client.closer?.userId == currentUserId)
            .toList() ??
            [];
      } else {
        throw "Failed to load My Deals (${response.statusCode})";
      }
    } catch (e) {
      CustomSnackbar.showError(e.toString());
    } finally {
      isLoadingMyDeals(false);
    }
  }

  Future<void> fetchAllDeals() async {
    try {
      isLoadingAllDeals(true);
      final response = await BaseClient.getRequest(api: ApiUrl.allClients);
      if (response.statusCode == 200) {
        final data = await BaseClient.handleResponse(response);
        final model = home.MyClientModel.fromJson(data);
        allDeals.value = model.data?.data ?? [];
      } else {
        throw "Failed to load All Deals (${response.statusCode})";
      }
    } catch (e) {
      CustomSnackbar.showError(e.toString());
    } finally {
      isLoadingAllDeals(false);
    }
  }
}
