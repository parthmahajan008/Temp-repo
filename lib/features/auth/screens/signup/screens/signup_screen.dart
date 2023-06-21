import 'package:creator_connect/common/widgets/custom_button.dart';
import 'package:creator_connect/common/widgets/custom_text_field.dart';
import 'package:creator_connect/features/auth/screens/signIn/screens/signin_screen.dart';
import 'package:creator_connect/features/auth/services/auth%20bloc/auth_bloc.dart';
import 'package:creator_connect/features/auth/services/auth%20bloc/auth_event.dart';
import 'package:creator_connect/features/home/screens/home.dart';
import 'package:flutter/material.dart';

import 'package:creator_connect/constants/globalvariables.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../services/auth bloc/auth_state.dart';

class SignUpScreen extends StatefulWidget {
  static const String routeName = '/signup-screen';

  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool isChecked = true;
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController firstNamecontroller = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController businessNameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailcontroller.dispose();
    firstNamecontroller.dispose();
    lastNameController.dispose();
    passwordController.dispose();
    businessNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(
              Icons.arrow_back_ios_new,
              size: 30,
            )),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0),
            child: ElevatedButton(
              onPressed: () => Navigator.pushReplacementNamed(
                  context, SignInScreen.routeName),
              style: ButtonStyle(
                elevation: MaterialStateProperty.resolveWith<double>(
                  (Set<MaterialState> states) {
                    // if (states.contains(MaterialState.disabled)) {
                    //   return 2;
                    // }
                    return 2;
                  },
                ),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40.0),
                    side: const BorderSide(color: Colors.black26),
                  ),
                ),
              ),
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  "SignIn",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: GlobalVariables.secondaryTextColor),
                ),
              ),
            ),
          )
        ],
      ),
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is Loading) {
            ScaffoldMessenger.of(context)
                .showSnackBar(const SnackBar(content: Text("Loading...")));
          }
          if (state is Authenticated) {
            // Navigating to the dashboard screen if the user is authenticated
            Navigator.of(context).pushNamedAndRemoveUntil(
              HomeScreenBusiness.routeName,
              (route) => false,
            );
          }
          if (state is AuthError) {
            // Displaying the error message if the user is not authenticated
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.error)));
          }
        },
        builder: (context, state) {
          if (state is Loading) {
            // Displaying the loading indicator while the user is signing up
            return const Center(child: CircularProgressIndicator());
          }
          if (state is UnAuthenticated) {
            // Displaying the sign up form if the user is not authenticated
            return SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Setup Your Profile ✍🏻",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 32,
                      ),
                    ),
                    const Text(
                      "Setup your account. Grow your business with CreAd",
                      style: TextStyle(fontSize: 18, color: Colors.black45),
                    ),
                    SizedBox(
                      height: size.height * 0.03,
                    ),
                    Form(
                      key: _formKey,
                      child: Column(children: [
                        CustomTextField(
                          controller: firstNamecontroller,
                          hintText: "First Name",
                        ),
                        SizedBox(
                          height: size.height * 0.02,
                        ),
                        CustomTextField(
                          controller: lastNameController,
                          hintText: "Last Name",
                        ),
                        SizedBox(
                          height: size.height * 0.02,
                        ),
                        CustomTextField(
                          controller: businessNameController,
                          hintText: "Registered Business Name",
                        ),
                        SizedBox(
                          height: size.height * 0.02,
                        ),
                        CustomTextField(
                          controller: emailcontroller,
                          hintText: "Email",
                        ),
                        SizedBox(
                          height: size.height * 0.02,
                        ),
                        CustomTextField(
                          controller: passwordController,
                          hintText: "Password",
                        ),
                        SizedBox(
                          height: size.height * 0.02,
                        ),
                        InkWell(
                          onTap: () {},
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(20)),
                            height: size.height * 0.13,
                            width: double.infinity,
                            child: const Center(
                                child: Icon(
                              Icons.map,
                              color: Colors.black54,
                            )),
                          ),
                        ),
                      ]),
                    ),
                    SizedBox(
                      height: size.height * 0.03,
                    ),
                    CheckboxListTile(
                      title: const Text(
                        """By tapping Continue. I've read and agree to the E-Sign Disclosure and Consent to receive all communications electronically""",
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.black54,
                        ),
                      ),
                      controlAffinity: ListTileControlAffinity.leading,
                      value: isChecked,
                      checkColor: Colors.black,
                      activeColor: Colors.grey,
                      onChanged: (bool? value) {
                        setState(() {
                          isChecked = value!;
                        });
                      },
                    ),
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                    CustomButton(
                        text: "Continue",
                        onTap: () {
                          _createAccountWithEmailAndPassword(context);
                        })
                  ],
                ),
              ),
            );
          }
          return Container();
        },
      ),
    );
  }

  void _createAccountWithEmailAndPassword(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      BlocProvider.of<AuthBloc>(context).add(
        SignUpRequested(
          email: emailcontroller.text,
          password: passwordController.text,
          firstName: firstNamecontroller.text,
          lastName: lastNameController.text,
          businessName: businessNameController.text,
        ),
      );
    }
  }
}
