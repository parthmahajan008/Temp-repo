import 'package:creator_connect/common/pages/loading.dart';
import 'package:creator_connect/features/auth/screens/auth_screen.dart';
import 'package:creator_connect/features/splash_user_selection/screens/splash_screen.dart';
import 'package:flutter/material.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case AuthScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const AuthScreen(),
      );
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
