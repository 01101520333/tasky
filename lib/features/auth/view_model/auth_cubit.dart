import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:tasky/core/network/resulet_firebase.dart';
import 'package:tasky/features/auth/data/firebase/app_firebase_auth.dart';
import 'package:tasky/features/auth/data/model/app_user.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  void login({required String email, required String password}) async {
    emit(AuthLoading());
    ResuletFirebase<bool> resulte = await AppFirebaseAuth.logIn(
      email: email,
      password: password,
    );
    switch (resulte) {
      case Success<bool>():
        emit(AuthSuccess());
      case Error<bool>():
        emit(AuthError(resulte.error));
    }
  }

  void register({required AppUser user}) async {
    emit(AuthLoading());
    ResuletFirebase<AppUser> resulte = await AppFirebaseAuth.register(
      user: user,
    );
    switch (resulte) {
      case Success<AppUser>():
        emit(AuthSuccess());
      case Error<AppUser>():
        emit(AuthError(resulte.error));
    }
  }
}
