import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:how_to_do/featuers/auth/data/user_model.dart';
import 'package:how_to_do/featuers/auth/domain/services/auth_services/local_storage_auth_services.dart';
import '../../../../domain/repository/auth_reposetory.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<AppStarted>(_onAppStarted);
    on<SetupLocalization>(_onAuthSetupLocalization);
    on<Logout>(_onLoggedOut);
    on<Register>(_onRegistered);
    on<Loading>(_onLoading);
    on<Login>(_onLoggedIn);
  }

  //on app started -> check if first run, localization set, logged in
  void _onAppStarted(AppStarted event, Emitter<AuthState> emit) async {
    final loggedIn = await LocalStorageAuthServices.isLoggedInToLocalStorage();
    final isLocalizationSet = await LocalStorageAuthServices.isLocalizationDone();

    if (loggedIn) {
      CurrentUser.user = await LocalStorageAuthServices.getUserFromLocalStorage();
      emit(Authenticated());
    } else {
      if (!isLocalizationSet) {
        emit(AuthSetupLocalization());
      } else {
        emit(Unauthenticated());
      }
    }
  }

  void _onAuthSetupLocalization(SetupLocalization event, Emitter<AuthState> emit) async {
    await LocalStorageAuthServices.setLocalizationToLocalStorage(true);

    final isLocalizationSet = await LocalStorageAuthServices.isLocalizationDone();
    if (!isLocalizationSet) {
      emit(AuthSetupLocalization());
      return;
    }
    emit(Unauthenticated());
  }

  void _onLoggedOut(Logout event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      await AuthRepository.logout();
      emit(Unauthenticated());
    } catch (e) {
      emit(AuthError(message: e.toString()));
      return;
    }
  }

  void _onLoading(event, emit) => emit(AuthLoading());

  void _onLoggedIn(Login event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      await AuthRepository.login(event.email, event.password);
      emit(Authenticated());
    } catch (e) {
      emit(AuthError(message: e.toString()));
      return;
    }
  }

  void _onRegistered(Register event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      await AuthRepository.register(event.user, event.password);
      emit(Authenticated());
    } catch (e) {
      emit(AuthError(message: e.toString()));
      return;
    }
  }
}
