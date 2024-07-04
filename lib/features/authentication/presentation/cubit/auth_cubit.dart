import 'package:firebase_auth/firebase_auth.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ship_apps/features/authentication/data/auth_remote_change_data_source.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../home/data/home_firebase_notification_data_source.dart';
import '../../data/auth_remote_data_service.dart';
import '../../data/auth_remote_data_source.dart';
import '../../domain/auth_data_model.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  void resetPassword(String email) async {
    try {
      emit(AuthLoading());
      await AuthService().resetPassword(email); // Implement resetPassword in AuthService
      emit(PasswordResetSent());
    } on FirebaseAuthException catch (e) {
      String errorMessage = CustomExceptions().HandleFirebaseAuthException(e);
      emit(AuthFailed(errorMessage));
    }
  }

  void signInRole({required String email, required String password}) async {
    try {
      emit(AuthLoading());
      UserModel user = await AuthService().signIn(
        email: email,
        password: password,
      );
      final _firebaseMessaging = FirebaseMessaging.instance;
      final fCMToken = await _firebaseMessaging.getToken();
      await HomeFirebaseNotificationDataSource().addFcmTokenToFirestore(token: fCMToken, dateTime: DateTime.now());

      emit(AuthSuccess(user));
    } on FirebaseAuthException catch (e) {
      String errorMessage = CustomExceptions().HandleFirebaseAuthException(e);
      emit(AuthFailed((errorMessage)));
    }
  }

  Future<void> signUp({
    required String email,
    required String password,
    required String username,
    required XFile avatarImage,

  }) async {
    try {
      emit(AuthLoading());

      UserModel user = await AuthService().signUp(
        email: email,
        password: password,
        username: username,
        avatarImage: avatarImage,
      );
      final _firebaseMessaging = FirebaseMessaging.instance;
      final fCMToken = await _firebaseMessaging.getToken();
      await HomeFirebaseNotificationDataSource().addFcmTokenToFirestore(token: fCMToken, dateTime: DateTime.now());

      emit(AuthSuccess(user));
    } on FirebaseAuthException catch (e) {
      String errorMessage = CustomExceptions().HandleFirebaseAuthException(e);

      // If an error occurs during sign-up, emit AuthFailed state with custom error message
      emit(AuthFailed(errorMessage));
    }
  }



  void signOut() async {
    try {
      await AuthService().signOut();
      emit(AuthInitial());
    } catch (e) {
      emit(AuthFailed(e.toString()));
    }
  }

  void getCurrentUser(String id) async {
    try {
      UserModel user = await UserService().getUserById(id);
      emit(AuthSuccess(user));
    } catch (e) {
      emit(AuthFailed(e.toString()));
    }
  }

  Future<void> getInitCurrentUser() async {
    try {
      User? userCred = FirebaseAuth.instance.currentUser;

      UserModel user = await UserService().getUserById(userCred!.uid);
      emit(AuthSuccess(user));
    } catch (e) {
      emit(AuthFailed(e.toString()));
    }
  }

  void updateProfile({
    required String username,
    required String newEmail,
    required String oldAvatarUrl,
    required bool isImageChanged,
    required XFile avatarImage,
  }) async {
    try {
      emit(AuthLoading());
      FirebaseAuth _auth = FirebaseAuth.instance;
      if (isImageChanged) {
        await AuthService().deleteImage(oldAvatarUrl);
        String avatarUrl = await AuthService().uploadImage(avatarImage);
        // String newEmail = await AuthService().updateEmail(email);
        UserModel updatedUser = UserModel(
          id: _auth.currentUser!.uid,
          email: newEmail,
          username: username,
          avatarUrl: avatarUrl,
        );
        await UserService().updateUser(updatedUser);
        emit(AuthSuccess(updatedUser));
      } else {
        // String newEmail = await AuthService().updateEmail(email);
        UserModel updatedUser = UserModel(
          id: _auth.currentUser!.uid,
          email: newEmail,
          username: username,
          avatarUrl: oldAvatarUrl
        );
        await UserService().updateUser(updatedUser);
        emit(AuthSuccess(updatedUser));
      }
    } catch (e) {
      emit(AuthFailed(e.toString()));
    }
  }

//   void updateEmail ({
//     required String email,
// }) async {
//     try{
//       emit(AuthLoading());
//       await AuthRemoteChangeDataSource().updateEmail(email);
//       emit(AuthChangeEmailSuccess());
//     } catch (e){
//       emit(AuthFailed(e.toString()));
//     }
//   }
}
