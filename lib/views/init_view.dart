import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:money_tracker/components/enums.dart';
import 'package:money_tracker/observables/bill_observable.dart';
import 'package:money_tracker/observables/charges_observable.dart';
import 'package:money_tracker/observables/storage_observable.dart';
import 'package:money_tracker/observables/tab_observable.dart';
import 'package:money_tracker/views/bill_uid_view.dart';
import 'package:money_tracker/views/bill_view.dart';
import 'package:money_tracker/views/charges_view.dart';

import 'package:money_tracker/views/login_view.dart';
import 'package:money_tracker/views/profile_view.dart';
import 'package:provider/provider.dart';

// import '../observables/auth_observable.dart';
import 'loading_view.dart';

class InitView extends StatefulWidget {
  const InitView({Key? key}) : super(key: key);

  @override
  State<InitView> createState() => _InitViewState();
}

class _InitViewState extends State<InitView> {
  late Stream<User?> _streamUser;

  @override
  void initState() {
    super.initState();
    /*hack without blinking*/
    _streamUser = FirebaseAuth.instance.authStateChanges();
  }

  @override
  Widget build(BuildContext context) {
    //final stateAuth = Provider.of<AuthState>(context);
    final stateTab = Provider.of<TabState>(context);

    return StreamBuilder<User?>(
      stream: _streamUser, //stateAuth.onAuthStateChanged
      builder: (BuildContext context, AsyncSnapshot snapshot) {

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: LoadingView(),
          );
        }

        if (snapshot.connectionState == ConnectionState.active && snapshot.hasData) {
          return MultiProvider(
            providers: [
              Provider(create: (context) => StorageState(userId: snapshot.data?.uid),),
              Provider(create: (context) => ChargesState(userId: snapshot.data?.uid),),
              Provider(create: (context) => BillState(userId: snapshot.data?.uid),),
            ],
            child: Observer(builder: (context) {
              if (stateTab.activeTabIndex == TabButton.bill.index) {
                return const BillView();
              } else if (stateTab.activeTabIndex == TabButton.charges.index) {
                return const ChargesView();
              } else {
                return const ProfileView();
              }
            })
          );
        }
        return const LoginView();
      },
    );
  }
}
