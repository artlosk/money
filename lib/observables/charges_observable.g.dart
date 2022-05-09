// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'charges_observable.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ChargesState on ChargesStateBase, Store {
  late final _$categoriesAtom =
      Atom(name: 'ChargesStateBase.categories', context: context);

  @override
  ObservableList<HybridModel> get categories {
    _$categoriesAtom.reportRead();
    return super.categories;
  }

  @override
  set categories(ObservableList<HybridModel> value) {
    _$categoriesAtom.reportWrite(value, super.categories, () {
      super.categories = value;
    });
  }

  late final _$chargesAtom =
      Atom(name: 'ChargesStateBase.charges', context: context);

  @override
  ObservableList<ChargeModel> get charges {
    _$chargesAtom.reportRead();
    return super.charges;
  }

  @override
  set charges(ObservableList<ChargeModel> value) {
    _$chargesAtom.reportWrite(value, super.charges, () {
      super.charges = value;
    });
  }

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

  late final _$getCategoriesAsyncAction =
      AsyncAction('ChargesStateBase.getCategories', context: context);

  @override
  Future<dynamic> getCategories() {
    return _$getCategoriesAsyncAction.run(() => super.getCategories());
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
  Future<dynamic> deleteCategory({required int? categoryId}) {
    return _$deleteCategoryAsyncAction
        .run(() => super.deleteCategory(categoryId: categoryId));
  }

  late final _$updateChargeAsyncAction =
      AsyncAction('ChargesStateBase.updateCharge', context: context);

  @override
  Future<dynamic> updateCharge({required ChargeModel model}) {
    return _$updateChargeAsyncAction
        .run(() => super.updateCharge(model: model));
  }

  late final _$deleteChargeAsyncAction =
      AsyncAction('ChargesStateBase.deleteCharge', context: context);

  @override
  Future<dynamic> deleteCharge({required ChargeModel? chargeModel}) {
    return _$deleteChargeAsyncAction
        .run(() => super.deleteCharge(chargeModel: chargeModel));
  }

  @override
  String toString() {
    return '''
categories: ${categories},
charges: ${charges},
currentDate: ${currentDate}
    ''';
  }
}
