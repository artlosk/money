// import 'dart:async';
//
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:mobx/mobx.dart';
//
// part 'auth_observable.g.dart';
//
// final FirebaseAuth _auth = FirebaseAuth.instance;
//
// class AuthState = _AuthState with _$AuthState;
//
// abstract class _AuthState with Store {
//   _AuthState();
//
//   @observable
//   bool isSignIn = _auth.currentUser?.uid != null ? true : false;
//
//   @observable
//   bool isLoading = false;
//
//   @observable
//   String errorAuth = '';
//
//   @action
//   Future setImageUrl({required String url}) async {
//     await _auth.currentUser?.updatePhotoURL(url);
//   }
//
//   @action
//   Future signUpWithEmailAndPassword(
//       {required String email, required String password}) async {
//     errorAuth = '';
//     isLoading = true;
//     try {
//       await _auth.createUserWithEmailAndPassword(
//         email: email,
//         password: password,
//       );
//       isSignIn = true;
//       isLoading = false;
//       return null;
//     } on FirebaseAuthException catch (e) {
//       isLoading = false;
//       if (e.code == 'email-already-in-use') {
//         errorAuth = 'login.ERROR_EMAIL_DUPLICATE';//'Данный Email существует, попробуйте другой';
//       } else {
//         errorAuth = 'login.ERROR_SING_IN_ERROR';
//       }
//       return e.message;
//     }
//   }
//
//   @action
//   Future signInWithEmailAndPassword(
//       {required String email, required String password}) async {
//     errorAuth = '';
//     isLoading = true;
//     try {
//       await _auth.signInWithEmailAndPassword(email: email, password: password);
//       isLoading = false;
//       isSignIn = true;
//       return null;
//     } on FirebaseAuthException catch (e) {
//       print(e.code);
//       isLoading = false;
//       errorAuth = 'login.ERROR_SIGN_IN_ERROR';
//       return e.message;
//     }
//   }
//
//   @action
//   Future restPassword(email) async {
//     FirebaseAuth.instance.sendPasswordResetEmail(email: email).then((_) {
//       print('success');
//     }).catchError((error) {
//       print('error');
//     });
//   }
//
//   @action
//   Future<bool> signOut() async {
//     _auth.signOut();
//     isSignIn = false;
//     return await Future.value(true);
//   }
//
//   Stream<User?> get onAuthStateChanged {
//     if (_auth.currentUser?.uid != null ) {
//       isSignIn = true;
//     } else {
//       isSignIn = false;
//     }
//     return _auth.authStateChanges();
//   }
//
//   @action
//   Future<User?> currentUser() async {
//     return _auth.currentUser;
//   }
//
//   @action
//   String getUserId() {
//     return _auth.currentUser!.uid;
//   }
//
//   @action
//   String? getEmail() {
//     return _auth.currentUser!.email;
//   }
//
//   @action
//   String? getAvatar() {
//     return _auth.currentUser!.photoURL;
//   }
// }
