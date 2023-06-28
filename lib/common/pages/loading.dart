import 'dart:async';
// import 'package:creator_connect/features/auth/screens/auth_screen.dart';
import 'package:creator_connect/common/widgets/custom_loading_widget.dart';
import 'package:creator_connect/features/auth/screens/signup/screens/choose_login_signup_screen.dart';
import 'package:flutter/material.dart';

class LoadingAnimation extends StatelessWidget {
  static const String routeName = '/loading-screen';
  const LoadingAnimation({super.key});

  @override
  Widget build(BuildContext context) {
    //i know beautifully ugly code
    Timer(
        const Duration(milliseconds: 1500),
        () => Navigator.popAndPushNamed(
              context,
              LoginSignupScreen.routeName,
            ));

    return const LoadingWidget();
  }
}
