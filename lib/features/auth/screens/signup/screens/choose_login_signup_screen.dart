import 'package:creator_connect/common/widgets/custom_button.dart';
import 'package:creator_connect/features/auth/screens/signIn/screens/signin_screen.dart';
import 'package:creator_connect/features/auth/screens/signup/screens/welcome_advantages.dart';
import 'package:flutter/material.dart';

class LoginSignupScreen extends StatelessWidget {
  static const String routeName = '/login-signup-screen';
  const LoginSignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            children: [
              Center(
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  height: 300,
                  width: 300,
                  child: Image.asset(
                    'assets/images/signup-login.jpg',
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(bottom: 10.0),
                child: Text(
                  "Welcome to\nCreaAd",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(bottom: 10.0),
                child: Text(
                  """CreaAD is the perfect platform for businesses to connect with creators and collaborate on projects.""",
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 0, left: 0, bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Icon(
                        Icons.search,
                        color: Colors.black.withOpacity(0.5),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Icon(
                        Icons.document_scanner,
                        color: Colors.black.withOpacity(0.5),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Icon(
                        Icons.auto_graph_sharp,
                        color: Colors.black.withOpacity(0.5),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Icon(
                        Icons.person,
                        color: Colors.black.withOpacity(0.5),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.18,
              ),
              CustomButton(
                text: "Login",
                onTap: () => Navigator.of(context).pushNamed(
                  SignInScreen.routeName,
                ),
                color: Colors.white,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
              ),
              CustomButton(
                text: "Register",
                onTap: () => Navigator.of(context).pushNamed(
                  WelcomeAdvantages.routeName,
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
              ),
              const Text(
                "Continue as guest",
                style: TextStyle(color: Colors.black54),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
