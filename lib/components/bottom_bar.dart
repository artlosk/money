import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';

import 'enums.dart';

class BottomBar extends StatelessWidget {
  const BottomBar({Key? key, required this.activeTabIndex, required this.onClicked}) : super(key: key);

  final int activeTabIndex;
  final ValueChanged<int> onClicked;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: activeTabIndex,
      onTap: onClicked,
      items: TabButton.values.map((tab) {
        return BottomNavigationBarItem(
            icon: Icon(
              tab == TabButton.charges
                  ? Icons.credit_card
                  : Icons.account_circle,
            ),
            label: tab == TabButton.charges ? FlutterI18n.translate(context, 'bottombar.TEXT_CHARGES') : FlutterI18n.translate(context, 'bottombar.TEXT_PROFILE'));
      }).toList(),
    );
  }
}
