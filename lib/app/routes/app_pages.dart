import 'package:get/get.dart';

import '../modules/authentacation/bindings/authentacation_binding.dart';
import '../modules/authentacation/views/authentacation_view.dart';
import '../modules/badges/bindings/badges_binding.dart';
import '../modules/badges/views/badges_view.dart';
import '../modules/closed_deal/bindings/closed_deal_binding.dart';
import '../modules/closed_deal/views/closed_deal_view.dart';
import '../modules/dashboard/bindings/dashboard_binding.dart';
import '../modules/dashboard/views/dashboard_view.dart';
import '../modules/edit_profile/bindings/edit_profile_binding.dart';
import '../modules/edit_profile/views/edit_profile_view.dart';

import '../modules/forum/bindings/forum_binding.dart';
import '../modules/forum/views/forum_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/home/views/home_view.dart';
import '../modules/leader_board/bindings/leader_board_binding.dart';
import '../modules/leader_board/views/leader_board_view.dart';
import '../modules/log_in/bindings/log_in_binding.dart';
import '../modules/log_in/views/log_in_view.dart';
import '../modules/onboarding/bindings/onboarding_binding.dart';
import '../modules/onboarding/views/onboarding_view.dart';
import '../modules/open_deal/bindings/open_deal_binding.dart';
import '../modules/open_deal/views/open_deal_view.dart';


import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/views/profile_view.dart';
import '../modules/sales/bindings/sales_binding.dart';
import '../modules/sales/views/sales_view.dart';

import '../modules/setting/bindings/setting_binding.dart';
import '../modules/setting/views/setting_view.dart';
import '../modules/sign_in/bindings/sign_in_binding.dart';
import '../modules/sign_in/views/sign_in_view.dart';
import '../modules/signup/bindings/signup_binding.dart';
import '../modules/signup/views/signup_view.dart';
import '../modules/spalsh/bindings/spalsh_binding.dart';
import '../modules/spalsh/views/spalsh_view.dart';
import '../modules/view_details/bindings/view_details_binding.dart';
import '../modules/view_details/views/view_details_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPALSH;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
      children: [
        GetPage(
          name: _Paths.HOME,
          page: () => HomeView(),
          binding: HomeBinding(),
        ),
      ],
    ),
    GetPage(
      name: _Paths.AUTHENTACATION,
      page: () => const AuthentacationView(),
      binding: AuthentacationBinding(),
    ),
    GetPage(
      name: _Paths.ONBOARDING,
      page: () => const OnboardingView(),
      binding: OnboardingBinding(),
    ),
    GetPage(
      name: _Paths.SPALSH,
      page: () => const SpalshView(),
      binding: SpalshBinding(),
    ),
    GetPage(
      name: _Paths.LOG_IN,
      page: () => const LogInView(),
      binding: LogInBinding(),
    ),
    GetPage(
      name: _Paths.SIGN_IN,
      page: () => const SignInView(),
      binding: SignInBinding(),
    ),
    GetPage(
      name: _Paths.SIGNUP,
      page: () => const SignupView(),
      binding: SignupBinding(),
    ),
    GetPage(
      name: _Paths.DASHBOARD,
      page: () => DashboardView(),
      binding: DashboardBinding(),
    ),

    GetPage(
      name: _Paths.FORUM,
      page: () => const ForumView(),
      binding: ForumBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => ProfileView(),
      binding: ProfileBinding(),
    ),
    // GetPage(
    //   name: _Paths.PET_PROFILE,
    //   page: () => const PetProfileView(),
    //   binding: PetProfileBinding(),
    // ),

    GetPage(
      name: _Paths.SALES,
      page: () => SalesView(),
      binding: SalesBinding(),
    ),
    GetPage(
      name: _Paths.VIEW_DETAILS,
      page: () => const ViewDetailsView(),
      binding: ViewDetailsBinding(),
    ),
    GetPage(
      name: _Paths.OPEN_DEAL,
      page: () => const OpenDealView(),
      binding: OpenDealBinding(),
    ),
    GetPage(
      name: _Paths.CLOSED_DEAL,
      page: () => const ClosedDealView(),
      binding: ClosedDealBinding(),
    ),
    GetPage(
      name: _Paths.LEADER_BOARD,
      page: () => const LeaderBoardView(),
      binding: LeaderBoardBinding(),
    ),
    GetPage(
      name: _Paths.BADGES,
      page: () => const BadgesView(),
      binding: BadgesBinding(),
    ),
    GetPage(
      name: _Paths.EDIT_PROFILE,
      page: () => EditProfileView(),
      binding: EditProfileBinding(),
    ),
    GetPage(
      name: _Paths.SETTING,
      page: () => const SettingView(),
      binding: SettingBinding(),
    ),
  ];
}
