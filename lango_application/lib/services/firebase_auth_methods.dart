import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lango_application/utils/showSnackbar.dart';

class FirebaseAuthMethods {
  final FirebaseAuth _auth;
  FirebaseAuthMethods(this._auth);

  // EMAIL SIGN UP
  Future<void> signUpWithEmail({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      // await sendEmailVerification(context);
    } on FirebaseAuthException catch (e) {
      // if you want to display your own custom error message
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
      showSnackBar(
          context, e.message!); // Displaying the usual firebase error message
    }
  }

//   // EMAIL LOGIN
//   Future<void> loginWithEmail({
//     required String email,
//     required String password,
//     required BuildContext context,
//   }) async {
//     try {
//       await _auth.signInWithEmailAndPassword(
//         email: email,
//         password: password,
//       );
//       if (!user.emailVerified) {
//         await sendEmailVerification(context);
//         // restrict access to certain things using provider
//         // transition to another page instead of home screen
//       }
//     } on FirebaseAuthException catch (e) {
//       showSnackBar(context, e.message!); // Displaying the error message
//     }
//   }

//   // EMAIL VERIFICATION
//   Future<void> sendEmailVerification(BuildContext context) async {
//     try {
//       _auth.currentUser!.sendEmailVerification();
//       showSnackBar(context, 'Email verification sent!');
//     } on FirebaseAuthException catch (e) {
//       showSnackBar(context, e.message!); // Display error message
//     }
//   }

//   // GOOGLE SIGN IN
//   Future<void> signInWithGoogle(BuildContext context) async {
//     try {
//       if (kIsWeb) {
//         GoogleAuthProvider googleProvider = GoogleAuthProvider();

//         googleProvider
//             .addScope('https://www.googleapis.com/auth/contacts.readonly');

//         await _auth.signInWithPopup(googleProvider);
//       } else {
//         final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

//         final GoogleSignInAuthentication? googleAuth =
//             await googleUser?.authentication;

//         if (googleAuth?.accessToken != null && googleAuth?.idToken != null) {
//           // Create a new credential
//           final credential = GoogleAuthProvider.credential(
//             accessToken: googleAuth?.accessToken,
//             idToken: googleAuth?.idToken,
//           );
//           UserCredential userCredential =
//               await _auth.signInWithCredential(credential);

//           // if you want to do specific task like storing information in firestore
//           // only for new users using google sign in (since there are no two options
//           // for google sign in and google sign up, only one as of now),
//           // do the following:

//           // if (userCredential.user != null) {
//           //   if (userCredential.additionalUserInfo!.isNewUser) {}
//           // }
//         }
//       }
//     } on FirebaseAuthException catch (e) {
//       showSnackBar(context, e.message!); // Displaying the error message
//     }
//   }
}