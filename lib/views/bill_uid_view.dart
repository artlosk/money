import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:money_tracker/components/dialogs/bill_dialog.dart';
import 'package:money_tracker/components/dialogs/refill_dialog.dart';
import 'package:provider/provider.dart';

import '../components/dialogs/confirm_delete_dialog.dart';
import '../components/enums.dart';
import '../models/bill_model.dart';
import '../observables/bill_observable.dart';
import 'loading_view.dart';

class BillUidView extends StatelessWidget {
  const BillUidView({Key? key, required this.bill}) : super(key: key);

  final BillModel bill;

  @override
  Widget build(BuildContext context) {
    final BillState stateBill = Provider.of<BillState>(context);
    stateBill.getListBill();
    stateBill.listRefillByUid(currentDate: stateBill.currentDate, bill: bill);
    return Observer(
      builder: (context) {
        stateBill.getTotalSumByBill(billUid: bill.uid);
        stateBill.getTotalSumMonthByBill(billUid: bill.uid);
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.of(context).pop(true);
                }),
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
              IconButton(
                onPressed: () => showRefillDialog(
                    context: context,
                    stateBill: stateBill,
                    action: ActionsDialog.create,
                    bill: bill),
                icon: const Icon(Icons.arrow_circle_up),
              ),
            ],
          ),
          body: stateBill.refillLoaded == false ? LoadingView() : SingleChildScrollView(
            child: Column(
              children: [
                Container(
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
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Observer(builder: (_) {
                      return Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                                'В выбранном месяце: ${stateBill.totalSumInMonth}',
                                style: TextStyle(fontSize: 18),
                                textAlign: TextAlign.right),
                            Text(
                                'За все время: ${stateBill.totalSum}',
                                style: TextStyle(fontSize: 18),
                                textAlign: TextAlign.right),
                            const Divider(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ElevatedButton(
                                  onPressed: () => showRefillDialog(
                                      context: context,
                                      stateBill: stateBill,
                                      action: ActionsDialog.create,
                                      bill: bill),
                                  style: ButtonStyle(
                                    minimumSize:
                                        MaterialStateProperty.all<Size>(
                                            const Size(150, 35)),
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Theme.of(context).accentColor),
                                  ),
                                  child: const Text('Пополнить'),
                                ),
                                ElevatedButton(
                                  onPressed: () => showBillDialog(
                                    context: context,
                                    stateBill: stateBill,
                                    action: ActionsDialog.update,
                                    bill: bill,
                                  ),
                                  style: ButtonStyle(
                                    minimumSize:
                                        MaterialStateProperty.all<Size>(
                                            const Size(150, 35)),
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            const Color(0xFF9053EB)),
                                  ),
                                  child: const Text('Редактировать'),
                                ),
                              ],
                            ),
                          ]);
                    }),
                  ),
                ),
                Observer(
                  builder: (_) {
                    var refills = stateBill.refills;
                    if (refills.isEmpty) {
                      return const Center(
                        child: Padding(
                          padding: EdgeInsets.all(60),
                          child: Text(
                            'В текущем месяце в данном счете еще не было пополнений...',
                            style: TextStyle(fontSize: 16),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      );
                    }

                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      itemCount: refills.length,
                      itemBuilder: (BuildContext context, int index) {
                        final refill = refills[index];
                        final refillId = refills[index].id;
                        return Container(
                          margin: const EdgeInsets.all(10.0),
                          // width: double.infinity,
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
                                      bill: bill,
                                    );
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
                                      billModel: bill,
                                    );
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
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
