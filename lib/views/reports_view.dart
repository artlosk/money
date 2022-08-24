import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

import '../components/bottom_bar.dart';
import '../observables/bill_observable.dart';
import '../observables/tab_observable.dart';

class ReportsView extends StatelessWidget {
  const ReportsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TabState stateTab = Provider.of<TabState>(context);
    final BillState stateBill = Provider.of<BillState>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Отчеты'),
      ),
      body: Container(),
      drawer: Drawer(
          // child: ListView(children: [
          //   ListTile(title: Text('Пополнения'), onTap: () {
          //
          //     final DateTime datetimeFrom =
          //     DateTime(DateTime.now().year, DateTime.now().month, 01, 00, 00, 00);
          //     final DateTime datetimeTo = DateTime(
          //         DateTime.now().year,
          //         DateTime.now().month,
          //         DateUtils.getDaysInMonth(DateTime.now().year, DateTime.now().month),
          //         23,
          //         59,
          //         59);
          //     showDateRangePicker(
          //         context: context, firstDate: datetimeFrom, lastDate: datetimeTo);
          //   }),
          //   ListTile(title: Text('Переводы'),),
          //   ListTile(title: Text('Расходы'))
          // ],),
          child: ListView.custom(
        childrenDelegate:
            SliverChildBuilderDelegate((BuildContext context, int index) {
          return Column(
            children: [
              Column(
                children: [
                  Container(
                    height: 50.0,
                    color: const Color(0xFF9053EB),
                    child: const Center(
                      child: Text('Статистика',
                          style: TextStyle(color: Colors.white, fontSize: 16)),
                    ),
                  ),
                  ListTile(
                    leading: Icon(Icons.compare_arrows),
                    title: const Text('По пополнению'),
                    onTap: () {
                      // showTransferDialog(
                      //     context: context, stateBill: stateBill)
                      //     .then((value) => Navigator.of(context).pop());
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.compare_arrows),
                    title: const Text('По расходам'),
                    onTap: () {
                      // showTransferDialog(
                      //     context: context, stateBill: stateBill)
                      //     .then((value) => Navigator.of(context).pop());
                    },
                  ),
                ],
              ),
              Column(
                children: [
                  Container(
                    height: 50.0,
                    color: const Color(0xFF9053EB),
                    child: const Center(
                      child: Text('Диаграммы',
                          style: TextStyle(color: Colors.white, fontSize: 16)),
                    ),
                  ),
                  ListTile(
                    leading: Icon(Icons.compare_arrows),
                    title: const Text('По пополнению'),
                    onTap: () {
                      // showTransferDialog(
                      //     context: context, stateBill: stateBill)
                      //     .then((value) => Navigator.of(context).pop());
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.compare_arrows),
                    title: const Text('По расходам'),
                    onTap: () {
                      // showTransferDialog(
                      //     context: context, stateBill: stateBill)
                      //     .then((value) => Navigator.of(context).pop());
                    },
                  ),
                ],
              ),
            ],
          );
        }, childCount: 1),
      )),
      bottomNavigationBar: Observer(
        builder: (context) => BottomBar(
            activeTabIndex: stateTab.activeTabIndex,
            onClicked: (index) {
              if (stateBill.bills.isNotEmpty) {
                stateTab.updateTab(index);
              }
            }),
      ),
    );
  }
}
