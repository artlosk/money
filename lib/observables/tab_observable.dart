
import 'package:mobx/mobx.dart';
import 'package:money_tracker/components/enums.dart';

part 'tab_observable.g.dart';

class TabState = TabStateBase with _$TabState;

abstract class TabStateBase with Store {

  TabStateBase();

  @observable
  int activeTabIndex = TabButton.bill.index;

  @action
  void updateTab(int index) {
    activeTabIndex = index;
  }
}