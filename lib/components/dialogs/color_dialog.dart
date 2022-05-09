import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:money_tracker/components/extensions/hex_color_extension.dart';

Future showColorPickerDialog({
  required BuildContext context,
  String? currentColor
}) async {
  return await showDialog(
    context: context,
    builder: (BuildContext context) => _ColorDialog(currentColor: currentColor),
  );
}

class _ColorDialog extends StatefulWidget {
  final String? currentColor;
  const _ColorDialog({Key? key, this.currentColor}) : super(key: key);

  @override
  State<_ColorDialog> createState() => _ColorDialogState();
}

class _ColorDialogState extends State<_ColorDialog> {

  Color randomColor = Color((Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0);
  final TextEditingController _ctrlColorCategory = TextEditingController();

  @override
  void initState() {
    super.initState();
    _selectCurrentColor();
  }

  void _selectCurrentColor() {
    _ctrlColorCategory.text = widget.currentColor ?? randomColor.toHex();
  }

  @override
  void dispose() {
    _ctrlColorCategory.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(FlutterI18n.translate(context, 'charges.TEXT_SET_COLOR_CATEGORY')),
      content: SingleChildScrollView(
        child: ColorPicker(
          pickerColor: HexColor.fromHex(_ctrlColorCategory.text),
          onColorChanged: (Color color) {
            _ctrlColorCategory.text = color.toHex();
          },
        ),
      ),
      actions: <Widget>[
        ElevatedButton(
          child: Text(FlutterI18n.translate(context, 'charges.TEXT_APPROVE')),
          onPressed: () {
            Navigator.pop(context, _ctrlColorCategory.text);
          },
        ),
      ],
    );
  }
}
