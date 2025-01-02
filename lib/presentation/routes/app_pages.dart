import 'package:demo_app/presentation/modules/base/bindings/base_binding.dart';
import 'package:demo_app/presentation/modules/base/views/base_view.dart';
import 'package:demo_app/presentation/modules/home/bindings/home_binding.dart';
import 'package:demo_app/presentation/modules/profile/bindings/profile_binding.dart';
import 'package:demo_app/presentation/modules/profile/views/profile_view.dart';
import 'package:demo_app/presentation/modules/profile_details/bindings/profile_details.dart';
import 'package:demo_app/presentation/modules/profile_details/views/profile_details_view.dart';
import 'package:demo_app/presentation/modules/setting/bindings/setting_binding.dart';
import 'package:demo_app/presentation/modules/setting/views/setting_view.dart';
import 'package:demo_app/presentation/routes/app_routes.dart';
import 'package:demo_app/presentation/screens/forgot_password_screen.dart';
import 'package:demo_app/presentation/screens/games/games_home_screen.dart';
import 'package:demo_app/presentation/screens/games/sudoku/difficulty_level_screen.dart';
import 'package:demo_app/presentation/screens/games/sudoku/game_result.dart';
import 'package:demo_app/presentation/screens/games/sudoku/game_roule_screen.dart';
import 'package:demo_app/presentation/screens/games/sudoku/game_win_screen.dart';
import 'package:demo_app/presentation/screens/games/sudoku/sudoku_screen.dart';
import 'package:demo_app/presentation/screens/home_screen.dart';
import 'package:demo_app/presentation/screens/login_screen.dart';
import 'package:demo_app/presentation/screens/on_boarding_screen.dart';
import 'package:demo_app/presentation/screens/otp_verification_screen.dart';
import 'package:demo_app/presentation/screens/product_details.dart';
import 'package:demo_app/presentation/screens/search_screen.dart';
import 'package:demo_app/presentation/screens/signup_screen.dart';
import 'package:demo_app/presentation/screens/splash_screen.dart';
import 'package:get/get.dart';

class AppPages {
    static const beforeAuthentication = AppRoutes.splash;
    static const afterAuthentication = AppRoutes.base;

  static final routes = [
    // Auth Flow
    GetPage(name: AppRoutes.splash, page: () => SplashScreen()),
    GetPage(name: AppRoutes.onboarding, page: () =>  OnBoardingScreen()),
    GetPage(name: AppRoutes.gamesHome, page: () =>  const GamesHomeScreen()),
    GetPage(name: AppRoutes.difficultyLevel, page: () => const DifficultyLevelScreen()),
    GetPage(name: AppRoutes.gameRoule, page: () => const GameRoule()),
    GetPage(name: AppRoutes.sudoku, page: () => const SudokuScreen()),
    GetPage(name: AppRoutes.gameWin, page: () => const GameWinScreen()),
    GetPage(name: AppRoutes.gameResult, page: () => const GameResult()),
    GetPage(name: AppRoutes.login, page: () => const LoginScreen()),
    GetPage(name: AppRoutes.signup, page: () => const SignupScreen()),
    GetPage(name: AppRoutes.forgotPassword, page: () => ForgotPasswordScreen()),
    GetPage(
        name: AppRoutes.otpVerification, page: () => OtpVerificationScreen()),

    // Main Flow
     GetPage(
      name: AppRoutes.base,
      page: () => const BaseView(),
      binding: BaseBinding(),
    ),
    GetPage(name: AppRoutes.home, 
    page: () => const HomeScreen(),
    binding: HomeBinding(),
    ),
    GetPage(name: AppRoutes.search, page: () => const SearchScreen()),
    //page: () => const HomeView(),
    //binding: HomeBinding(),
    GetPage(
      name: AppRoutes.settings,
      page: () => const SettingView(),
      binding: SettingBinding(),
    ),
    GetPage(
      name: AppRoutes.profile,
      page: () => const ProfileView(),
      binding: ProfileBinding(),
    ),
       GetPage(
      name: AppRoutes.profileDetails,
      page: () => const ProfileDetailsView(),
      binding: ProfileDetailsBinding(),
    ),
    GetPage(
        name: AppRoutes.productDetails,
        page: () => ProductDetails(
              productInfo: Get.arguments,
            ),
        binding: HomeBinding()),
  ];
}
