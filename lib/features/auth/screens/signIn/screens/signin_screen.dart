// import 'package:creator_connect/common/widgets/custom_text_field.dart';
import 'package:creator_connect/features/auth/screens/signup/screens/choose_login_signup_screen.dart';
import 'package:creator_connect/features/auth/services/auth%20bloc/auth_bloc.dart';
import 'package:creator_connect/features/auth/services/auth%20bloc/auth_event.dart';
import 'package:creator_connect/features/auth/services/auth%20bloc/auth_state.dart';
import 'package:creator_connect/features/home/screens/home.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../common/widgets/custom_button.dart';

class SignInScreen extends StatefulWidget {
  static const String routeName = '/signin-screen';

  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailcontroller = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    emailcontroller.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () => Navigator.pushNamedAndRemoveUntil(
                  context, LoginSignupScreen.routeName, (route) => false),
              icon: const Icon(
                Icons.arrow_back_ios_new,
                size: 30,
              )),
        ),
        body: BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is Authenticated) {
              Navigator.of(context).pushNamedAndRemoveUntil(
                HomeScreenBusiness.routeName,
                (route) => false,
              );
            }
            if (state is AuthError) {
              // Showing the error message if the user has entered invalid credentials
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(state.error)));
            }
          },
          child: BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              if (state is Loading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state is UnAuthenticated) {
                return UnauthenticatedWidget(
                    size: size,
                    formKey: _formKey,
                    emailcontroller: emailcontroller,
                    passwordController: passwordController);
              }
              return Container();
            },
          ),
        )
        //
        );
  }
}

class UnauthenticatedWidget extends StatefulWidget {
  const UnauthenticatedWidget({
    super.key,
    required this.size,
    required GlobalKey<FormState> formKey,
    required this.emailcontroller,
    required this.passwordController,
  }) : _formKey = formKey;

  final Size size;
  final GlobalKey<FormState> _formKey;
  final TextEditingController emailcontroller;
  final TextEditingController passwordController;

  @override
  State<UnauthenticatedWidget> createState() => _UnauthenticatedWidgetState();
}

class _UnauthenticatedWidgetState extends State<UnauthenticatedWidget> {
  bool _passwordVisible = false;
  void _authenticateWithEmailAndPassword(context) {
    if (widget._formKey.currentState!.validate()) {
      BlocProvider.of<AuthBloc>(context).add(
        SignInRequested(
            widget.emailcontroller.text, widget.passwordController.text),
      );
    }
  }

  @override
  void initState() {
    _passwordVisible = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Welcome Back 👋🏻",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 32,
              ),
            ),
            const Text(
              "We are so excited to see you again",
              style: TextStyle(fontSize: 18, color: Colors.black45),
            ),
            SizedBox(
              height: widget.size.height * 0.03,
            ),
            Form(
              key: widget._formKey,
              child: Column(
                children: [
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    controller: widget.emailcontroller,
                    validator: (value) {
                      return value != null && !EmailValidator.validate(value)
                          ? 'Enter a valid email'
                          : null;
                    },
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: const BorderSide(
                          color: Colors.grey,
                          width: 2.0,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: const BorderSide(
                          color: Colors.grey,
                        ),
                      ),
                      fillColor: Colors.white,
                      filled: true,
                      hintText: "Enter your Email here...",
                    ),
                  ),
                  SizedBox(
                    height: widget.size.height * 0.02,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: !_passwordVisible,
                    validator: (value) {
                      return value != null && value.length < 6
                          ? "Enter min. 6 characters"
                          : null;
                    },
                    controller: widget.passwordController,
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        icon: Icon(
                          _passwordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Colors.grey,
                        ),
                        onPressed: () {
                          setState(
                            () {
                              _passwordVisible = !_passwordVisible;
                            },
                          );
                        },
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: const BorderSide(
                          color: Colors.grey,
                          width: 2.0,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: const BorderSide(
                          color: Colors.grey,
                        ),
                      ),
                      fillColor: Colors.white,
                      filled: true,
                      hintText: "Enter Password Here...",
                    ),
                  ),
                  SizedBox(
                    height: widget.size.height * 0.01,
                  ),
                ],
              ),
            ),
            InkWell(
              onTap: () {},
              child: const SizedBox(
                width: double.infinity,
                child: Text(
                  "Forgot Password?",
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: widget.size.height * 0.48,
            ),
            CustomButton(
                text: "Continue",
                onTap: () {
                  _authenticateWithEmailAndPassword(context);
                })
          ],
        ),
      ),
    );
  }
}
