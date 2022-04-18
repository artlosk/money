import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:money_tracker/components/enums.dart';
import 'package:money_tracker/models/charge_model.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

import '../../observables/charges_observable.dart';

Future showChargeDialog(
    {required BuildContext context,
    required String categoryUid,
    required ChargesState stateCharges,
    required ActionsDialog action,
    ChargeModel? oldCharge,
    String? chargeDocId
    }) async {
  return await showDialog(
    context: context,
    builder: (context) => _ChargeDialog(
      categoryUid: categoryUid,
      stateCharges: stateCharges,
      action: action,
      oldCharge: oldCharge,
      chargeDocId: chargeDocId
    ),
  );
}

class _ChargeDialog extends StatefulWidget {
  final String categoryUid;
  final ChargesState stateCharges;
  final ActionsDialog action;
  final ChargeModel? oldCharge;
  final String? chargeDocId;

  const _ChargeDialog(
      {Key? key,
      required this.categoryUid,
      required this.stateCharges,
      required this.action,
      this.oldCharge,
      this.chargeDocId})
      : super(key: key);

  @override
  State<_ChargeDialog> createState() => _ChargeDialogState();
}

class _ChargeDialogState extends State<_ChargeDialog> {
  final DateTime currentDate = DateTime.now();
  late DateTime chargeDate;

  final TextEditingController _ctrlDescriptionCharge = TextEditingController();
  final TextEditingController _ctrlCostCharge = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: widget.stateCharges.currentDate,
        firstDate: DateTime(2015),
        lastDate: DateTime.now(),
        initialEntryMode: DatePickerEntryMode.input);
    if (pickedDate != null) {
      setState(() {
        chargeDate = pickedDate;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _ctrlDescriptionCharge.clear();
    _ctrlCostCharge.clear();

    if (widget.oldCharge != null) {
        chargeDate = widget.oldCharge!.createdAt;
        _ctrlDescriptionCharge.text = widget.oldCharge!.description;
        _ctrlCostCharge.text = widget.oldCharge!.cost.toString();
    } else {
      setState(() {
        chargeDate = DateFormat('MM').format(currentDate) ==
            DateFormat('MM').format(widget.stateCharges.currentDate)
            ? currentDate
            : widget.stateCharges.currentDate;
      });
    }
  }

  @override
  void dispose() {
    _ctrlDescriptionCharge.dispose();
    _ctrlCostCharge.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Builder(builder: (context) {
              return Column(children: [
                    Text(
                      widget.action == ActionsDialog.create ? 'Добавить Расход' : 'Изменить Расход',
                      style:
                          const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                    ),
                    TextButton(
                      child: Text(DateFormat('dd MMMM yyyy', Localizations.localeOf(context).languageCode)
                          .format(chargeDate)
                          .toString()),
                      onPressed: () {
                        _selectDate(context);
                      },
                    ),
                TextFormField(
                  controller: _ctrlDescriptionCharge,
                  decoration: const InputDecoration(
                    label: Text('Наименование расхода'),
                  ),
                ),
                TextFormField(
                  controller: _ctrlCostCharge,
                  decoration: const InputDecoration(
                    label: Text('Введите сумму'),
                  ),
                  validator: (value) {
                    if (value == '' || double.tryParse(value!)! < 1) {
                      return 'Введите сумму';
                    }
                    return null;
                  },
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                ),
              ]);
            },),
            const Padding(
              padding: EdgeInsets.all(15.0),
            ),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  if (widget.action == ActionsDialog.create) {
                    widget.stateCharges.createCharge(
                      model:
                      ChargeModel(
                        uid: const Uuid().v1(),
                        userUid: widget.stateCharges.userId,
                        categoryUid: widget.categoryUid,
                        description: _ctrlDescriptionCharge.text,
                        cost: double.tryParse(_ctrlCostCharge.text) ?? 0.0,
                        createdAt: chargeDate,
                      ),
                    );
                  }

                  if (widget.action == ActionsDialog.update) {
                    widget.stateCharges.updateCharge(
                      chargeDocId: widget.chargeDocId,
                      model: ChargeModel(
                        uid: widget.oldCharge!.uid,
                        userUid: widget.oldCharge!.userUid,
                        categoryUid: widget.oldCharge!.categoryUid,
                        description: _ctrlDescriptionCharge.text,
                        cost: double.tryParse(_ctrlCostCharge.text) ?? 0.0,
                        createdAt: chargeDate,
                      ),
                    );
                  }

                  Navigator.pop(context, null);
                }
              },
              child: Text(widget.action == ActionsDialog.create ? 'Добавить' : 'Изменить'),
              style: ButtonStyle(
                minimumSize:
                    MaterialStateProperty.all<Size>(const Size(325, 45)),
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
      ),
    );
  }
}
