// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tab_observable.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$TabState on TabStateBase, Store {
  late final _$activeTabIndexAtom =
      Atom(name: 'TabStateBase.activeTabIndex', context: context);

  @override
  int get activeTabIndex {
    _$activeTabIndexAtom.reportRead();
    return super.activeTabIndex;
  }

  @override
  set activeTabIndex(int value) {
    _$activeTabIndexAtom.reportWrite(value, super.activeTabIndex, () {
      super.activeTabIndex = value;
    });
  }

  late final _$TabStateBaseActionController =
      ActionController(name: 'TabStateBase', context: context);

  @override
  void updateTab(int index) {
    final _$actionInfo = _$TabStateBaseActionController.startAction(
        name: 'TabStateBase.updateTab');
    try {
      return super.updateTab(index);
    } finally {
      _$TabStateBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
activeTabIndex: ${activeTabIndex}
    ''';
  }
}
