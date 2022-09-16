import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  Future signIn(context, _accountController, _passwordController) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _accountController.text.trim(),
        password: _passwordController.text.trim(),
      );
    } on FirebaseAuthException catch (e) {
      print("FirebaseAuthException: ${e.email}");
    }
    Navigator.pop(context, '/');
  }
}


// class AuthService {
//   handleAuthState() {
//     print("handleAuthState");
//     return StreamBuilder(
//         stream: FirebaseAuth.instance.authStateChanges(),
//         builder: (BuildContext context, snapshot) {
//           if (snapshot.hasData) {
//             return MyApp();
//           } else {
//             return LoginPage();
//           }
//         });
//   }

//   signInWithGoogle() async {
//     print("signInWithGoogle");
//     final GoogleSignInAccount? googleUser =
//         await GoogleSignIn(scopes: <String>['email']).signIn();

//     final GoogleSignInAuthentication googleAuth =
//         await googleUser!.authentication;

//     final credential = GoogleAuthProvider.credential(
//       accessToken: googleAuth.accessToken,
//       idToken: googleAuth.idToken,
//     );
//     return await FirebaseAuth.instance.signInWithCredential(credential);
//   }

//   signOut() {
//     FirebaseAuth.instance.signOut();
//   }
// }
