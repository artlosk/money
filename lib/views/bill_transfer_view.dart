import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:intl/intl.dart';
import 'package:money_tracker/views/loading_view.dart';
import 'package:provider/provider.dart';

import '../models/bill_transfer_model.dart';
import '../observables/bill_observable.dart';

class BillTransferView extends StatelessWidget {
  const BillTransferView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final BillState stateBill = Provider.of<BillState>(context);
    stateBill.getListBill();
    stateBill.getTransferList(currentDate: stateBill.currentDate);
    return Scaffold(
        appBar: AppBar(
          title: TextButton(
            onPressed: () => stateBill.selectDate(context).then((value) => stateBill.getTransferList(currentDate: stateBill.currentDate)),
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
        ),
    body:
    Observer(builder: (_) {
        if (stateBill.transferLoaded == false) {
          return const LoadingView();
        } else {
          if (stateBill.transfers.isEmpty) {
            return const Center(
              child: Padding(
                padding: EdgeInsets.all(60),
                child: Text(
                  'В текущем месяце переводов не было...',
                  style: TextStyle(fontSize: 16),
                  textAlign: TextAlign.center,
                ),
              ),
            );
          } else {
            List<BillTransferModel> transferList = stateBill.transfers;
            return ListView.builder(
              itemCount: transferList.length,
              itemBuilder: (BuildContext context, int index) {
                final transfer = transferList[index];
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

                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          transfer.sum.toString(),
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Text(
                          '${stateBill.bills.where((element) => element.uid == transfer.billUidFrom).single.title} ⟶ ${stateBill.bills.where((element) => element.uid == transfer.billUidTo).single.title}',
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
                                .format(transfer.createdAt)
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
                );
              },
            );
          }
        }
      }
    ),
    );
  }
}
