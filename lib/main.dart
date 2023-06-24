import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:creator_connect/constants/globalvariables.dart';
import 'package:creator_connect/features/auth/services/auth_repository.dart';

import 'package:creator_connect/features/home/screens/home.dart';
import 'package:creator_connect/features/user_type/screens/user_type_selection.dart';
import 'package:creator_connect/firebase_options.dart';
import 'package:creator_connect/router.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:invert_colors/invert_colors.dart';

import 'features/auth/services/auth bloc/auth_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => AuthRepository(),
      child: BlocProvider(
        create: (context) => AuthBloc(
          authRepository: RepositoryProvider.of<AuthRepository>(context),
        ),
        child: MaterialApp(
          title: 'Creator Connect',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: const ColorScheme.light(
                primary: GlobalVariables.secondaryColor),
            scaffoldBackgroundColor: GlobalVariables.backgroundColor,
            appBarTheme: const AppBarTheme(
              elevation: 0.0,
              iconTheme: IconThemeData(
                color: Colors.black,
              ),
            ),
          ),
          onGenerateRoute: (settings) => generateRoute(settings),
          home: StreamBuilder<User?>(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              // If the snapshot has user data, then they're already signed in. So Navigating to the Dashboard.
              if (snapshot.hasData) {
                return HomeScreenBusiness();
              }
              // Otherwise, they're not signed in. Show the sign in page.
              return const LandingScreen();
            },
          ),
        ),
      ),
    );
  }
}

class LandingScreen extends StatelessWidget {
  const LandingScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Center(
          child: InvertColors(
        child: SizedBox(
          height: 350,
          width: 350,
          child: Image.asset(
            'assets/images/logo.png',
            fit: BoxFit.cover,
          ),
        ),
      )),
      nextScreen: const SplashScreen(),
      duration: 2000,
      splashTransition: SplashTransition.fadeTransition,
      backgroundColor: Colors.white,
    );
  }
}
