import 'package:flutter/material.dart';
import 'package:money_tracker/components/enums.dart';
import 'package:money_tracker/observables/charges_observable.dart';
import 'package:uuid/uuid.dart';

import '../../models/category_model.dart';
import 'color_dialog.dart';

Future showCategoryDialog({
  required BuildContext context,
  required ChargesState stateCharges,
  required ActionsDialog action,
  CategoryModel? category,
}) async {
  return await showDialog(
      context: context,
      builder: (context) => _CategoryDialog(stateCharges: stateCharges, action: action, category: category));
}

class _CategoryDialog extends StatefulWidget {
  final ChargesState stateCharges;
  final ActionsDialog action;
  final CategoryModel? category;

  const _CategoryDialog({Key? key, required this.stateCharges, required this.action, required this.category})
      : super(key: key);

  @override
  State<_CategoryDialog> createState() => _CategoryDialogState();
}

class _CategoryDialogState extends State<_CategoryDialog> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _ctrlTitleCategory = TextEditingController();
  final TextEditingController _ctrlColorCategory = TextEditingController();

  String validateCategoryMessage = '';

  @override
  void initState() {
    super.initState();
    _ctrlTitleCategory.clear();
    _ctrlColorCategory.clear();

    if (widget.category != null) {
      _ctrlTitleCategory.text = widget.category!.title;
      _ctrlColorCategory.text = widget.category!.color;
    }
  }

  @override
  void dispose() {
    _ctrlTitleCategory.dispose();
    _ctrlColorCategory.dispose();
    super.dispose();
  }

  void _selectColor() async {
    final String? color = await showColorPickerDialog(
        context: context,
        currentColor: _ctrlColorCategory.text.isNotEmpty
            ? _ctrlColorCategory.text
            : null);
    if (color != null) {
      setState(() {
        _ctrlColorCategory.text = color;
      });
    }
  }

  _checkCategory() async {
    await widget.stateCharges.checkExistCategory(title: _ctrlTitleCategory.text).then((value) {
      if (value == true) {
        validateCategoryMessage = 'Категория уже существует';
        _formKey.currentState!.validate();
      } else {
        validateCategoryMessage = '';
        _formKey.currentState!.validate();
      }
    });
  }

  _addCategory() async {
    await widget.stateCharges.createCategory(
      model: CategoryModel(
        uid: const Uuid().v1(),
        title: _ctrlTitleCategory.text,
        color: _ctrlColorCategory.text,
      ),
    );
  }

  _updateCategory() async {
    validateCategoryMessage = '';
    try {
      await widget.stateCharges.updateCategory(
        model: CategoryModel(
          uid: widget.category!.uid,
          title: _ctrlTitleCategory.text,
          color: _ctrlColorCategory.text,
        ),
      );
    } catch (e) {
      validateCategoryMessage = e.toString();
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
                  widget.action == ActionsDialog.create ? 'Добавить категорию' : 'Изменить категорию',
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                ),
               TextFormField(
                  controller: _ctrlTitleCategory,
                  decoration: const InputDecoration(
                    label: Text('Название'),
                  ),
                  validator: (value) {

                    if (value == '') return 'Введите название категории';
                    if (validateCategoryMessage.isNotEmpty) {
                      return validateCategoryMessage;
                    }
                    return null;
                  },
                 // validator: (val) => validateCategoryMessage,
                ),
                TextFormField(
                  controller: _ctrlColorCategory,
                  decoration: const InputDecoration(
                    label: Text('Цвет'),
                  ),
                  validator: (value) {
                    if (value == '') return 'Укажите цвет категории';
                    return null;
                  },
                  onTap: () {
                    _selectColor();
                  },
                  readOnly: true,
                ),
              ]);
            }),
            const Padding(
              padding: EdgeInsets.all(15.0),
            ),
            ElevatedButton(
              onPressed: () async {

                if (widget.action == ActionsDialog.create) {
                  await _checkCategory();
                }

                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  Navigator.pop(context, null);
                  if (widget.action == ActionsDialog.create) {
                    await _addCategory();
                  }

                  if (widget.action == ActionsDialog.update) {
                    await _updateCategory();
                  }
                }
              },
              child: Text(widget.action == ActionsDialog.create ? 'Добавить' : 'Изменить'),
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
