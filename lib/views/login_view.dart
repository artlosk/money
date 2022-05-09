import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:provider/provider.dart';

import '../components/forms/auth_form.dart';
import '../observables/auth_observable.dart';

enum FormType { signIn, signUp }

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  FormType _formType = FormType.signIn;

  _switchForm() {
    setState(() {
      _formType =
          _formType == FormType.signIn ? FormType.signUp : FormType.signIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<AuthState>(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(30),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.only(top: 20),
                child: Column(
                  children: [
                    Image.asset('assets/images/favicon.png'),
                    const Padding(
                      padding: EdgeInsets.all(6.5),
                    ),
                    Text(
                        FlutterI18n.translate(context, "login.TEXT_HEADER"),
                      style:
                          const TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(10),
                    ),
                    Text(FlutterI18n.translate(context, "login.TEXT_DESCRIPTION"))
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(20),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: AuthForm(formType: _formType),
                ),
              ),
              const Divider(
                thickness: 2,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    _formType == FormType.signIn
                        ? FlutterI18n.translate(context, "login.TEXT_SWITCH_SIGN_UP")
                        : FlutterI18n.translate(context, "login.TEXT_SWITCH_SIGN_IN"),
                  ),
                  TextButton(
                    child: RichText(
                      text: TextSpan(children: [
                        TextSpan(
                          text: _formType == FormType.signIn
                              ? FlutterI18n.translate(context, "login.TEXT_SIGN_UP")
                              : FlutterI18n.translate(context, "login.TEXT_SIGN_IN")
                        )
                      ], style: Theme.of(context).textTheme.bodyText1),
                    ),
                    onPressed: () {
                      _switchForm();
                      state.errorAuth = '';
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
