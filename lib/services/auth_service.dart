// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// final authserviceProvider=ChangeNotifierProvider((ref) => AuthService());
// class AuthService extends ChangeNotifier{
//    GoogleSignInAccount? googleUser;
//    Future signInWithGoogle() async {
//     final googleSignIn=GoogleSignIn();
//      googleUser=await googleSignIn.signIn();
//     final GoogleSignInAuthentication googleAuthCredential= await googleUser!.authentication;
//     final credential=GoogleAuthProvider.credential(
//       idToken: googleAuthCredential.idToken,
//       accessToken: googleAuthCredential.accessToken
//     );
//     FirebaseAuth.instance.signInWithCredential(credential);
//     notifyListeners();
//   }
//   Future<void> signOutWithGoogle() async {
//     final googleSignIn = GoogleSignIn();

//     try {
//       if(googleUser!=null){
//         await googleSignIn.disconnect();
//         await googleSignIn.signOut();
//       }
//       await FirebaseAuth.instance.signOut();
//       googleUser = null;
//       notifyListeners();
//     } catch (e) {
//       print('Error signing out with Google: $e');
//     }
//     }
// }