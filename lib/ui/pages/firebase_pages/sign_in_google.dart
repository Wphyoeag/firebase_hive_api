import 'package:firebase_auth_log_in/providers/google_sign_in_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SignInGoogle extends ConsumerWidget {
  const SignInGoogle({super.key});

  @override
  Widget build(BuildContext context,ref) {
    return ElevatedButton.icon(onPressed: () async {
      await ref.read(googleSignInProviderProvider.notifier).signInWithGoogle();
    }, icon: const FaIcon(FontAwesomeIcons.google), label: const Text('Sign in with google'));
  }
}