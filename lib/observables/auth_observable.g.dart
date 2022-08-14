// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_observable.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

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

  late final _$setImageUrlAsyncAction =
      AsyncAction('_AuthState.setImageUrl', context: context);

  @override
  Future<dynamic> setImageUrl({required String url}) {
    return _$setImageUrlAsyncAction.run(() => super.setImageUrl(url: url));
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

  late final _$signOutAsyncAction =
      AsyncAction('_AuthState.signOut', context: context);

  @override
  Future<bool> signOut() {
    return _$signOutAsyncAction.run(() => super.signOut());
  }

  late final _$currentUserAsyncAction =
      AsyncAction('_AuthState.currentUser', context: context);

  @override
  Future<User?> currentUser() {
    return _$currentUserAsyncAction.run(() => super.currentUser());
  }

  late final _$_AuthStateActionController =
      ActionController(name: '_AuthState', context: context);

  @override
  String getUserId() {
    final _$actionInfo =
        _$_AuthStateActionController.startAction(name: '_AuthState.getUserId');
    try {
      return super.getUserId();
    } finally {
      _$_AuthStateActionController.endAction(_$actionInfo);
    }
  }

  @override
  String? getEmail() {
    final _$actionInfo =
        _$_AuthStateActionController.startAction(name: '_AuthState.getEmail');
    try {
      return super.getEmail();
    } finally {
      _$_AuthStateActionController.endAction(_$actionInfo);
    }
  }

  @override
  String? getAvatar() {
    final _$actionInfo =
        _$_AuthStateActionController.startAction(name: '_AuthState.getAvatar');
    try {
      return super.getAvatar();
    } finally {
      _$_AuthStateActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isSignIn: ${isSignIn},
isLoading: ${isLoading},
errorAuth: ${errorAuth}
    ''';
  }
}
