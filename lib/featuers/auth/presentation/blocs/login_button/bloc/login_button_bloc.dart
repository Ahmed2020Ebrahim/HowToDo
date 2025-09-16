import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

part 'login_button_event.dart';
part 'login_button_state.dart';

class LoginButtonBloc extends Bloc<LoginButtonEvent, LoginButtonState> {
  LoginButtonBloc() : super(LoginButtonInitial()) {
    on<LoginButtonEvent>((event, emit) {
      log("Event: $event");
    });
    on<LoginButtonPressedEvent>((event, emit) async {
      emit(LoginButtonLoading());
      // Simulate a login process
      await Future.delayed(const Duration(seconds: 2), () {
        emit(LoginButtonInitial());
      });
    });
  }
}
