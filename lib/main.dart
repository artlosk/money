import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:money_tracker/components/themes/theme_purple.dart';
import 'package:money_tracker/views/init_view.dart';
import 'package:money_tracker/views/login_view.dart';
import 'package:provider/provider.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'components/forms/auth_form.dart';
import 'observables/auth_observable.dart';
import 'observables/tab_observable.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseFirestore.instance.settings = const Settings(
    //host: 'localhost:8080',
    sslEnabled: false,
    persistenceEnabled: true,
  );
  // FirebaseFirestore.instance.useFirestoreEmulator('localhost', 8080);
  // FirebaseAuth.instance.useAuthEmulator('localhost', 9099);
  // FirebaseStorage.instance.useStorageEmulator('localhost', 9199);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(
          create: (context) => AuthState(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: themePurple,
        debugShowCheckedModeBanner: false,
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate
        ],
        locale: const Locale('ru'),
        supportedLocales: const [
          Locale('en', 'US'),
          Locale('ru', 'RU'),
        ],
        home: Provider(
          create: (context) => TabState(),
          child: const InitView(),
        ),
      ),
    );
  }
}
