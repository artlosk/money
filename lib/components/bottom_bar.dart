import 'package:flutter/material.dart';

import 'enums.dart';

class BottomBar extends StatelessWidget {
  const BottomBar({Key? key, required this.activeTabIndex, required this.onClicked}) : super(key: key);

  final int activeTabIndex;
  final ValueChanged<int> onClicked;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: activeTabIndex, //stateTab.activeTabIndex,
      onTap: onClicked, //stateTab.updateTab,
      items: TabButton.values.map((tab) {
        return BottomNavigationBarItem(
            icon: Icon(
              tab == TabButton.charges
                  ? Icons.credit_card
                  : Icons.account_circle,
            ),
            label: tab == TabButton.charges ? 'Расходы' : 'Профиль');
      }).toList(),
    );
  }
}
