import 'package:get/get.dart';

import '../modules/authentacation/bindings/authentacation_binding.dart';
import '../modules/authentacation/views/authentacation_view.dart';
import '../modules/dashboard/bindings/dashboard_binding.dart';
import '../modules/dashboard/views/dashboard_view.dart';
import '../modules/explore/bindings/explore_binding.dart';
import '../modules/explore/views/explore_view.dart';
import '../modules/forum/bindings/forum_binding.dart';
import '../modules/forum/views/forum_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/home/views/home_view.dart';
import '../modules/log_in/bindings/log_in_binding.dart';
import '../modules/log_in/views/log_in_view.dart';
import '../modules/onboarding/bindings/onboarding_binding.dart';
import '../modules/onboarding/views/onboarding_view.dart';
import '../modules/pet_profile/bindings/pet_profile_binding.dart';
import '../modules/pet_profile/views/pet_profile_view.dart';
import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/views/profile_view.dart';
import '../modules/services/bindings/services_binding.dart';
import '../modules/services/views/services_view.dart';
import '../modules/sign_in/bindings/sign_in_binding.dart';
import '../modules/sign_in/views/sign_in_view.dart';
import '../modules/signup/bindings/signup_binding.dart';
import '../modules/signup/views/signup_view.dart';
import '../modules/spalsh/bindings/spalsh_binding.dart';
import '../modules/spalsh/views/spalsh_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPALSH;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
      children: [
        GetPage(
          name: _Paths.HOME,
          page: () => const HomeView(),
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
      name: _Paths.EXPLORE,
      page: () => const ExploreView(),
      binding: ExploreBinding(),
    ),
    GetPage(
      name: _Paths.SERVICES,
      page: () => const ServicesView(),
      binding: ServicesBinding(),
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
    GetPage(
      name: _Paths.PET_PROFILE,
      page: () => const PetProfileView(),
      binding: PetProfileBinding(),
    ),
  ];
}
