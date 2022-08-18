// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'charges_observable.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ChargesState on ChargesStateBase, Store {
  late final _$currentDateAtom =
      Atom(name: 'ChargesStateBase.currentDate', context: context);

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

  late final _$totalSumDayAtom =
      Atom(name: 'ChargesStateBase.totalSumDay', context: context);

  @override
  double get totalSumDay {
    _$totalSumDayAtom.reportRead();
    return super.totalSumDay;
  }

  @override
  set totalSumDay(double value) {
    _$totalSumDayAtom.reportWrite(value, super.totalSumDay, () {
      super.totalSumDay = value;
    });
  }

  late final _$totalSumMonthAtom =
      Atom(name: 'ChargesStateBase.totalSumMonth', context: context);

  @override
  double get totalSumMonth {
    _$totalSumMonthAtom.reportRead();
    return super.totalSumMonth;
  }

  @override
  set totalSumMonth(double value) {
    _$totalSumMonthAtom.reportWrite(value, super.totalSumMonth, () {
      super.totalSumMonth = value;
    });
  }

  late final _$checkExistCategoryAsyncAction =
      AsyncAction('ChargesStateBase.checkExistCategory', context: context);

  @override
  Future<dynamic> checkExistCategory({required String title}) {
    return _$checkExistCategoryAsyncAction
        .run(() => super.checkExistCategory(title: title));
  }

  late final _$createCategoryAsyncAction =
      AsyncAction('ChargesStateBase.createCategory', context: context);

  @override
  Future<dynamic> createCategory({required CategoryModel model}) {
    return _$createCategoryAsyncAction
        .run(() => super.createCategory(model: model));
  }

  late final _$updateCategoryAsyncAction =
      AsyncAction('ChargesStateBase.updateCategory', context: context);

  @override
  Future<dynamic> updateCategory({required CategoryModel model}) {
    return _$updateCategoryAsyncAction
        .run(() => super.updateCategory(model: model));
  }

  late final _$deleteCategoryAsyncAction =
      AsyncAction('ChargesStateBase.deleteCategory', context: context);

  @override
  Future<dynamic> deleteCategory({required String? categoryUid}) {
    return _$deleteCategoryAsyncAction
        .run(() => super.deleteCategory(categoryUid: categoryUid));
  }

  late final _$createChargeAsyncAction =
      AsyncAction('ChargesStateBase.createCharge', context: context);

  @override
  Future<dynamic> createCharge({required ChargeModel model}) {
    return _$createChargeAsyncAction
        .run(() => super.createCharge(model: model));
  }

  late final _$updateChargeAsyncAction =
      AsyncAction('ChargesStateBase.updateCharge', context: context);

  @override
  Future<dynamic> updateCharge(
      {required String? chargeDocId,
      required ChargeModel model,
      required double oldCost,
      required String? oldBillUid}) {
    return _$updateChargeAsyncAction.run(() => super.updateCharge(
        chargeDocId: chargeDocId,
        model: model,
        oldCost: oldCost,
        oldBillUid: oldBillUid));
  }

  late final _$deleteChargeAsyncAction =
      AsyncAction('ChargesStateBase.deleteCharge', context: context);

  @override
  Future<dynamic> deleteCharge(
      {required String? chargeDocId,
      required double? chargeCost,
      required String? chargeBillUid}) {
    return _$deleteChargeAsyncAction.run(() => super.deleteCharge(
        chargeDocId: chargeDocId,
        chargeCost: chargeCost,
        chargeBillUid: chargeBillUid));
  }

  late final _$deleteAllDataAsyncAction =
      AsyncAction('ChargesStateBase.deleteAllData', context: context);

  @override
  Future<dynamic> deleteAllData() {
    return _$deleteAllDataAsyncAction.run(() => super.deleteAllData());
  }

  late final _$selectDateAsyncAction =
      AsyncAction('ChargesStateBase.selectDate', context: context);

  @override
  Future<DateTime> selectDate(BuildContext context) {
    return _$selectDateAsyncAction.run(() => super.selectDate(context));
  }

  late final _$ChargesStateBaseActionController =
      ActionController(name: 'ChargesStateBase', context: context);

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
currentDate: ${currentDate},
totalSumDay: ${totalSumDay},
totalSumMonth: ${totalSumMonth}
    ''';
  }
}
