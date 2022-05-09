// import 'package:flutter/material.dart';
// import 'package:flutter_i18n/flutter_i18n.dart';
// import '../../old_observable/auth_observable.dart';
// import 'package:provider/provider.dart';
//
// import '../utils/validate_email.dart';
//
// class ResetPasswordView extends StatelessWidget {
//   ResetPasswordView({Key? key}) : super(key: key);
//
//   final TextEditingController _controllerEmail = TextEditingController();
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//
//   @override
//   Widget build(BuildContext context) {
//     final stateAuth = Provider.of<AuthState>(context);
//     _controllerEmail.clear();
//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       appBar: AppBar(
//         title: Text(FlutterI18n.translate(context, 'login.TEXT_RECOVERY_PASSWORD_HEADER')),
//       ),
//       body: SafeArea(
//         child: Container(
//           padding: const EdgeInsets.all(25.0),
//           child: Form(
//             key: _formKey,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text(
//                     FlutterI18n.translate(context, 'login.TEXT_RECOVERY_PASSWORD_DESCRIPTION')),
//                 TextFormField(
//                   controller: _controllerEmail,
//                   decoration: const InputDecoration(
//                     label: Text('E-mail'),
//                   ),
//                   validator: (value) {
//                     if (value == '') return FlutterI18n.translate(context, 'login.ERROR_INPUT_EMAIL');
//                     if (!validateEmail(value.toString())) {
//                       return FlutterI18n.translate(context, 'login.ERROR_INCORRECT_EMAIL');
//                     }
//                     return null;
//                   },
//                 ),
//                 const Padding(
//                   padding: EdgeInsets.only(bottom: 10.0),
//                 ),
//                 ElevatedButton(
//                   onPressed: () {
//                     if (_formKey.currentState!.validate()) {
//                       _formKey.currentState!.save();
//                       stateAuth.restPassword(_controllerEmail.text);
//                       Navigator.of(context).pop();
//                     }
//                   },
//                   child: Text(FlutterI18n.translate(context, 'login.TEXT_RECOVERY_PASSWORD_HEADER')),
//                   style: ButtonStyle(
//                     minimumSize:
//                         MaterialStateProperty.all<Size>(const Size(325, 50)),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
