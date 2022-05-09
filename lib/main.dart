import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:money_tracker/components/themes/theme_purple.dart';
import 'package:money_tracker/views/init_view.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import 'observables/auth_observable.dart';
import 'observables/tab_observable.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
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
        localizationsDelegates: <LocalizationsDelegate>[
          FlutterI18nDelegate(
            translationLoader: NamespaceFileTranslationLoader(
              namespaces: ["login", "charges", "profile", "bottombar"],
              fallbackDir: 'en',
              basePath: "assets/i18n_namespace"
            ),
            missingTranslationHandler: (key, locale) {
              print("--- Missing Key: $key, languageCode: ${locale?.languageCode}");
            },
          ),
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate
        ],
        locale: const Locale('en'),
        supportedLocales: const [
          Locale('ru'),
          Locale('en'),
        ],
        home: Provider(
          create: (context) => TabState(),
          child: const InitView(),
        ),
      ),
    );
  }
}
