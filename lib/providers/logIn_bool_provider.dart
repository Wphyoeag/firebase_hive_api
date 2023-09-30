import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../ui/widget/utils.dart';

final logInBoolProvider = ChangeNotifierProvider((ref) => SignInSignUpNotifier());
class SignInSignUpNotifier extends ChangeNotifier{
  bool isSignUp=true;
  void toggle(){
    isSignUp = !isSignUp;
    notifyListeners();
  }
}
final emailVerifiedProvider =
    StateNotifierProvider.autoDispose<EmailVerifiedNotifier, bool>((ref) =>
        EmailVerifiedNotifier(
            FirebaseAuth.instance.currentUser?.emailVerified ?? false));

class EmailVerifiedNotifier extends StateNotifier<bool> {
  EmailVerifiedNotifier(super.state) {
    if (!state) {
      sendVerification();
      _timer = Timer.periodic(
          const Duration(seconds: 3), (_) => checkVerifiedEmail());
      checkEmail();
    }
  }
  Timer? _timer;
  checkEmail() async {}
  Future checkVerifiedEmail() async {
    await FirebaseAuth.instance.currentUser?.reload();
    bool verified = FirebaseAuth.instance.currentUser?.emailVerified ?? false;
    if (verified) {
      state = verified;
    }
    if (state) {
      _timer?.cancel();
    }
  }

  Future<void> cancell() async {
    await FirebaseAuth.instance.currentUser?.delete();
    _timer?.cancel();
  }

  @override
  dispose() {
    _timer?.cancel();
    super.dispose();
  }

  sendVerification() async {
    try {
      await FirebaseAuth.instance.currentUser?.sendEmailVerification();
    } on FirebaseAuthException catch (e) {
      Utils.showSnackBar(e.message.toString());
    }
  }
}
