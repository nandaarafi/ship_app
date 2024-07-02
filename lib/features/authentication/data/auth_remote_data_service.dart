import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../domain/auth_data_model.dart';

class UserService {
  CollectionReference _userReference = FirebaseFirestore.instance.collection('users');
  FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> setUser(UserModel user) async {
    try {
      _userReference.doc(user.id).set({
        'email': user.email,
        'username': user.username,
        'avatarUrl': user.avatarUrl
      });
    } catch (e) {
      throw e;
    }
  }

  Future<void> updateUser(UserModel user) async {
    try {
      _userReference.doc(_auth.currentUser!.uid).update({
        // 'email': user.email,
        'username': user.username,
        'avatarUrl': user.avatarUrl
      });
    } catch (e) {
      throw e;
    }
  }

  Future<UserModel> getUserById(String id) async {
    try {
      // FirebaseAuth _auth = FirebaseAuth.instance;
      DocumentSnapshot snapshot = await _userReference.doc(id).get();
      return UserModel(
        id: id,
        email: snapshot['email'],
        username: snapshot['username'],
        avatarUrl: snapshot['avatarUrl'],
      );
    } catch (e) {
      throw e;
    }
  }
}
