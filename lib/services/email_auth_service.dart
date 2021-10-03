import 'dart:developer';

import 'package:doctorappointmentbookingapp/widgets/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';

class EmailAuth {
  static FirebaseAuth _auth = FirebaseAuth.instance;

  static Future signInUser({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      final result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return result;
    } on FirebaseAuthException catch (e) {
      log('signInUser Exception: $e');
      showSnackBar(text: emailAuthException(e), context: context);
    }
  }

  static Future signUpUser({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      final result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return result;
    } on FirebaseAuthException catch (e) {
      log('signUpUser Exception: $e');
      showSnackBar(text: emailAuthException(e), context: context);
    }
  }

  static String emailAuthException(FirebaseAuthException e) {
    switch (e.code) {
      case 'user-not-found':
        return 'User does not exist with this email';
      case 'wrong-password':
        return 'Wrong password';
      case 'invalid-email':
        return 'Email is invalid';
      case 'email-already-in-use':
        return 'Email already in use';
      case 'weak-password':
        return 'Password entered is too weak.';
      // case 'user-not-found': return 'No user exist with this email';

      default:
        return '';
    }
  }
}
