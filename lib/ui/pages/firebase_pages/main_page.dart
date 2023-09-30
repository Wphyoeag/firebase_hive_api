import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_log_in/ui/pages/firebase_pages/verified_email_page.dart';
import 'package:flutter/material.dart';

import 'auth_page.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if(snapshot.hasData){
            if(snapshot.connectionState==ConnectionState.waiting){
              return const CircularProgressIndicator();
            } else if(snapshot.hasError){
              return const Text("Error");
            }
            return const VerifiedEmailPage();
          } else {
            return const AuthPage();
          }
        }
      ),
    );
  }
}