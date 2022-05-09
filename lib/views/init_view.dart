import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:money_tracker/components/enums.dart';
import 'package:money_tracker/observables/charges_observable.dart';
import 'package:money_tracker/observables/storage_observable.dart';
import 'package:money_tracker/observables/tab_observable.dart';
import 'package:money_tracker/views/charges_view.dart';

import 'package:money_tracker/views/login_view.dart';
import 'package:money_tracker/views/profile_view.dart';
import 'package:provider/provider.dart';


import '../observables/auth_observable.dart';
import 'loading_view.dart';

class InitView extends StatelessWidget {
  const InitView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final stateAuth = Provider.of<AuthState>(context);
    final stateTab = Provider.of<TabState>(context);
    return FutureBuilder(
      future: stateAuth.getUser(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: LoadingView(),
          );
        }
        if (snapshot.hasData) {
          return MultiProvider(
            providers: [
              Provider(create: (context) => StorageState(userId: snapshot.data?.id),),
              Provider(create: (context) => ChargesState(userId: snapshot.data?.id),),
            ],
            child: Observer(builder: (context) => stateTab.activeTabIndex == TabButton.charges.index ? const ChargesView() : const ProfileView())
          );
        }
        return const LoginView();
      },
    );
  }
}
