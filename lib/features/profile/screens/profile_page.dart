import 'package:creator_connect/features/auth/screens/signIn/screens/signin_screen.dart';
import 'package:creator_connect/features/auth/services/auth%20bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../auth/services/auth bloc/auth_event.dart';
import '../../auth/services/auth bloc/auth_state.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            child: ElevatedButton(
          onPressed: () {
            context.read<AuthBloc>().add(LogOutRequested());
          },
          child: Text('LOGOUT'),
        )),
      ),
    );
  }
}
