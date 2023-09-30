import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final firebaseAuthProvider=Provider((ref) => FirebaseAuth.instance);
final streamAuthProvider=StreamProvider<User?>((ref) {
  final authService=ref.watch(firebaseAuthProvider);
  return authService.authStateChanges();
} );