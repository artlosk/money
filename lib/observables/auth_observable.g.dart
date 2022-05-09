// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_observable.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$AuthState on _AuthState, Store {
  late final _$isSignInAtom =
      Atom(name: '_AuthState.isSignIn', context: context);

  @override
  bool get isSignIn {
    _$isSignInAtom.reportRead();
    return super.isSignIn;
  }

  @override
  set isSignIn(bool value) {
    _$isSignInAtom.reportWrite(value, super.isSignIn, () {
      super.isSignIn = value;
    });
  }

  late final _$isLoadingAtom =
      Atom(name: '_AuthState.isLoading', context: context);

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  late final _$errorAuthAtom =
      Atom(name: '_AuthState.errorAuth', context: context);

  @override
  String get errorAuth {
    _$errorAuthAtom.reportRead();
    return super.errorAuth;
  }

  @override
  set errorAuth(String value) {
    _$errorAuthAtom.reportWrite(value, super.errorAuth, () {
      super.errorAuth = value;
    });
  }

  late final _$currentUserAtom =
      Atom(name: '_AuthState.currentUser', context: context);

  @override
  UserModel? get currentUser {
    _$currentUserAtom.reportRead();
    return super.currentUser;
  }

  @override
  set currentUser(UserModel? value) {
    _$currentUserAtom.reportWrite(value, super.currentUser, () {
      super.currentUser = value;
    });
  }

  late final _$signUpWithEmailAndPasswordAsyncAction =
      AsyncAction('_AuthState.signUpWithEmailAndPassword', context: context);

  @override
  Future<dynamic> signUpWithEmailAndPassword(
      {required String email, required String password}) {
    return _$signUpWithEmailAndPasswordAsyncAction.run(() =>
        super.signUpWithEmailAndPassword(email: email, password: password));
  }

  late final _$signInWithEmailAndPasswordAsyncAction =
      AsyncAction('_AuthState.signInWithEmailAndPassword', context: context);

  @override
  Future<dynamic> signInWithEmailAndPassword(
      {required String email, required String password}) {
    return _$signInWithEmailAndPasswordAsyncAction.run(() =>
        super.signInWithEmailAndPassword(email: email, password: password));
  }

  late final _$getUserAsyncAction =
      AsyncAction('_AuthState.getUser', context: context);

  @override
  Future<UserModel?> getUser() {
    return _$getUserAsyncAction.run(() => super.getUser());
  }

  late final _$signOutAsyncAction =
      AsyncAction('_AuthState.signOut', context: context);

  @override
  Future<void> signOut() {
    return _$signOutAsyncAction.run(() => super.signOut());
  }

  @override
  String toString() {
    return '''
isSignIn: ${isSignIn},
isLoading: ${isLoading},
errorAuth: ${errorAuth},
currentUser: ${currentUser}
    ''';
  }
}
