
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../widget/utils.dart';

class ForgetPw extends StatefulWidget {
  const ForgetPw({super.key});

  @override
  State<ForgetPw> createState() => _ForgetPwState();
}

class _ForgetPwState extends State<ForgetPw> {
  TextEditingController resetPwController=TextEditingController();
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    resetPwController.clear();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        iconTheme: const IconThemeData(color: Colors.deepPurpleAccent),
        elevation: 0,
        title: const Text('Forget Password',style: TextStyle(color: Colors.deepPurpleAccent),),
      ),
      backgroundColor: Colors.white,
      body:  Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            const SizedBox(height: 12,),
            const Text('Receive an email to send forget pw email',style: TextStyle(color: Colors.green,fontSize: 18),),
            const SizedBox(height: 12,),
            TextFormField(
              controller: resetPwController,
              decoration: const InputDecoration(
                hintText: 'Email',
                
              ),
            ),
            const SizedBox(height: 12,),
            ElevatedButton.icon(onPressed: resetPassword, icon: const Icon(Icons.email), label: const Text('Send reset pw email'))
          ],
        ),
      ),
    );
  }
  Future resetPassword() async {
    try{
      await FirebaseAuth.instance.sendPasswordResetEmail(email: resetPwController.text);
      Utils.showSnackBar("Already send a pw reset email");
      }
    
      on FirebaseAuthException catch(e){
        return Utils.showSnackBar(e.message.toString());
      }


  }
}