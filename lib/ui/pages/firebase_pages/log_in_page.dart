import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_log_in/ui/pages/firebase_pages/sign_in_google.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../widget/utils.dart';
import 'forget_pw.dart';

class LogInPage extends StatefulWidget {
  final VoidCallback onClickedSignUp;
  const LogInPage({super.key, required this.onClickedSignUp});

  @override
  State<LogInPage> createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _key = GlobalKey<FormState>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    emailController.text='phyoaungh17@gmail.com';
    passwordController.text='wphyoeaung100';
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(
              'https://i.pinimg.com/originals/4a/12/f5/4a12f5e4d6c6144946d1a7894dcc1cdf.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: Form(
          key: _key,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Welcome to my app",
                style: TextStyle(fontSize: 20, color: Colors.cyan),
              ),
              const SizedBox(
                height: 30,
              ),
              Column(
                children: [
                  TextFormField(
                    controller: emailController..selection,
                    style:  TextStyle(fontSize: 14, color: Colors.yellow[100]),
                    cursorColor: Colors.green,
                    onFieldSubmitted: (value) {
                      value = passwordController.text;
                      setState(() {});
                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (email) {
                      return email != null && !EmailValidator.validate(email)
                          ? 'Enter a valid email'
                          : null;
                    },
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                        labelText: 'Email',
                        labelStyle: TextStyle(color: Colors.cyan[200])),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  TextFormField(
                    controller: passwordController,
                    style:  TextStyle(fontSize: 14, color: Colors.yellow[100]),
                    cursorColor: Colors.green,
                    onFieldSubmitted: (value) {
                      value = passwordController.text;
                      setState(() {});
                    },
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                        labelText: 'Password',
                        labelStyle: TextStyle(color: Colors.cyan[200])),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (pw) {
                      return pw != null && pw.length <= 8
                          ? 'Enter a valid password'
                          : null;
                    },
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton.icon(
                    onPressed: signIn,
                    icon: const Icon(
                      Icons.lock_open,
                      size: 30,
                    ),
                    label: const Text('Log in'),
                    style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromHeight(50)),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              InkWell(
                  onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => const ForgetPw())),
                  child: const Text(
                    "Forget Password",
                    style: TextStyle(color: Colors.tealAccent),
                  )),
              const SizedBox(height: 12),
              RichText(
                  text: TextSpan(
                      text: 'No account?',
                      style: const TextStyle(color: Colors.amber),
                      children: [
                    const WidgetSpan(
                      child: SizedBox(width: 8),
                    ),
                    TextSpan(
                        recognizer: TapGestureRecognizer()
                          ..onTap = widget.onClickedSignUp,
                        text: 'Sign Up',
                        style: const TextStyle(
                            decoration: TextDecoration.underline, fontSize: 16))
                  ])),
              const SizedBox(
                height: 10,
              ),
              const SignInGoogle()
            ],
          ),
        ),
      ),
    ));
  }

  Future signIn() async {
    final isValid = _key.currentState!.validate();
    if (!isValid) return;
    // showDialog(
    //     // context: context,
    //     // barrierDismissible: false,
    //     // builder: (context) {
    //     //   return const Center(child: CircularProgressIndicator());
    //     // });
    try {
      // print('sign In again');
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim());
    } on FirebaseAuthException catch (e) {
      Utils.showSnackBar(e.message.toString());
    }
  }
}
