import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:money_tracker/components/dialogs/bill_dialog.dart';
import 'package:money_tracker/components/dialogs/refill_dialog.dart';
import 'package:money_tracker/components/dialogs/transfer_dialog.dart';
import 'package:money_tracker/views/bill_transfer_view.dart';
import 'package:money_tracker/views/bill_uid_view.dart';
import 'package:provider/provider.dart';

import '../components/bottom_bar.dart';
import '../components/dialogs/confirm_delete_dialog.dart';
import '../components/enums.dart';
import '../models/bill_model.dart';
import '../observables/bill_observable.dart';
import '../observables/tab_observable.dart';
import 'loading_view.dart';

class BillView extends StatelessWidget {
  const BillView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TabState stateTab = Provider.of<TabState>(context);
    final BillState stateBill = Provider.of<BillState>(context);
    stateBill.getListBill();
    stateBill.listAllRefill(currentDate: stateBill.currentDate);
    return Scaffold(
      appBar: AppBar(
        title: TextButton(
          onPressed: () => stateBill.selectDate(context),
          child: Observer(
            builder: (context) => Center(
              child: Text(
                DateFormat('LLLL yyyy',
                        Localizations.localeOf(context).languageCode)
                    .format(stateBill.currentDate)
                    .toUpperCase(),
                style: const TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
          ),
        ),
        actions: [
          Observer(builder: (_) {
            return IconButton(
              onPressed: stateBill.bills.isEmpty
                  ? null
                  : () => showRefillDialog(
                      context: context,
                      stateBill: stateBill,
                      action: ActionsDialog.create,
              ).then((value) async { await stateBill.getListBill(); }),
              icon: const Icon(Icons.arrow_circle_up),
            );
          }),
          IconButton(
            onPressed: () {
              showBillDialog(
                context: context,
                stateBill: stateBill,
                action: ActionsDialog.create,
              );
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Observer(builder: (_) {
        if (stateBill.billLoaded == false || stateBill.refillLoaded == false) {
          return const LoadingView();
        }
        if (stateBill.bills.isEmpty) {
          return Center(
            child: Column(
              children: [
                const Padding(
                  padding:
                      EdgeInsets.only(left: 10, top: 50, right: 10, bottom: 10),
                  child: Text(
                    'Необходимо добавить хотя бы один счёт для далнейшего использования приложения',
                    style: TextStyle(fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                ),
                ElevatedButton(
                  onPressed: () => showBillDialog(
                    context: context,
                    stateBill: stateBill,
                    action: ActionsDialog.create,
                  ),
                  style: ButtonStyle(
                    minimumSize:
                        MaterialStateProperty.all<Size>(const Size(150, 35)),
                    backgroundColor: MaterialStateProperty.all<Color>(
                        Theme.of(context).accentColor),
                  ),
                  child: const Text('Создать счет'),
                ),
              ],
            ),
          );
        } else {
          var refills = stateBill.refills;
          return ListView.builder(
            itemCount: refills.length,
            itemBuilder: (BuildContext context, int index) {
              final refill = refills[index];
              final refillId = refills[index].id;
              return Container(
                margin: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(10.0),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Slidable(
                  key: const ValueKey(1),
                  endActionPane: ActionPane(
                    motion: const ScrollMotion(),
                    children: [
                      SlidableAction(
                        onPressed: (value) {
                          stateBill.currentDate = refill.createdAt;
                          showRefillDialog(
                              context: context,
                              stateBill: stateBill,
                              refill: refill,
                              action: ActionsDialog.update,
                              refillId: refillId,
                          ).then((value) async { await stateBill.getListBill(); });
                        },
                        backgroundColor: const Color(0xFF21B7CA),
                        foregroundColor: Colors.white,
                        icon: Icons.edit,
                        label: 'Редактировать',
                      ),
                      SlidableAction(
                        onPressed: (value) {
                          showConfirmDeleteDialog(
                            context: context,
                            stateBill: stateBill,
                            refillUid: refillId,
                            refillModel: refill,
                          ).then((value) async { await stateBill.getListBill(); });
                        },
                        backgroundColor: const Color(0xFFFE4A49),
                        foregroundColor: Colors.white,
                        icon: Icons.delete,
                        label: 'Удалить',
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          refill.cost.toString(),
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Text(
                          'Счет: ${refill.billTitle}',
                          style: const TextStyle(
                            fontSize: 14,
                            color: Color(0xFFABABAB),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 3.0),
                          child: Text(
                            DateFormat(
                                    'dd MMMM yyyy / hh:mm',
                                    Localizations.localeOf(context)
                                        .languageCode)
                                .format(refill.createdAt)
                                .toString(),
                            style: const TextStyle(
                              fontSize: 14,
                              color: Color(0xFFABABAB),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        }
      }),
      drawer: Drawer(
        child: Observer(
          builder: (_) {
            List<BillModel>? bills = stateBill.bills;
            return ListView.custom(
              childrenDelegate:
                  SliverChildBuilderDelegate((BuildContext context, int index) {
                return Column(
                  children: [
                    Container(
                      height: 50,
                      color: const Color(0xFF9053EB),
                      child: Center(
                        child: Text('Счета',
                            style:
                                TextStyle(color: Colors.white, fontSize: 16)),
                      ),
                    ),
                    ...bills.map((item) {
                      BillModel bill = item;
                      return ListTile(
                        leading: Icon(
                          bill.type == BillTypes.cash.name
                              ? Icons.attach_money
                              : Icons.credit_card,
                        ),
                        title: Text('${bill.title} (${bill.totalSum})'),
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (BuildContext context) {
                                return MultiProvider(
                                    providers: [
                                      Provider(
                                          create: (context) =>
                                              BillState(userId: bill.userUid)),
                                      Provider(create: (context) => TabState()),
                                    ],
                                    builder: (context, child) {
                                      final BillState state =
                                          Provider.of<BillState>(context);
                                      state.currentDate = stateBill.currentDate;
                                      return BillUidView(bill: bill);
                                    });
                              },
                            ),
                          ).then((value) {
                            stateBill.getListBill();
                            stateBill.listAllRefill(
                                currentDate: stateBill.currentDate);
                            Navigator.of(context).pop();
                          });
                        },
                      );
                    }).toList(),
                    Visibility(
                      visible: bills.length > 1,
                      child: Column(
                        children: [
                          Container(
                            height: 50.0,
                            color: const Color(0xFF9053EB),
                            child: const Center(
                              child: Text('Переводы',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16)),
                            ),
                          ),
                          ListTile(
                            leading: Icon(Icons.compare_arrows),
                            title: const Text('Перевод между счетами'),
                            onTap: () {
                              showTransferDialog(
                                      context: context, stateBill: stateBill)
                                  .then((value) => Navigator.of(context).pop());
                            },
                          ),
                          ListTile(
                            leading: Icon(Icons.history),
                            title: const Text('История переводов'),
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (BuildContext context) {
                                    return MultiProvider(
                                        providers: [
                                          Provider(create: (context) => BillState(userId: stateBill.userId)),
                                        ],
                                        builder: (context, child) {
                                          final BillState state = Provider.of<BillState>(context);
                                          state.currentDate = stateBill.currentDate;
                                          return const BillTransferView();
                                        },
                                    );
                                  },
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    )
                  ],
                );
              }, childCount: 1),
            );
          },
        ),
      ),
      bottomNavigationBar: Observer(
        builder: (context) => BottomBar(
            activeTabIndex: stateTab.activeTabIndex,
            onClicked: (index) {
              if (stateBill.bills.isNotEmpty) {
                stateTab.updateTab(index);
              }
            }),
      ),
      // onDrawerChanged: (isOpened) async { await stateBill.getListBill(); },
    );
  }
}
