import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

import '../domain/auth_data_model.dart';
import 'auth_remote_data_service.dart';


class AuthService {
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseStorage _storage = FirebaseStorage.instance;

  Future<void> resetPassword(String email) async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: email);
    } catch (e) {
      throw e;
    }
  }

  Future<UserModel> signIn({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      UserModel user =
      await UserService().getUserById(userCredential.user!.uid);
      return user;
    }  catch (e) {
      throw (e);
    }
  }

  Future<UserModel> signUp(
      {required String email,
        required String password,
        required String username,
        required XFile avatarImage,

      }) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      String avatarUrl = await uploadImage(avatarImage);
      UserModel user = UserModel(
        id: userCredential.user!.uid,
        email: email,
        username: username,
        avatarUrl: avatarUrl
      );

      await UserService().setUser(user);

      return user;
    } catch (e) {
      throw (e);
    }
  }



  Future<void> signOut() async {
    try {
      await _auth.signOut();
    }  catch (e) {
      throw (e);
    }
  }

  Future<String> uploadImage(XFile image) async{
    try {
      final ref = FirebaseStorage.instance.ref('Users/Images/Profile/').child(image.name);
      await ref.putFile(File(image.path));
      final url = await ref.getDownloadURL();
      return url;
    } catch (e){
      throw(e);
    }
}



  Future<void> deleteImage(String imageUrl) async {
    try {
      // Get the reference to the file to be deleted
      Reference ref = _storage.refFromURL(imageUrl);

      // Delete the file
      await ref.delete();
    } catch (e) {
      print("Error deleting image: $e");
    }
  }


}