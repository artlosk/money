import 'package:flutter/material.dart';
import 'package:money_tracker/components/themes/palette.dart';

ThemeData _themePurple = ThemeData.light();

ThemeData themePurple = _themePurple.copyWith(
  appBarTheme: _appBar(_themePurple.appBarTheme),
  textTheme: _text(_themePurple.textTheme),
  colorScheme: ColorScheme.fromSwatch(primarySwatch: Palette.violet),
  primaryColor: const Color(0xFF9053EB),
  accentColor: Colors.red,//const Color(0xFF9053EB),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      // Makes all my ElevatedButton green
      backgroundColor:
          MaterialStateProperty.all<Color>(const Color(0xFF9053EB)),
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          //side: BorderSide(color: Colors.red)
        ),
      ),
    ),
  ),
  bottomNavigationBarTheme:
      _bottomNavigationBar(_themePurple.bottomNavigationBarTheme),
  dialogTheme: _dialogTheme(_themePurple.dialogTheme),
  inputDecorationTheme: _inputDecorationTheme(_themePurple.inputDecorationTheme)
);

DialogTheme _dialogTheme(DialogTheme base) {
  return base.copyWith(
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(16.0),
      ),
    ),
  );
}


InputDecorationTheme _inputDecorationTheme(InputDecorationTheme base) {
  return base.copyWith(
    labelStyle:
    const TextStyle(fontSize: 14, color: Color(0xFFABABAB)),
    enabledBorder: const UnderlineInputBorder(
      borderSide: BorderSide(color: Color(0xFFD0D0D0)),
    ),
    focusedBorder: const UnderlineInputBorder(
      borderSide: BorderSide(
        color: Color(0xFF9053EB),
      ),
    ),
    floatingLabelStyle: const TextStyle(
      color: Color(0xFF9053EB),
    ),
    focusColor: const Color(0xFF9053EB),
  );
}

AppBarTheme _appBar(AppBarTheme base) {
  return base.copyWith(
    color: const Color(0xFF9053EB),
  );
}

//
BottomNavigationBarThemeData _bottomNavigationBar(
    BottomNavigationBarThemeData base) {
  return base.copyWith(
    selectedItemColor: const Color(0xFF9053EB),
    unselectedItemColor: Colors.black54,
  );
}

TextTheme _text(TextTheme base) {
  return base.copyWith(
    bodyText1: base.bodyText1?.copyWith(color: const Color(0xFF9053EB)),
  );
}
