part of 'auth_bloc.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthFirstRun extends AuthState {}

class Authenticated extends AuthState {}

class Unauthenticated extends AuthState {}
