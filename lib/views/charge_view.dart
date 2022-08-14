import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:money_tracker/components/dialogs/confirm_delete_dialog.dart';
import 'package:money_tracker/components/enums.dart';
import 'package:money_tracker/components/extensions/hex_color_extension.dart';
import 'package:money_tracker/models/category_model.dart';
import 'package:money_tracker/models/charge_model.dart';
import 'package:money_tracker/views/loading_view.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import '../components/dialogs/charge_dialog.dart';
import '../observables/bill_observable.dart';
import '../observables/charges_observable.dart';

class ChargeView extends StatelessWidget {
  const ChargeView({Key? key, required this.category}) : super(key: key);

  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    final ChargesState stateCharges = Provider.of<ChargesState>(context);
    final BillState stateBill = Provider.of<BillState>(context);
    stateBill.getListBill();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: HexColor.fromHex(category.color),
        title: Text(category.title),
      ),
      body: StreamBuilder<List<QueryDocumentSnapshot<ChargeModel>>>(
        stream: stateCharges.listChargeByCategory(
            categoryUid: category.uid, currentDate: stateCharges.currentDate),
        builder: (context, snapshot) {
          // stateBill.listBillFuture();
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingView();
          }

          if (snapshot.connectionState == ConnectionState.active) {
            final List<QueryDocumentSnapshot<ChargeModel>>? charges =
                snapshot.data;

            if (charges == null || charges.isEmpty) {
              return const Center(
                child: Padding(
                  padding: EdgeInsets.all(60),
                  child: Text(
                    'В текущем месяце в данной категории еще не было расходов...',
                    style: TextStyle(fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                ),
              );
            }

            return ListView.builder(
              itemCount: charges.length,
              itemBuilder: (BuildContext context, int index) {
                final charge = charges[index].data();
                final chargeDocId = charges[index].id;
                return Container(
                  margin: const EdgeInsets.all(20.0),
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
                            stateCharges.currentDate = charge.createdAt;
                            showChargeDialog(
                              context: context,
                              categoryUid: category.uid,
                              stateCharges: stateCharges,
                              stateBill: stateBill,
                              action: ActionsDialog.update,
                              oldCharge: charge,
                              chargeDocId: chargeDocId,
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
                              stateCharges: stateCharges,
                              chargeUid: chargeDocId,
                              chargeBillUid: charge.billUid,
                              chargeCost: charge.cost,
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
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            charge.cost.toString(),
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Visibility(
                            child: Text(
                              'Назначение платежа: ${charge.description}',
                              style: const TextStyle(
                                fontSize: 14,
                                color: Color(0xFFABABAB),
                              ),
                            ),
                            visible: charge.description.isNotEmpty,
                          ),
                          Text(
                            'Счет: ${charge.billTitle ?? "Неизвестный"}',
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
                                  .format(charge.createdAt)
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

          return const Center(
            child: Padding(
              padding: EdgeInsets.all(60),
              child: Text(
                'Ошибка получения данных',
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
            ),
          );
        },
      ),
    );
  }
}
