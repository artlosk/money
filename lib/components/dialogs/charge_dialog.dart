import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:money_tracker/components/enums.dart';
import 'package:money_tracker/models/charge_model.dart';
import 'package:intl/intl.dart';

import '../../observables/charges_observable.dart';

Future showChargeDialog(
    {required BuildContext context,
    required int categoryId,
    required ChargesState stateCharges,
    required ActionsDialog action,
    ChargeModel? oldCharge,
    int? chargeId
    }) async {
  return await showDialog(
    context: context,
    builder: (context) => _ChargeDialog(
      categoryId: categoryId,
      stateCharges: stateCharges,
      action: action,
      oldCharge: oldCharge,
      chargeId: chargeId
    ),
  );
}

class _ChargeDialog extends StatefulWidget {
  final int categoryId;
  final ChargesState stateCharges;
  final ActionsDialog action;
  final ChargeModel? oldCharge;
  final int? chargeId;

  const _ChargeDialog(
      {Key? key,
      required this.categoryId,
      required this.stateCharges,
      required this.action,
      this.oldCharge,
      this.chargeId})
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
    final date = widget.stateCharges.currentDate;
    final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: date,//widget.stateCharges.currentDate,
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
                      widget.action == ActionsDialog.create ? FlutterI18n.translate(context, 'charges.TEXT_CREATE_CHARGE') : FlutterI18n.translate(context, 'charges.TEXT_UPDATE_CHARGE'),
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
                  decoration: InputDecoration(
                    label: Text(FlutterI18n.translate(context, 'charges.TEXT_TITLE_CHARGE')),
                  ),
                ),
                TextFormField(
                  controller: _ctrlCostCharge,
                  decoration: InputDecoration(
                    label: Text(FlutterI18n.translate(context, 'charges.TEXT_SUM')),
                  ),
                  validator: (value) {
                    if (value == '' || double.tryParse(value!)! < 1) {
                      return FlutterI18n.translate(context, 'charges.ERROR_TEXT_SET_SUM');
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
                        id: null,
                        categoryId: widget.categoryId,
                        description: _ctrlDescriptionCharge.text,
                        cost: double.tryParse(_ctrlCostCharge.text) ?? 0.0,
                        createdAt: chargeDate,
                      ),
                    );
                  }

                  if (widget.action == ActionsDialog.update) {
                    widget.stateCharges.updateCharge(
                      model: ChargeModel(
                        id: widget.oldCharge!.id,
                        categoryId: widget.oldCharge!.categoryId,
                        description: _ctrlDescriptionCharge.text,
                        cost: double.tryParse(_ctrlCostCharge.text) ?? 0.0,
                        createdAt: chargeDate,
                      ),
                    );
                  }

                  Navigator.pop(context, null);
                }
              },
              child: Text(widget.action == ActionsDialog.create ? FlutterI18n.translate(context, 'charges.TEXT_CREATE') : FlutterI18n.translate(context, 'charges.TEXT_UPDATE')),
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
                FlutterI18n.translate(context, 'charges.TEXT_CANCEL'),
                style: TextStyle(color: Theme.of(context).accentColor),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
