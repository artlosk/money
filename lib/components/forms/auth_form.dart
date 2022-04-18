import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

import '../../observables/auth_observable.dart';
import '../../utils/validate_email.dart';
import '../../views/login_view.dart';

class AuthForm extends StatefulWidget {
  const AuthForm({Key? key, required this.formType}) : super(key: key);

  final formType;

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<AuthState>(context);
    _controllerEmail.clear();
    _controllerPassword.clear();
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: _controllerEmail,
            decoration: const InputDecoration(
              label: Text('E-mail'),
            ),
            validator: (value) {
              if (value == '') return 'Введите E-mail';
              if (!validateEmail(value.toString())) {
                return 'Некорректный E-mail';
              }
              return null;
            },
          ),
          TextFormField(
            controller: _controllerPassword,
            obscureText: true,
            decoration: const InputDecoration(
              label: Text('Пароль'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Observer(builder: (context) {
              return Text(
                state.errorAuth,
                style: TextStyle(color: Theme.of(context).accentColor, fontSize: 12),
              );
            }),
          ),
          const Padding(padding: EdgeInsets.all(20)),
          Observer(builder: (context) {
            return ElevatedButton(
              onPressed: state.isLoading
                  ? null
                  : () async {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        if (widget.formType == FormType.signUp) {
                          state.signUpWithEmailAndPassword(
                            email: _controllerEmail.text,
                            password: _controllerPassword.text,
                          );
                        } else {
                          state.signInWithEmailAndPassword(
                            email: _controllerEmail.text,
                            password: _controllerPassword.text,
                          );
                        }
                        state.errorAuth = '';
                      }
                    },
              child: state.isLoading
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
                  : Text(widget.formType == FormType.signIn
                      ? 'Войти'
                      : 'Регистрация'),
              style: ButtonStyle(
                minimumSize:
                    MaterialStateProperty.all<Size>(const Size(325, 50)),
                backgroundColor: MaterialStateProperty.all<Color>(
                    state.isLoading ? const Color(0xFFD0D0D0) : const Color(0xFF9053EB)),
              ),
            );
          }),
        ],
      ),
    );
  }
}
