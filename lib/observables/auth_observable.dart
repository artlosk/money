import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

// import 'package:firebase_auth/firebase_auth.dart';
import 'package:mobx/mobx.dart';
import 'package:money_tracker/views/profile_view.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../models/user_model.dart';

part 'auth_observable.g.dart';

// final FirebaseAuth _auth = FirebaseAuth.instance;

IOSOptions _getIOSOptions() => const IOSOptions(
      accessibility: IOSAccessibility.first_unlock,
    );

AndroidOptions _getAndroidOptions() => const AndroidOptions(
      encryptedSharedPreferences: true,
    );

final _storage = const FlutterSecureStorage();

class AuthState = _AuthState with _$AuthState;

abstract class _AuthState with Store {
  _AuthState();

  @observable
  bool isSignIn = false;

  //bool isSignIn = false;//_auth.currentUser?.uid != null ? true : false;
  //bool isSignIn = getUser().

  @observable
  bool isLoading = false;

  @observable
  String errorAuth = '';

  @observable
  UserModel? currentUser;

  // @action
  // Future setImageUrl({required String url}) async {
  //   await _auth.currentUser?.updatePhotoURL(url);
  // }
  //
  // @action
  // Future signUpWithEmailAndPassword(
  //     {required String email, required String password}) async {
  //   errorAuth = '';
  //   isLoading = true;
  //   try {
  //     await _auth.createUserWithEmailAndPassword(
  //       email: email,
  //       password: password,
  //     );
  //     isSignIn = true;
  //     isLoading = false;
  //     return null;
  //   } on FirebaseAuthException catch (e) {
  //     isLoading = false;
  //     if (e.code == 'email-already-in-use') {
  //       errorAuth = 'login.ERROR_EMAIL_DUPLICATE';//'Данный Email существует, попробуйте другой';
  //     } else {
  //       errorAuth = 'login.ERROR_SING_IN_ERROR';
  //     }
  //     return e.message;
  //   }
  // }
  @action
  Future signUpWithEmailAndPassword(
      {required String email, required String password}) async {
    errorAuth = '';
    isLoading = true;
    try {
      final Dio _dio = Dio();
      final response = await _dio.post(
          'http://10.0.2.2:80/cabinet/default/sign-up',
          data: {"login": email, "password": password});
      await _storage.write(
          key: 'token',
          value: response.data['accessToken'],
          iOptions: _getIOSOptions(),
          aOptions: _getAndroidOptions());
      isSignIn = true;
      isLoading = false;
      return response.data['accessToken'];
    } on DioError catch (e) {
      isLoading = false;
      // if (e.code == 'email-already-in-use') {
      //   errorAuth = 'login.ERROR_EMAIL_DUPLICATE';//'Данный Email существует, попробуйте другой';
      // } else {
      //   errorAuth = 'login.ERROR_SING_IN_ERROR';
      // }
      errorAuth = e.message;
      return e.message;
    }
  }

  //
  // @action
  // Future signInWithEmailAndPassword(
  //     {required String email, required String password}) async {
  //   errorAuth = '';
  //   isLoading = true;
  //   try {
  //     await _auth.signInWithEmailAndPassword(email: email, password: password);
  //     isLoading = false;
  //     isSignIn = true;
  //     return null;
  //   } on FirebaseAuthException catch (e) {
  //     print(e.code);
  //     isLoading = false;
  //     errorAuth = 'login.ERROR_SIGN_IN_ERROR';
  //     return e.message;
  //   }
  // }
  @action
  Future signInWithEmailAndPassword(
      {required String email, required String password}) async {
    errorAuth = '';
    isLoading = true;
    isSignIn = false;
    try {
      //await _auth.signInWithEmailAndPassword(email: email, password: password);
      final Dio _dio = Dio();
      final response =
          await _dio.post('http://10.0.2.2:80/cabinet/default/sign-in',
              data: {"login": email, "password": password},
              options: Options(
                headers: {
                  'Connection': 'Keep-Alive',
                },
              ),
          );
      if (response.statusCode == 200) {
        //isSignIn = true;
        //prefs.setString('token', response.data['accessToken']);
        await _storage.write(
            key: 'token',
            value: response.data['accessToken'],
            iOptions: _getIOSOptions(),
            aOptions: _getAndroidOptions());
        isSignIn = true;
        isLoading = false;
        return response.data['accessToken'];
      }
    } on DioError catch (e) {
      isLoading = false;
      isSignIn = false;
      print(e);
      errorAuth = 'login.ERROR_SIGN_IN_ERROR';
      //return e.message;
    }
  }

  //
  // @action
  // Future restPassword(email) async {
  //   FirebaseAuth.instance.sendPasswordResetEmail(email: email).then((_) {
  //     print('success');
  //   }).catchError((error) {
  //     print('error');
  //   });
  // }
  //
  // @action
  // Future<bool> signOut() async {
  //   _auth.signOut();
  //   isSignIn = false;
  //   return await Future.value(true);
  // }
  //
  // Stream<User?> get onAuthStateChanged {
  //   if (_auth.currentUser?.uid != null ) {
  //     isSignIn = true;
  //   } else {
  //     isSignIn = false;
  //   }
  //   return _auth.authStateChanges();
  // }

  @action
  Future<UserModel?> getUser() async {
    final Dio _dio = Dio();
    //return prefs.then((value) async {
    //String token = value.getString('token') ?? '';
    //final SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = await _storage.read(
            key: 'token',
            iOptions: _getIOSOptions(),
            aOptions: _getAndroidOptions()) ??
        '';
    print(token);
    try {
      final response =
          await _dio.get('http://10.0.2.2:80/cabinet/default/get-user',
              options: Options(
                headers: {
                  "Authorization": "Bearer " + token,
                },
                sendTimeout: 50000,
                receiveTimeout: 50000,
              ));
      if (response.statusCode == 200) {
        currentUser = UserModel(
            id: response.data['id'],
            login: response.data['login'],
            image: response.data['image'] != ''
                ? 'http://10.0.2.2:80' + response.data['image']
                : null);
        //isSignIn = true;
        //return response.data;
        return currentUser;
      }
    } on DioError catch (e) {
      //isSignIn = false;
    }
    //});
  }

  @action
  Future<void> signOut() async {
    final Dio _dio = Dio();
    String token = await _storage.read(
            key: 'token',
            iOptions: _getIOSOptions(),
            aOptions: _getAndroidOptions()) ??
        '';
    try {
      final response = await _dio.get(
          'http://10.0.2.2:80/cabinet/default/sign-out',
          options: Options(headers: {"Authorization": "Bearer " + token}));
      //isSignIn = true;
      _storage.delete(
          key: 'token',
          iOptions: _getIOSOptions(),
          aOptions: _getAndroidOptions());
      return response.data;
    } on DioError catch (e) {
      //isSignIn = false;
      print(e);
    }
  }

//
// @action
// Future<User?> currentUser() async {
//   return _auth.currentUser;
// }
//
// @action
// String getUserId() {
//   return _auth.currentUser!.uid;
// }
//
// @action
// String? getEmail() {
//   return getUser()
// }
//
// @action
// String? getAvatar() {
//   return _auth.currentUser!.photoURL;
// }
}
