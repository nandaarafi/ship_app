
import 'package:firebase_auth/firebase_auth.dart';

class AuthRemoteChangeDataSource {


  Stream<bool> checkEmailVerifiedStream() async* {
    while (true) {
        User? user = FirebaseAuth.instance.currentUser;
        if (user != null) {
          await user.reload();
          user = FirebaseAuth.instance.currentUser;
          yield user!.emailVerified;
          if (user.emailVerified) {
            break;
          }
        } else {
          throw FirebaseAuthException(code: 'user-not-found', message: 'User not found.');
        }
        await Future.delayed(Duration(seconds: 5));

      }

  }

  Future<String> updateEmail(String newEmail) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        await user.verifyBeforeUpdateEmail(newEmail).then((status) => {

        });
      } else {
        throw FirebaseAuthException(code: 'user-not-found', message: 'User not found.');
      }
      return newEmail;
    } catch (e) {
      print("$e : updateEmailFunction");
      throw e; // Throw any exceptions for handling in your UI or bloc/cubit
    }
  }
}