// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bill_observable.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$BillState on BillStateBase, Store {
  late final _$currentDateAtom =
      Atom(name: 'BillStateBase.currentDate', context: context);

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

  late final _$billsAtom = Atom(name: 'BillStateBase.bills', context: context);

  @override
  ObservableList<BillModel> get bills {
    _$billsAtom.reportRead();
    return super.bills;
  }

  @override
  set bills(ObservableList<BillModel> value) {
    _$billsAtom.reportWrite(value, super.bills, () {
      super.bills = value;
    });
  }

  late final _$billLoadedAtom =
      Atom(name: 'BillStateBase.billLoaded', context: context);

  @override
  bool get billLoaded {
    _$billLoadedAtom.reportRead();
    return super.billLoaded;
  }

  @override
  set billLoaded(bool value) {
    _$billLoadedAtom.reportWrite(value, super.billLoaded, () {
      super.billLoaded = value;
    });
  }

  late final _$refillsAtom =
      Atom(name: 'BillStateBase.refills', context: context);

  @override
  ObservableList<RefillModel> get refills {
    _$refillsAtom.reportRead();
    return super.refills;
  }

  @override
  set refills(ObservableList<RefillModel> value) {
    _$refillsAtom.reportWrite(value, super.refills, () {
      super.refills = value;
    });
  }

  late final _$refillLoadedAtom =
      Atom(name: 'BillStateBase.refillLoaded', context: context);

  @override
  bool get refillLoaded {
    _$refillLoadedAtom.reportRead();
    return super.refillLoaded;
  }

  @override
  set refillLoaded(bool value) {
    _$refillLoadedAtom.reportWrite(value, super.refillLoaded, () {
      super.refillLoaded = value;
    });
  }

  late final _$transfersAtom =
      Atom(name: 'BillStateBase.transfers', context: context);

  @override
  ObservableList<BillTransferModel> get transfers {
    _$transfersAtom.reportRead();
    return super.transfers;
  }

  @override
  set transfers(ObservableList<BillTransferModel> value) {
    _$transfersAtom.reportWrite(value, super.transfers, () {
      super.transfers = value;
    });
  }

  late final _$transferLoadedAtom =
      Atom(name: 'BillStateBase.transferLoaded', context: context);

  @override
  bool get transferLoaded {
    _$transferLoadedAtom.reportRead();
    return super.transferLoaded;
  }

  @override
  set transferLoaded(bool value) {
    _$transferLoadedAtom.reportWrite(value, super.transferLoaded, () {
      super.transferLoaded = value;
    });
  }

  late final _$totalSumAtom =
      Atom(name: 'BillStateBase.totalSum', context: context);

  @override
  double get totalSum {
    _$totalSumAtom.reportRead();
    return super.totalSum;
  }

  @override
  set totalSum(double value) {
    _$totalSumAtom.reportWrite(value, super.totalSum, () {
      super.totalSum = value;
    });
  }

  late final _$totalSumInMonthAtom =
      Atom(name: 'BillStateBase.totalSumInMonth', context: context);

  @override
  double get totalSumInMonth {
    _$totalSumInMonthAtom.reportRead();
    return super.totalSumInMonth;
  }

  @override
  set totalSumInMonth(double value) {
    _$totalSumInMonthAtom.reportWrite(value, super.totalSumInMonth, () {
      super.totalSumInMonth = value;
    });
  }

  late final _$checkExistBillAsyncAction =
      AsyncAction('BillStateBase.checkExistBill', context: context);

  @override
  Future<dynamic> checkExistBill({required String title}) {
    return _$checkExistBillAsyncAction
        .run(() => super.checkExistBill(title: title));
  }

  late final _$createBillAsyncAction =
      AsyncAction('BillStateBase.createBill', context: context);

  @override
  Future<dynamic> createBill({required BillModel model}) {
    return _$createBillAsyncAction.run(() => super.createBill(model: model));
  }

  late final _$updateBillAsyncAction =
      AsyncAction('BillStateBase.updateBill', context: context);

  @override
  Future<dynamic> updateBill({required BillModel model}) {
    return _$updateBillAsyncAction.run(() => super.updateBill(model: model));
  }

  late final _$getListBillAsyncAction =
      AsyncAction('BillStateBase.getListBill', context: context);

  @override
  Future<dynamic> getListBill() {
    return _$getListBillAsyncAction.run(() => super.getListBill());
  }

  late final _$listAllRefillAsyncAction =
      AsyncAction('BillStateBase.listAllRefill', context: context);

  @override
  Future<dynamic> listAllRefill({required DateTime currentDate}) {
    return _$listAllRefillAsyncAction
        .run(() => super.listAllRefill(currentDate: currentDate));
  }

  late final _$listRefillByUidAsyncAction =
      AsyncAction('BillStateBase.listRefillByUid', context: context);

  @override
  Future<dynamic> listRefillByUid(
      {required DateTime currentDate, required BillModel bill}) {
    return _$listRefillByUidAsyncAction
        .run(() => super.listRefillByUid(currentDate: currentDate, bill: bill));
  }

  late final _$selectDateAsyncAction =
      AsyncAction('BillStateBase.selectDate', context: context);

  @override
  Future<DateTime> selectDate(BuildContext context) {
    return _$selectDateAsyncAction.run(() => super.selectDate(context));
  }

  late final _$refillAmountCreateAsyncAction =
      AsyncAction('BillStateBase.refillAmountCreate', context: context);

  @override
  Future<dynamic> refillAmountCreate(
      {required RefillModel refillModel, required BillModel? bill}) {
    return _$refillAmountCreateAsyncAction.run(
        () => super.refillAmountCreate(refillModel: refillModel, bill: bill));
  }

  late final _$refillAmountUpdateAsyncAction =
      AsyncAction('BillStateBase.refillAmountUpdate', context: context);

  @override
  Future<dynamic> refillAmountUpdate(
      {required RefillModel refillModel,
      required double oldCost,
      required BillModel? bill}) {
    return _$refillAmountUpdateAsyncAction.run(() => super.refillAmountUpdate(
        refillModel: refillModel, oldCost: oldCost, bill: bill));
  }

  late final _$refillAmountDeleteAsyncAction =
      AsyncAction('BillStateBase.refillAmountDelete', context: context);

  @override
  Future<dynamic> refillAmountDelete(
      {required RefillModel? refillModel,
      required String? refillDocId,
      BillModel? bill}) {
    return _$refillAmountDeleteAsyncAction.run(() => super.refillAmountDelete(
        refillModel: refillModel, refillDocId: refillDocId, bill: bill));
  }

  @override
  String toString() {
    return '''
currentDate: ${currentDate},
bills: ${bills},
billLoaded: ${billLoaded},
refills: ${refills},
refillLoaded: ${refillLoaded},
transfers: ${transfers},
transferLoaded: ${transferLoaded},
totalSum: ${totalSum},
totalSumInMonth: ${totalSumInMonth}
    ''';
  }
}
