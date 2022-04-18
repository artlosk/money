import 'package:flutter/material.dart';
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
            //mainAxisAlignment: MainAxisAlignment.,
            //crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: const EdgeInsets.only(top: 50),
                child: Column(
                  children: [
                    Image.asset('assets/images/favicon.png'),
                    const Padding(
                      padding: EdgeInsets.all(6.5),
                    ),
                    const Text(
                      'Учет расходов',
                      style:
                      TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(10),
                    ),
                    const Text('Ваша история расходов всегда под рукой')
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    _formType == FormType.signIn
                        ? 'Еще нет аккаунта?'
                        : 'Уже есть аккаунт? ',
                  ),
                  TextButton(
                    child: RichText(
                      text: TextSpan(children: [
                        TextSpan(
                          text: _formType == FormType.signIn
                              ? 'Регистрация'
                              : 'Войти',
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