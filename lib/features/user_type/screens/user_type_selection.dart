import 'package:creator_connect/common/pages/loading.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  static const String routeName = '/splash-screen';
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            GestureDetector(
              onTap: () => Navigator.of(context)
                  .popAndPushNamed(LoadingAnimation.routeName),
              child: Container(
                color: Colors.transparent,
                child: Column(
                  children: [
                    Container(
                      height: 100,
                      width: 100,
                      child: Image.asset(
                        'assets/images/business-splash.png',
                        fit: BoxFit.fill,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.all(10),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Text(
                        "Register as Business",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () => Navigator.of(context)
                  .popAndPushNamed(LoadingAnimation.routeName),
              child: Container(
                color: Colors.transparent,
                child: Column(
                  children: [
                    Container(
                      height: 100,
                      width: 100,
                      child: Image.asset(
                        'assets/images/creator-splash.png',
                        fit: BoxFit.fill,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.all(10),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Text(
                        "Register as Creator",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }
}
