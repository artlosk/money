import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:money_tracker/observables/bill_observable.dart';
import 'package:provider/provider.dart';

import '../../models/bill_model.dart';
import '../../views/bill_transfer_view.dart';

Future showTransferDialog({
  required BuildContext context,
  required BillState stateBill,
  BillModel? bill,
}) async {
  return await showDialog(
    context: context,
    builder: (context) => _TransferDialog(
      stateBill: stateBill,
      bill: bill,
    ),
  );
}

class _TransferDialog extends StatefulWidget {
  final BillState stateBill;
  final BillModel? bill;

  const _TransferDialog({
    Key? key,
    required this.stateBill,
    this.bill,
  }) : super(key: key);

  @override
  State<_TransferDialog> createState() => _TransferDialogState();
}

class _TransferDialogState extends State<_TransferDialog> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _ctrlAmount = TextEditingController();
  final TextEditingController _ctrlTax = TextEditingController();
  final DateTime currentDate = DateTime.now();

  late BillModel selectedBillFrom;
  late BillModel selectedBillTo;

  String validateRefillMessage = '';
  String validateSelectedBillsMessage = '';

  @override
  void initState() {
    super.initState();
    selectedBillFrom = widget.stateBill.bills[0];
    selectedBillTo = widget.stateBill.bills[1];
    _ctrlAmount.clear();
    _ctrlTax.clear();
  }

  @override
  void dispose() {
    _ctrlAmount.dispose();
    _ctrlTax.dispose();
    super.dispose();
  }

  _transfer() async {
    validateRefillMessage = '';
    try {
      await widget.stateBill.transfer(
        billFrom: selectedBillFrom,
        billTo: selectedBillTo,
        sum: (double.tryParse(_ctrlAmount.text) ?? 0),
        tax: (double.tryParse(_ctrlTax.text) ?? 0),
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
                const Text(
                  'Перевод между счетами',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                ),
                TextFormField(
                  controller: _ctrlAmount,
                  decoration: const InputDecoration(
                    label: Text('Сумма перевода'),
                  ),
                  validator: (value) {
                    if (value == '' || double.parse(value!) < 1)
                      return 'Введите сумму';
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
                TextFormField(
                  controller: _ctrlTax,
                  decoration: const InputDecoration(
                    label: Text('Сумма комиссии за перевод'),
                  ),
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  // validator: (val) => validateCategoryMessage,
                ),
                DropdownButtonFormField<BillModel>(
                  isExpanded: true,
                  hint: const Text('Выберите счёт «откуда»'),
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
                      selectedBillFrom = newValue!;
                    });
                  },
                  value: selectedBillFrom,
                  validator: (value) {
                    if (value != null && value.totalSum < (double.tryParse(_ctrlAmount.text) ?? 0) + (double.tryParse(_ctrlTax.text) ?? 0)) {
                      return 'Недостаточно средств на балансе';
                    }
                    return null;
                  },
                ),
                DropdownButtonFormField<BillModel>(
                  isExpanded: true,
                  hint: const Text('Выберите счёт «куда»'),
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
                      selectedBillTo = newValue!;
                    });
                  },
                  value: selectedBillTo,
                  validator: (value) {
                    if (value != null && value.uid == selectedBillFrom.uid) {
                      return 'Счёт получения совпадает со счётом отправления';
                    }
                    return null;
                  },
                ),
              ]);
            }),
            const Padding(
              padding: EdgeInsets.all(15.0),
            ),
            Observer(
              builder: (_) => ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    await _transfer();
                    if (!mounted) return;
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (BuildContext context) {
                          return MultiProvider(
                            providers: [
                              Provider(create: (context) => BillState(userId: widget.stateBill.userId)),
                            ],
                            builder: (context, child) {
                              final BillState state = Provider.of<BillState>(context);
                              state.currentDate = widget.stateBill.currentDate;
                              return const BillTransferView();
                            },
                          );
                        },
                      ),
                    ).then((value) => Navigator.of(context).pop());
                  }
                },
                style: ButtonStyle(
                  minimumSize: MaterialStateProperty.all<Size>(
                    const Size(325, 45),
                  ),
                  backgroundColor: MaterialStateProperty.all<Color>(
                    widget.stateBill.refillLoaded == false
                        ? const Color(0xFFD0D0D0)
                        : Theme.of(context).primaryColor,
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
                    : const Text('Перевести'),
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
