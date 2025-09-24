part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {}

class AppStarted extends AuthEvent {}

class SetupLocalization extends AuthEvent {}

class Logout extends AuthEvent {}

class Loading extends AuthEvent {}

class Login extends AuthEvent {
  final String email;
  final String password;

  Login({required this.email, required this.password});
}

class Register extends AuthEvent {
  final UserModel user;
  final String password;

  Register({required this.user, required this.password});
}
