import 'package:daif_owner/view/screens/auth/screen/otp_screen.dart';
import 'package:daif_owner/view/screens/dashboard/screen/dashboard_screen.dart';
import 'package:daif_owner/view/screens/my_places/screen/add_new_chalet_screen.dart';
import 'package:daif_owner/view/screens/onboarding/screen/on_boarding_screen.dart';
import 'package:get/get.dart';

import '../bindings/binding.dart';
import '../bindings/middlewares.dart';
import '../view/screens/auth/screen/login_screen.dart';
import '../view/screens/auth/screen/resgister_screen.dart';
import '../view/screens/splash/splash_screen.dart';
part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const initialRoute = Routes.splash;
  static final routes = [
    GetPage(
        name: initialRoute,
        page: () => SplashScreen(),
        binding: SplashBinding(),

    ),
    GetPage(
        name: Routes.onBoarding,
        page: () => const OnBoardingScreen(),
        binding: OnBoardingBinding(),
        middlewares: [OnBoardingMiddleWare()]
    ),
    GetPage(
      name: Routes.login,
      page: () => const LoginScreen(),
      binding: AuthBinding(),
        middlewares: [AuthMiddleware()]

    ),
    GetPage(
        name: Routes.register,
        page: () => const RegisterScreen(),
        binding: AuthBinding(),

    ),
    GetPage(
      name: Routes.otp,
      page: () => const OtpScreen(),
      binding: AuthBinding(),

    ),
    GetPage(
        name: Routes.dashboard,
        page: () => const DashboardScreen(),
        binding: DashBoardBinding(),
    ),
    GetPage(
      name: Routes.addNewChalet,
      page: () => const AddNewChaletScreen(),
    ),
  ];
}
