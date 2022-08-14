import 'package:flutter/material.dart';
import 'package:money_tracker/components/enums.dart';
import 'package:money_tracker/observables/charges_observable.dart';
import 'package:uuid/uuid.dart';

import '../../models/bill_model.dart';
import '../../models/category_model.dart';
import '../../observables/bill_observable.dart';
import 'color_dialog.dart';

Future showBillDialog({
  required BuildContext context,
  required BillState stateBill,
  required ActionsDialog action,
  BillModel? bill,
}) async {
  return await showDialog(
      context: context,
      builder: (context) =>
          _BillDialog(stateBill: stateBill, action: action, bill: bill));
}

class Item {
  const Item(this.name, this.value, this.icon);
  final String name;
  final String value;
  final Icon icon;
}

class _BillDialog extends StatefulWidget {
  final BillState stateBill;
  final ActionsDialog action;
  final BillModel? bill;

  const _BillDialog(
      {Key? key,
      required this.stateBill,
      required this.action,
      required this.bill,})
      : super(key: key);

  @override
  State<_BillDialog> createState() => _BillDialogState();
}

class _BillDialogState extends State<_BillDialog> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _ctrlTitleBill = TextEditingController();

  String validateBillMessage = '';

  List billType = [
    const Item('Наличные', "cash", Icon(Icons.attach_money, color:  Color(0xFF9053EB),)),
    const Item('Карта', "card", Icon(Icons.credit_card, color:  Color(0xFF9053EB),)),
  ];

  Object? selectedValue = BillTypes.cash.name;

  @override
  void initState() {
    super.initState();
    _ctrlTitleBill.clear();

    if (widget.bill != null) {
      _ctrlTitleBill.text = widget.bill!.title;
    }
  }

  @override
  void dispose() {
    _ctrlTitleBill.dispose();
    super.dispose();
  }

  _checkBill() async {
    await widget.stateBill
        .checkExistBill(title: _ctrlTitleBill.text)
        .then((value) {
      if (value == true) {
        validateBillMessage = 'Счет уже существует';
        _formKey.currentState!.validate();
      } else {
        validateBillMessage = '';
        _formKey.currentState!.validate();
      }
    });
  }

  _addBill() async {
    await widget.stateBill.createBill(
      model: BillModel(
        uid: const Uuid().v1(),
        userUid: widget.stateBill.userId,
        title: _ctrlTitleBill.text,
        totalSum: 0.0,
        type: selectedValue.toString(),
      ),
    );
  }

  _updateBill() async {
    validateBillMessage = '';
    try {
      await widget.stateBill.updateBill(
        model: BillModel(
          id: widget.bill!.id,
          uid: widget.bill!.uid,
          userUid: widget.bill!.userUid,
          title: _ctrlTitleBill.text,
          totalSum: widget.bill!.totalSum,
          type: selectedValue.toString(),
        ),
      );
    } catch (e) {
      validateBillMessage = e.toString();
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
            Builder(
              builder: (context) {
                return Column(
                  children: [
                    Text(
                      widget.action == ActionsDialog.create
                          ? 'Добавить счет'
                          : 'Изменить название счета',
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w700),
                    ),
                    TextFormField(
                      controller: _ctrlTitleBill,
                      decoration: const InputDecoration(
                        label: Text('Название'),
                      ),
                      validator: (value) {
                        if (value == '') return 'Введите название счета';
                        if (validateBillMessage.isNotEmpty) {
                          return validateBillMessage;
                        }
                        return null;
                      },
                      // validator: (val) => validateCategoryMessage,
                    ),
                DropdownButton(
                  hint: Text('Выберите тип счета'),
                      isExpanded: true,
                      items: billType.map((type) {
                        return DropdownMenuItem(
                          value: type.value,
                          child: Row(
                            children: [
                              type.icon,
                              SizedBox(width: 10,),
                              Text(
                                type.name,
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                      onChanged: (newValue) {
                        setState(() {
                          selectedValue = newValue;
                        });
                      },
                      value: selectedValue
                    ),
                  ],
                );
              },
            ),
            const Padding(
              padding: EdgeInsets.all(15.0),
            ),
            ElevatedButton(
              onPressed: () async {
                if (widget.action == ActionsDialog.create) {
                  await _checkBill();
                }

                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  Navigator.pop(context, null);
                  if (widget.action == ActionsDialog.create) {
                    await _addBill();
                  }

                  if (widget.action == ActionsDialog.update) {
                    await _updateBill();
                  }
                }
              },
              child: Text(widget.action == ActionsDialog.create
                  ? 'Добавить'
                  : 'Изменить'),
              style: ButtonStyle(
                minimumSize: MaterialStateProperty.all<Size>(
                  const Size(325, 45),
                ),
                backgroundColor: MaterialStateProperty.all<Color>(
                  Theme.of(context).primaryColor,
                ),
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
