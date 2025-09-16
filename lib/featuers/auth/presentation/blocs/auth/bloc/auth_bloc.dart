import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/auth_reposetory.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;

  AuthBloc({required this.authRepository}) : super(AuthInitial()) {
    on<AppStarted>(_onAppStarted);
    on<FirstRunCompleted>(_onFirstRunCompleted);
    on<LoggedIn>(_onLoggedIn);
    on<LoggedOut>(_onLoggedOut);
  }

  void _onAppStarted(AppStarted event, Emitter<AuthState> emit) async {
    final loggedIn = await authRepository.isLoggedIn();
    final isFirstRun = await authRepository.isFirstRun();

    if (isFirstRun) {
      emit(AuthFirstRun());
    } else if (loggedIn) {
      emit(Authenticated());
    } else {
      emit(Unauthenticated());
    }
  }

  void _onFirstRunCompleted(FirstRunCompleted event, Emitter<AuthState> emit) async {
    //check if it is first run
    final isFirstRun = await authRepository.isFirstRun();
    log("value is : $isFirstRun");
    if (isFirstRun) {
      await authRepository.setFirstRun(false);
      emit(AuthFirstRun());
      return;
    }
    await authRepository.setFirstRun(false);
    emit(Unauthenticated());
  }

  void _onLoggedIn(LoggedIn event, Emitter<AuthState> emit) async {
    await authRepository.login();
    emit(Authenticated());
  }

  void _onLoggedOut(LoggedOut event, Emitter<AuthState> emit) async {
    await authRepository.logout();
    emit(Unauthenticated());
  }
}
