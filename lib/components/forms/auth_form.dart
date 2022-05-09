import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:money_tracker/main.dart';
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
              if (value == '') return FlutterI18n.translate(context, 'login.ERROR_INPUT_EMAIL');
              if (!validateEmail(value.toString())) {
                return FlutterI18n.translate(context, 'login.ERROR_INCORRECT_EMAIL');
              }
              return null;
            },
          ),
          TextFormField(
            controller: _controllerPassword,
            obscureText: true,
            validator: (value) {
              if (value == '') return FlutterI18n.translate(context, 'login.ERROR_INPUT_PASSWORD');
              if (widget.formType == FormType.signUp && value != null && value.length < 6) {
                return FlutterI18n.translate(context, 'login.ERROR_INCORRECT_PASSWORD');
              }
              return null;
            },
            decoration: InputDecoration(
              label: Text(FlutterI18n.translate(context, 'login.TEXT_INPUT_PASSWORD')),
            ),
          ),
          Observer(
            builder: (context) {
              return Visibility(
                visible: state.errorAuth.isNotEmpty,
                child: Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Text(
                      FlutterI18n.translate(context, state.errorAuth),
                      style: TextStyle(
                          color: Theme.of(context).accentColor, fontSize: 12),
                    ),),
              );
            },
          ),
          const Padding(padding: EdgeInsets.only(top: 10.0)),
          Observer(
            builder: (context) {
              return Column(
                children: [
                  ElevatedButton(
                    onPressed: state.isLoading
                        ? null
                        : () async {
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();
                              if (widget.formType == FormType.signUp) {
                                state.signUpWithEmailAndPassword(
                                  email: _controllerEmail.text,
                                  password: _controllerPassword.text,
                                ).then((value) {
                                  if (value.isNotEmpty) {
                                    Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => MyApp()),
                                            (route) => true);
                                  }
                                });
                              } else {
                                state.signInWithEmailAndPassword(
                                  email: _controllerEmail.text,
                                  password: _controllerPassword.text,
                                ).then((value) {
                                  if (value.isNotEmpty) {
                                    Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => MyApp()),
                                            (route) => true);
                                  }
                                });
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
                            ? FlutterI18n.translate(context, 'login.TEXT_SIGN_IN')
                            : FlutterI18n.translate(context, 'login.TEXT_SIGN_UP'),
                          ),
                    style: ButtonStyle(
                      minimumSize:
                          MaterialStateProperty.all<Size>(const Size(325, 50)),
                      backgroundColor: MaterialStateProperty.all<Color>(
                          state.isLoading
                              ? const Color(0xFFD0D0D0)
                              : const Color(0xFF9053EB)),
                    ),
                  ),
                  Visibility(
                    visible: widget.formType == FormType.signIn,
                    child: TextButton(
                      child: Text(FlutterI18n.translate(context, 'login.TEXT_RECOVERY_PASSWORD')),
                      onPressed: () {
                        // Navigator.pushAndRemoveUntil(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => ResetPasswordView()),
                        //     (route) => true);
                      },
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
