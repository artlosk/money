import 'package:flutter/material.dart';

import 'enums.dart';

class BottomBar extends StatelessWidget {
  const BottomBar({Key? key, required this.activeTabIndex, required this.onClicked}) : super(key: key);

  final int activeTabIndex;
  final ValueChanged<int> onClicked;

  _getTab(TabButton index) {
    switch (index) {
      case TabButton.bill:
        return 'Счета';
      case TabButton.charges:
        return 'Расходы';
      // case TabButton.reports:
      //   return 'Отчеты';
      case TabButton.profile:
        return 'Профиль';
    }
  }

  @override
  Widget build(BuildContext context) {
    _getTab(TabButton.charges);
    return BottomNavigationBar(
      currentIndex: activeTabIndex, //stateTab.activeTabIndex,
      onTap: onClicked, //stateTab.updateTab,
      type: BottomNavigationBarType.fixed,
      items: TabButton.values.map((tab) {
        switch(tab) {
          case TabButton.bill:
            return BottomNavigationBarItem(
              icon: const Icon(Icons.attach_money),
              label: _getTab(tab),
            );
          case TabButton.charges:
            return BottomNavigationBarItem(
                icon: const Icon(Icons.credit_card),
                label: _getTab(tab),
            );
          // case TabButton.reports:
          // case TabButton.reports:
          //   return BottomNavigationBarItem(
          //     icon: const Icon(Icons.file_copy),
          //     label: _getTab(tab),
          //   );
          case TabButton.profile:
            return BottomNavigationBarItem(
                icon: const Icon(Icons.account_circle),
                label: _getTab(tab),
            );
        }
      }).toList(),
    );
  }
}
