import 'package:flutter/material.dart';
import 'package:money_tracker/observables/charges_observable.dart';

Future showConfirmDeleteDialog({
  required BuildContext context,
  required ChargesState stateCharges,
  String? categoryUid,
  String? chargeUid,
}) async {
  return await showDialog(
      context: context,
      builder: (context) => _ConfirmDeleteDialog(
            stateCharges: stateCharges,
            categoryUid: categoryUid,
            chargeUid: chargeUid,
          ));
}

class _ConfirmDeleteDialog extends StatefulWidget {
  const _ConfirmDeleteDialog(
      {Key? key, required this.stateCharges, this.categoryUid, this.chargeUid})
      : super(key: key);

  final ChargesState stateCharges;
  final String? categoryUid;
  final String? chargeUid;

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
              if (widget.chargeUid != null) {
                widget.stateCharges.deleteCharge(chargeDocId: widget.chargeUid);
              }

              if (widget.categoryUid != null) {
                widget.stateCharges.deleteCategory(categoryUid: widget.categoryUid);
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
