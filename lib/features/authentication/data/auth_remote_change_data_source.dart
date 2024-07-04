
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../domain/auth_data_model.dart';

class AuthRemoteChangeDataSource {
  CollectionReference _userReference = FirebaseFirestore.instance.collection('users');
  FirebaseAuth _auth = FirebaseAuth.instance;


  // Stream<bool> checkEmailVerifiedStream() async* {
  //   while (true) {
  //       User? user = FirebaseAuth.instance.currentUser;
  //       if (user != null) {
  //         await user.reload();
  //         user = FirebaseAuth.instance.currentUser;
  //         yield user!.emailVerified;
  //         if (user.emailVerified) {
  //           break;
  //         }
  //       } else {
  //         throw FirebaseAuthException(code: 'user-not-found', message: 'User not found.');
  //       }
  //       await Future.delayed(Duration(seconds: 5));
  //     }
  // }

  Future<String> updateEmail(String newEmail) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        await user.updateEmail(newEmail);
      } else {
        throw FirebaseAuthException(code: 'user-not-found', message: 'User not found.');
      }
      return newEmail; // Return the new email on success
    } catch (e) {
      print("updateEmailFunctionError : $e  ");
      throw e; // Throw any exceptions for handling in your UI or bloc/cubit
    }
  }

  Future<String> updatePassword(String newPassword) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        await user.updatePassword(newPassword);
      } else {
        throw FirebaseAuthException(code: 'user-not-found', message: 'User not found.');
      }
      return newPassword; // Return the new email on success
    } catch (e) {
      print("updatePasswordFunctionError : $e  ");
      throw e; // Throw any exceptions for handling in your UI or bloc/cubit
    }
  }

  Future<void> updateChangedEmail(String newEmail) async {
    try {
      _userReference.doc(_auth.currentUser!.uid).update({
        'email': newEmail,
      });
    } catch (e) {
      throw e;
    }
  }
}