import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:money_tracker/observables/bill_observable.dart';
import 'package:money_tracker/observables/charges_observable.dart';

import '../../models/bill_model.dart';
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
  BillModel? billModel,
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
      billModel: billModel,
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
    this.billModel,
  }) : super(key: key);

  final ChargesState? stateCharges;
  final BillState? stateBill;
  final String? categoryUid;
  final String? chargeUid;
  final double? chargeCost;
  final String? chargeBillUid;
  final String? refillUid;
  final RefillModel? refillModel;
  final BillModel? billModel;

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
      Observer(builder: (_) => ElevatedButton(
            onPressed: () async {
              if (widget.stateCharges != null && widget.chargeUid != null) {
                await widget.stateCharges?.deleteCharge(chargeDocId: widget.chargeUid, chargeCost: widget.chargeCost, chargeBillUid: widget.chargeBillUid);
              }

              if (widget.stateCharges != null && widget.categoryUid != null) {
                await widget.stateCharges?.deleteCategory(categoryUid: widget.categoryUid);
              }

              if (widget.stateBill != null && widget.refillUid != null) {
                await widget.stateBill?.refillAmountDelete(refillDocId: widget.refillUid, refillModel: widget.refillModel, bill: widget.billModel);
              }
              if (!mounted) return;
              Navigator.of(context).pop();
            },
            style: ButtonStyle(
              minimumSize: MaterialStateProperty.all<Size>(const Size(325, 45)),
              backgroundColor: MaterialStateProperty.all<Color>(
                  widget.stateBill != null && widget.refillUid != null && widget.stateBill!.refillLoaded == false ? const Color(0xFFD0D0D0) : Theme.of(context).primaryColor
              ),
            ),
            child: widget.stateBill != null && widget.refillUid != null && widget.stateBill?.refillLoaded == false
                ? const Padding(
              padding: EdgeInsets.all(0),
              child: SizedBox(
                height: 30,
                width: 30,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Color(0xFF9053EB),
                ),
              ),
            )
                : const Text('Удалить'),
          ),),
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
