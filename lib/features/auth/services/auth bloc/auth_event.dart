// Events are nothing but different actions (button click, submit, etc)
//triggered by the user from UI. It contains information about the action and
//gives it to the Bloc to handle.

import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  @override
  List<Object> get props => [];
}

// When the user signing in with email and password this event is called and the [AuthRepository] is called to sign in the user
class SignInRequested extends AuthEvent {
  final String email;
  final String password;

  SignInRequested(this.email, this.password);
}

// When the user signing up with email and password this event is called and the [AuthRepository] is called to sign up the user
class SignUpRequested extends AuthEvent {
  final String email;
  final String password;
  final String firstName;
  final String lastName;
  final String businessName;
  SignUpRequested(
      {required this.email,
      required this.password,
      required this.firstName,
      required this.lastName,
      required this.businessName});
}

// When the user signing in with google this event is called and the [AuthRepository] is called to sign in the user
// class GoogleSignInRequested extends AuthEvent {}

// When the user signing out this event is called and the [AuthRepository] is called to sign out the user
class LogOutRequested extends AuthEvent {}
