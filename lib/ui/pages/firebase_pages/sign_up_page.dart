import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../widget/utils.dart';

class SignUpPage extends StatelessWidget {
  final VoidCallback onClickedSignUp;
    SignUpPage({super.key, required this.onClickedSignUp});
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final  User? user= FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          decoration: const BoxDecoration(
          image: DecorationImage(
            image: NetworkImage('https://i.pinimg.com/originals/4a/12/f5/4a12f5e4d6c6144946d1a7894dcc1cdf.jpg'),
            fit: BoxFit.cover,
          ),),
          child: Padding(
              padding: const EdgeInsets.all(40),
              child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Welcome to my app",style: TextStyle(fontSize: 20,color: Colors.cyan),),
            const SizedBox(height: 30,),
            Column(
              children: [
                TextFormField(
                  controller: emailController,
                  style:  TextStyle(fontSize: 14, color: Colors.yellow[100]),
                  cursorColor: Colors.white,
                  onFieldSubmitted: (value) {
                    value = emailController.text;
                  },
                  textInputAction: TextInputAction.next,
                  decoration:  InputDecoration(labelText: 'Email',labelStyle: TextStyle(color: Colors.cyan[200])),
                ),
                const SizedBox(
                  height: 4,
                ),
                TextFormField(
                  controller: passwordController,
                  style:  TextStyle(fontSize: 14, color: Colors.yellow[100]),
                  cursorColor: Colors.white,
                  onFieldSubmitted: (value) {
                    value = passwordController.text;
                  },
                  textInputAction: TextInputAction.next,
                  decoration:  InputDecoration(labelText: 'Password',labelStyle: TextStyle(color: Colors.cyan[200])),
                ),
                const SizedBox(height: 4),
                ElevatedButton.icon(
                  onPressed: () {
                    signIn();
                  },
                  icon: const Icon(
                    Icons.lock_open,
                    size: 30,
                  ),
                  label: const Text('Create Account'),
                  style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(50)),
                ),
              ],
            ),
            const SizedBox(height: 8),
            RichText(text:  TextSpan(
              text: 'Already have an account?',
              style: const TextStyle(color: Colors.amber),
              children: [
                const WidgetSpan(child: SizedBox(width: 8,)),
                TextSpan(
                  recognizer: TapGestureRecognizer()..onTap=onClickedSignUp,
                  text: 'Log In',
                  style: const TextStyle(
                    decoration: TextDecoration.underline,
                    fontSize: 16
                  )
                )
              ]
            ))
          ],
              ),
            ),
        ));
  }

  Future signIn() async {
    // showDialog(context: context, 
    // barrierDismissible: false,
    // builder: (context){
    //   return const Center(child: CircularProgressIndicator());
    // });
    final User? user=FirebaseAuth.instance.currentUser;
    if(user !=null && user.emailVerified){
      await user.sendEmailVerification();
    }else {
      try{
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim());
    }
     on FirebaseAuthException catch(e){
      print(e);
      Utils.showSnackBar(e.message.toString());
    }
    }
    
  }
}
