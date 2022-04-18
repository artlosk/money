// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'storage_observable.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$StorageState on StorageStateBase, Store {
  final _$imageAtom = Atom(name: 'StorageStateBase.image');

  @override
  XFile? get image {
    _$imageAtom.reportRead();
    return super.image;
  }

  @override
  set image(XFile? value) {
    _$imageAtom.reportWrite(value, super.image, () {
      super.image = value;
    });
  }

  final _$isPickedAtom = Atom(name: 'StorageStateBase.isPicked');

  @override
  bool get isPicked {
    _$isPickedAtom.reportRead();
    return super.isPicked;
  }

  @override
  set isPicked(bool value) {
    _$isPickedAtom.reportWrite(value, super.isPicked, () {
      super.isPicked = value;
    });
  }

  final _$isLoadingAtom = Atom(name: 'StorageStateBase.isLoading');

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

  final _$uploadImageAsyncAction = AsyncAction('StorageStateBase.uploadImage');

  @override
  Future<String> uploadImage() {
    return _$uploadImageAsyncAction.run(() => super.uploadImage());
  }

  @override
  String toString() {
    return '''
image: ${image},
isPicked: ${isPicked},
isLoading: ${isLoading}
    ''';
  }
}
