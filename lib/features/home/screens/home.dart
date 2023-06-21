import 'package:creator_connect/features/auth/screens/signIn/screens/signin_screen.dart';
import 'package:creator_connect/features/auth/services/auth%20bloc/auth_bloc.dart';
import 'package:creator_connect/features/auth/services/auth%20bloc/auth_event.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../auth/services/auth bloc/auth_state.dart';

class HomeScreenBusiness extends StatelessWidget {
  static const String routeName = '/home-screen';
  const HomeScreenBusiness({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    print(user);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
      ),
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is UnAuthenticated) {
            // Navigate to the sign in screen when the user Signs Out
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => SignInScreen()),
              (route) => false,
            );
          }
        },
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Email: \n ${user.email}',
                style: const TextStyle(fontSize: 24),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                child: const Text(
                  'Sign Out',
                  style: TextStyle(color: Colors.black),
                ),
                onPressed: () {
                  // Signing out the user
                  context.read<AuthBloc>().add(LogOutRequested());
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
