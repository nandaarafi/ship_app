import 'package:firebase_auth/firebase_auth.dart';

class CustomExceptions{

  String HandleFirebaseAuthException(FirebaseAuthException e) {
    // Handle specific Firebase Authentication error codes and return custom error messages
    switch (e.code) {
      case 'invalid-credential':
        return 'Wrong Password or Email';
      case 'user-not-found':
        return 'No user found with this email. Please check the email address.';
      case 'too-many-requests':
        return 'Too many request, Please Try Again';
      case 'email-already-in-use':
        return 'The email address is already in use by another account.';
      case 'invalid-email':
        return 'The email address is not valid.';
      case 'weak-password':
        return 'The password is too weak.';
    // Add more cases as needed for other error codes
      default:
        return e.code;
    // return 'An error occurred. Please try again.';
    }
  }
}