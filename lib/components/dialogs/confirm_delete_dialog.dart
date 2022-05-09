import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:money_tracker/models/charge_model.dart';
import 'package:money_tracker/observables/charges_observable.dart';

Future showConfirmDeleteDialog({
  required BuildContext context,
  required ChargesState stateCharges,
  int? categoryId,
  ChargeModel? chargeModel,
}) async {
  return await showDialog(
      context: context,
      builder: (context) => _ConfirmDeleteDialog(
            stateCharges: stateCharges,
            categoryId: categoryId,
            chargeModel: chargeModel,
          ));
}

class _ConfirmDeleteDialog extends StatefulWidget {
  const _ConfirmDeleteDialog(
      {Key? key, required this.stateCharges, this.categoryId, this.chargeModel})
      : super(key: key);

  final ChargesState stateCharges;
  final int? categoryId;
  final ChargeModel? chargeModel;

  @override
  State<_ConfirmDeleteDialog> createState() => _ConfirmDeleteDialogState();
}

class _ConfirmDeleteDialogState extends State<_ConfirmDeleteDialog> {
  String getTextConfirmation() {
    if (widget.categoryId != null) {
      return FlutterI18n.translate(context, 'charges.TEXT_QUESTION_DELETE_CATEGORY');
    }

    if (widget.chargeModel != null) {
      return FlutterI18n.translate(context, 'charges.TEXT_QUESTION_DELETE_CHARGE');
    }
    return FlutterI18n.translate(context, 'charges.TEXT_QUESTION_DELETE');
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            FlutterI18n.translate(context, 'charges.TEXT_DELETE'),
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
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
              if (widget.chargeModel != null) {
                widget.stateCharges.deleteCharge(chargeModel: widget.chargeModel);
              }
              if (widget.categoryId != null) {
                widget.stateCharges.deleteCategory(categoryId: widget.categoryId);
              }

              Navigator.pop(context, null);
            },
            child: Text(FlutterI18n.translate(context, 'charges.TEXT_DELETE')),
            style: ButtonStyle(
              minimumSize: MaterialStateProperty.all<Size>(const Size(325, 45)),
              backgroundColor: MaterialStateProperty.all<Color>(
                  Theme.of(context).primaryColor),
            ),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, null),
            child: Text(
              FlutterI18n.translate(context, 'charges.TEXT_CANCEL'),
              style: TextStyle(color: Theme.of(context).accentColor),
            ),
          ),
        ],
      ),
    );
  }
}
