// import 'package:firebase_auth_log_in/ui/pages/log_in_page.dart';
// import 'package:firebase_auth_log_in/ui/pages/sign_up_page.dart';
// import 'package:flutter/material.dart';

// class AuthPage extends StatefulWidget {
//   const AuthPage({super.key});

//   @override
//   State<AuthPage> createState() => _AuthPageState();
// }

// class _AuthPageState extends State<AuthPage> {
//   bool logIn=true;
//   void toggle(){
//     print('log $logIn');
//     logIn=!logIn;
//     setState(() {
      
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return logIn?  LogInPage(onClickedSignUp: toggle):  SignUpPage(onClickedSignUp: toggle);
//   }
// }
import 'package:firebase_auth_log_in/ui/pages/firebase_pages/sign_up_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../providers/logIn_bool_provider.dart';
import 'log_in_page.dart';

class AuthPage extends ConsumerWidget {
  const AuthPage({super.key});
  @override
  Widget build(BuildContext context,ref) {
    final logInRef = ref.watch(logInBoolProvider);
    return logInRef.isSignUp?  LogInPage(onClickedSignUp: logInRef.toggle):  SignUpPage(onClickedSignUp: logInRef.toggle);
  }
}