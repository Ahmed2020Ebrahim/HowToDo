part of 'login_button_bloc.dart';

@immutable
sealed class LoginButtonEvent {}

class LoginButtonInitialEvent extends LoginButtonEvent {}

class LoginButtonPressedEvent extends LoginButtonEvent {}
