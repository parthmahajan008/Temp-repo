import 'package:creator_connect/common/pages/loading.dart';

import 'package:creator_connect/features/auth/screens/signIn/screens/signin_screen.dart';
import 'package:creator_connect/features/auth/screens/signup/screens/choose_login_signup_screen.dart';
import 'package:creator_connect/features/auth/screens/signup/screens/signup_screen.dart';
import 'package:creator_connect/features/auth/screens/signup/screens/welcome_advantages.dart';
import 'package:creator_connect/features/home/screens/collaboration_subpage.dart';
import 'package:creator_connect/features/home/screens/home.dart';
import 'package:creator_connect/features/user_type/screens/user_type_selection.dart';
import 'package:flutter/material.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case LoadingAnimation.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const LoadingAnimation(),
      );
    case SplashScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const SplashScreen(),
      );
    case HomeScreenBusiness.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => HomeScreenBusiness(),
      );
    case CollaborationSubPage.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => CollaborationSubPage(),
      );
    case SignUpScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const SignUpScreen(),
      );
    case SignInScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => SignInScreen(),
      );
    case LoginSignupScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const LoginSignupScreen(),
      );
    case WelcomeAdvantages.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const WelcomeAdvantages(),
      );
    default:
      return MaterialPageRoute(
        builder: (_) => const Scaffold(
          body: Center(
            child: Text('No route defined for this'),
          ),
        ),
      );
  }
}
