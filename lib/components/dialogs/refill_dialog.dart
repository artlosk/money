import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:intl/intl.dart';
import 'package:money_tracker/components/enums.dart';
import 'package:money_tracker/models/refill_model.dart';
import 'package:money_tracker/observables/bill_observable.dart';
import 'package:uuid/uuid.dart';

import '../../models/bill_model.dart';

Future showRefillDialog({
  required BuildContext context,
  required BillState stateBill,
  required ActionsDialog action,
  RefillModel? refill,
  BillModel? bill,
  String? refillId,
}) async {
  return await showDialog(
      context: context,
      builder: (context) => _RefillDialog(
        stateBill: stateBill,
        action: action,
        refill: refill,
        bill: bill,
        refillId: refillId,
      ),
  );
}

class _RefillDialog extends StatefulWidget {
  final BillState stateBill;
  final ActionsDialog action;
  final RefillModel? refill;
  final String? refillId;
  final BillModel? bill;

  const _RefillDialog({
    Key? key,
    required this.stateBill,
    required this.action,
    this.refill,
    this.refillId,
    this.bill,
  }) : super(key: key);

  @override
  State<_RefillDialog> createState() => _RefillDialogState();
}

class _RefillDialogState extends State<_RefillDialog> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _ctrlAmount = TextEditingController();
  final TextEditingController _ctrlBill = TextEditingController();
  final DateTime currentDate = DateTime.now();
  late DateTime chargeDate;

  late BillModel selectedBill;

  String validateRefillMessage = '';

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: widget.stateBill.currentDate,
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
    _ctrlAmount.clear();
    _ctrlBill.clear();

    selectedBill = widget.bill ?? widget.stateBill.bills[0];

    if (widget.refill != null) {
      chargeDate = widget.refill!.createdAt;
      _ctrlAmount.text = widget.refill!.cost.toString();
    } else {
      setState(() {
        chargeDate = DateFormat('MM').format(currentDate) ==
            DateFormat('MM').format(widget.stateBill.currentDate)
            ? currentDate
            : widget.stateBill.currentDate;
      });
    }
  }

  @override
  void dispose() {
    _ctrlAmount.dispose();
    super.dispose();
  }

  _refillAmountCreate() async {
    validateRefillMessage = '';
    try {
      await widget.stateBill.refillAmountCreate(
          refillModel: RefillModel(
              uid: const Uuid().v1(),
              billId: selectedBill.id!,
              billUid: selectedBill.uid,
              billTitle: selectedBill.title,
              userUid: selectedBill.userUid,
              cost: double.parse(_ctrlAmount.text),
              createdAt: chargeDate,
          ),
        bill: widget.bill,

      );
    } catch (e) {
      validateRefillMessage = e.toString();
    }
  }

  _refillAmountUpdate() async {
    validateRefillMessage = '';
    try {
      await widget.stateBill.refillAmountUpdate(
        refillModel: RefillModel(
          id: widget.refill!.id,
          uid: widget.refill!.uid,
          billId: widget.refill!.billId,
          billUid: widget.refill!.billUid,
          billTitle: widget.refill!.billTitle,
          userUid: widget.refill!.userUid,
          cost: double.parse(_ctrlAmount.text),
          createdAt: chargeDate,
        ),
        oldCost: widget.refill!.cost,
        bill: widget.bill
      );
    } catch (e) {
      validateRefillMessage = e.toString();
    }
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
                  widget.action == ActionsDialog.create ? 'Пополнить счет' : 'Изменить пополнение',
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w700),
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
                  controller: _ctrlAmount,
                  decoration: const InputDecoration(
                    label: Text('Сумма'),
                  ),
                  validator: (value) {
                    if (value == '' || double.parse(value!) < 1) return 'Введите сумму';
                    if (validateRefillMessage.isNotEmpty) {
                      return validateRefillMessage;
                    }
                    return null;
                  },
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  // validator: (val) => validateCategoryMessage,
                ),
                Visibility(
                  visible: widget.action != ActionsDialog.update && widget.bill == null,
                  child: DropdownButton<BillModel>(
                    isExpanded: true,
                    hint: const Text('Выберите счёт для пополнения'),
                    items: widget.stateBill.bills.map((bill) {
                      return DropdownMenuItem(
                        value: bill,
                        child: Row(
                          children: [
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              bill.title,
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                    onChanged: (BillModel? newValue) {
                      setState(() {
                        selectedBill = newValue!;
                      });
                    },
                    value: widget.action != ActionsDialog.update && widget.bill == null ? selectedBill : null,
                  ),
                )
              ]);
            }),
            const Padding(
              padding: EdgeInsets.all(15.0),
            ),
            Observer(builder: (_) => ElevatedButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                   _formKey.currentState!.save();
                   if (widget.action == ActionsDialog.create) {
                     await _refillAmountCreate();
                   }

                   if (widget.action == ActionsDialog.update) {
                     await _refillAmountUpdate();
                   }
                   if (!mounted) return;
                   Navigator.of(context).pop();
                }
              },
              style: ButtonStyle(
                minimumSize: MaterialStateProperty.all<Size>(
                  const Size(325, 45),
                ),
                backgroundColor: MaterialStateProperty.all<Color>(
                  widget.stateBill.refillLoaded == false ? const Color(0xFFD0D0D0) : Theme.of(context).primaryColor,
                ),
              ),
              child: widget.stateBill.refillLoaded == false
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
                  : widget.action == ActionsDialog.create ? Text('Пополнить') : Text('Изменить'),
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
      ),
    );
  }
}
