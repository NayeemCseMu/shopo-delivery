import 'package:flutter/material.dart';

import '/modules/order/request_order_details.dart';
import '/modules/withdraw/waller_screen.dart';
import '../modules/animated_splash_screen/animated_splash_screen.dart';
import '../modules/authentication/authentication_screen.dart';
import '../modules/authentication/forgot_screen.dart';
import '../modules/authentication/setpassword_screen.dart';
import '../modules/authentication/verification_code_screen.dart';
import '../modules/home/home_screen.dart';
import '../modules/onboarding/onboarding_screen.dart';
import '../modules/profile/profile_edit.dart';

class RouteNames {
  static const String onboardingScreen = '/onboardingScreen';
  static const String animatedSplashScreen = '/';
  static const String mainPage = '/mainPage';
  static const String homeScreen = '/homeScreen';
  static const String authenticationScreen = '/authenticationScreen';
  static const String forgotScreen = '/forgotScreen';
  static const String verificationCodeScreen = '/verificationCodeScreen';
  static const String setpasswordScreen = '/setpasswordScreen';
  static const String editProfileScreen = '/editProfileScreen';
  static const String details = '/details';
  static const String withdraw = '/withdraw';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.onboardingScreen:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const OnboardingScreen());
      // case RouteNames.changePasswordScreen:
      //   return MaterialPageRoute(
      //       settings: settings, builder: (_) => const ChangePasswordScreen());
      //
      // case RouteNames.maintainScreen:
      //   return MaterialPageRoute(
      //       settings: settings, builder: (_) => const MaintainScreen());
      //
      // case RouteNames.mainPage:
      //   return MaterialPageRoute(
      //       settings: settings, builder: (_) => const MainPage());
      case RouteNames.homeScreen:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const HomeScreen());
      case RouteNames.animatedSplashScreen:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const AnimatedSplashScreen());
      case RouteNames.authenticationScreen:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const AuthenticationScreen());
      case RouteNames.forgotScreen:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const ForgotScreen());
      case RouteNames.verificationCodeScreen:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const VerificationCodeScreen());
      case RouteNames.setpasswordScreen:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const SetPasswordScreen());

      case RouteNames.editProfileScreen:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const ProfileEditScreen());

      case RouteNames.withdraw:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const WalletScreen());

      case RouteNames.details:
        final id = settings.arguments as String;
        return MaterialPageRoute(
            settings: settings,
            builder: (_) => RequestOrderDetails(orderId: id));

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
