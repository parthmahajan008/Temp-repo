import 'package:creator_connect/common/pages/loading.dart';

import 'package:creator_connect/features/auth/screens/signIn/screens/signin_screen.dart';
import 'package:creator_connect/features/auth/screens/signup/screens/choose_login_signup_screen.dart';
import 'package:creator_connect/features/auth/screens/signup/screens/signup_screen.dart';
import 'package:creator_connect/features/auth/screens/signup/screens/welcome_advantages.dart';
import 'package:creator_connect/features/chat/screens/chat_screen.dart';
import 'package:creator_connect/features/home/screens/collaboration_subpage.dart';
import 'package:creator_connect/features/home/screens/home.dart';
import 'package:creator_connect/features/user_type/screens/user_type_selection.dart';
import 'package:flutter/material.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  return MaterialPageRoute(
    settings: routeSettings,
    builder: (_) {
      switch (routeSettings.name) {
        case LoadingAnimation.routeName:
          return const LoadingAnimation();
        case SplashScreen.routeName:
          return const SplashScreen();
        case HomeScreenBusiness.routeName:
          return const HomeScreenBusiness();
        case CollaborationSubPage.routeName:
          return const CollaborationSubPage();
        case SignUpScreen.routeName:
          return const SignUpScreen();
        case SignInScreen.routeName:
          return const SignInScreen();
        case LoginSignupScreen.routeName:
          return const LoginSignupScreen();
        case WelcomeAdvantages.routeName:
          return const WelcomeAdvantages();
        case ChatScreen.routeName:
          return const ChatScreen();
        default:
          return const Text('No route defined for this');
      }
    },
  );
}
