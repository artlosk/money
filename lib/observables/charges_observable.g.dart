// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'charges_observable.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ChargesState on ChargesStateBase, Store {
  final _$currentDateAtom = Atom(name: 'ChargesStateBase.currentDate');

  @override
  DateTime get currentDate {
    _$currentDateAtom.reportRead();
    return super.currentDate;
  }

  @override
  set currentDate(DateTime value) {
    _$currentDateAtom.reportWrite(value, super.currentDate, () {
      super.currentDate = value;
    });
  }

  final _$checkExistCategoryAsyncAction =
      AsyncAction('ChargesStateBase.checkExistCategory');

  @override
  Future<dynamic> checkExistCategory({required String title}) {
    return _$checkExistCategoryAsyncAction
        .run(() => super.checkExistCategory(title: title));
  }

  final _$createCategoryAsyncAction =
      AsyncAction('ChargesStateBase.createCategory');

  @override
  Future<dynamic> createCategory({required CategoryModel model}) {
    return _$createCategoryAsyncAction
        .run(() => super.createCategory(model: model));
  }

  final _$updateCategoryAsyncAction =
      AsyncAction('ChargesStateBase.updateCategory');

  @override
  Future<dynamic> updateCategory({required CategoryModel model}) {
    return _$updateCategoryAsyncAction
        .run(() => super.updateCategory(model: model));
  }

  final _$deleteCategoryAsyncAction =
      AsyncAction('ChargesStateBase.deleteCategory');

  @override
  Future<dynamic> deleteCategory({required String? categoryUid}) {
    return _$deleteCategoryAsyncAction
        .run(() => super.deleteCategory(categoryUid: categoryUid));
  }

  final _$createChargeAsyncAction =
      AsyncAction('ChargesStateBase.createCharge');

  @override
  Future<dynamic> createCharge({required ChargeModel model}) {
    return _$createChargeAsyncAction
        .run(() => super.createCharge(model: model));
  }

  final _$updateChargeAsyncAction =
      AsyncAction('ChargesStateBase.updateCharge');

  @override
  Future<dynamic> updateCharge(
      {required String? chargeDocId, required ChargeModel model}) {
    return _$updateChargeAsyncAction
        .run(() => super.updateCharge(chargeDocId: chargeDocId, model: model));
  }

  final _$deleteChargeAsyncAction =
      AsyncAction('ChargesStateBase.deleteCharge');

  @override
  Future<dynamic> deleteCharge({required String? chargeDocId}) {
    return _$deleteChargeAsyncAction
        .run(() => super.deleteCharge(chargeDocId: chargeDocId));
  }

  final _$deleteAllDataAsyncAction =
      AsyncAction('ChargesStateBase.deleteAllData');

  @override
  Future<dynamic> deleteAllData() {
    return _$deleteAllDataAsyncAction.run(() => super.deleteAllData());
  }

  final _$selectDateAsyncAction = AsyncAction('ChargesStateBase.selectDate');

  @override
  Future<DateTime> selectDate(BuildContext context) {
    return _$selectDateAsyncAction.run(() => super.selectDate(context));
  }

  final _$ChargesStateBaseActionController =
      ActionController(name: 'ChargesStateBase');

  @override
  Stream<List<HybridModel>> getCatWithTotal({required DateTime currentDate}) {
    final _$actionInfo = _$ChargesStateBaseActionController.startAction(
        name: 'ChargesStateBase.getCatWithTotal');
    try {
      return super.getCatWithTotal(currentDate: currentDate);
    } finally {
      _$ChargesStateBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  Stream<List<QueryDocumentSnapshot<ChargeModel>>> listChargeByCategory(
      {required String categoryUid, required DateTime currentDate}) {
    final _$actionInfo = _$ChargesStateBaseActionController.startAction(
        name: 'ChargesStateBase.listChargeByCategory');
    try {
      return super.listChargeByCategory(
          categoryUid: categoryUid, currentDate: currentDate);
    } finally {
      _$ChargesStateBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
currentDate: ${currentDate}
    ''';
  }
}
