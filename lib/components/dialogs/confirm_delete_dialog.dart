import 'package:flutter/material.dart';
import 'package:money_tracker/observables/bill_observable.dart';
import 'package:money_tracker/observables/charges_observable.dart';

import '../../models/refill_model.dart';

Future showConfirmDeleteDialog({
  required BuildContext context,
  ChargesState? stateCharges,
  BillState? stateBill,
  String? categoryUid,
  String? chargeUid,
  double? chargeCost,
  String? chargeBillUid,
  String? refillUid,
  RefillModel? refillModel,
}) async {
  return await showDialog(
    context: context,
    builder: (context) => _ConfirmDeleteDialog(
      stateCharges: stateCharges,
      stateBill: stateBill,
      categoryUid: categoryUid,
      chargeUid: chargeUid,
      chargeCost: chargeCost,
      chargeBillUid: chargeBillUid,
      refillUid: refillUid,
      refillModel: refillModel,
    ),
  );
}

class _ConfirmDeleteDialog extends StatefulWidget {
  const _ConfirmDeleteDialog({
    Key? key,
    this.stateCharges,
    this.stateBill,
    this.categoryUid,
    this.chargeUid,
    this.chargeCost,
    this.chargeBillUid,
    this.refillUid,
    this.refillModel,
  }) : super(key: key);

  final ChargesState? stateCharges;
  final BillState? stateBill;
  final String? categoryUid;
  final String? chargeUid;
  final double? chargeCost;
  final String? chargeBillUid;
  final String? refillUid;
  final RefillModel? refillModel;

  @override
  State<_ConfirmDeleteDialog> createState() => _ConfirmDeleteDialogState();
}

class _ConfirmDeleteDialogState extends State<_ConfirmDeleteDialog> {
  String getTextConfirmation() {
    if (widget.categoryUid != null) {
      return 'Вы действительно хотите удалить категорию?';
    }

    if (widget.chargeUid != null) {
      return 'Вы действительно хотите удалить расход?';
    }

    if (widget.refillUid != null) {
      return 'Вы действительно хотите удалить приход?';
    }

    return 'Вы действительно хотите удалить?';
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Удалить',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
          ),
          const Padding(
            padding: EdgeInsets.all(15.0),
          ),
          Text(getTextConfirmation()),
          const Padding(
            padding: EdgeInsets.all(15.0),
          ),
          ElevatedButton(
            onPressed: () {
              if (widget.stateCharges != null && widget.chargeUid != null) {
                widget.stateCharges?.deleteCharge(chargeDocId: widget.chargeUid, chargeCost: widget.chargeCost, chargeBillUid: widget.chargeBillUid);
              }

              if (widget.stateCharges != null && widget.categoryUid != null) {
                widget.stateCharges?.deleteCategory(categoryUid: widget.categoryUid);
              }

              if (widget.stateBill != null && widget.refillUid != null) {
                widget.stateBill?.refillAmountDelete(refillDocId: widget.refillUid, refillModel: widget.refillModel);
              }

              Navigator.pop(context, null);
            },
            child: const Text('Удалить'),
            style: ButtonStyle(
              minimumSize: MaterialStateProperty.all<Size>(const Size(325, 45)),
              backgroundColor: MaterialStateProperty.all<Color>(
                  Theme.of(context).primaryColor),
            ),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, null),
            child: Text(
              'Отмена',
              style: TextStyle(color: Theme.of(context).accentColor),
            ),
          ),
        ],
      ),
    );
  }
}
