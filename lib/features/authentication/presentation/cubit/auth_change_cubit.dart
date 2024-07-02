import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/ui/utils/stream_subscriber_mixin.dart';
import 'package:ship_apps/features/authentication/data/auth_remote_change_data_source.dart';

import '../../../../core/errors/exceptions.dart';

part 'auth_change_state.dart';

class AuthChangeCubit extends Cubit<AuthChangeState> {
  StreamSubscription<bool>? _subscription;

  AuthChangeCubit() : super(AuthChangeInitial());

  Future<void> updateEmail({
    required String newEmail,
}) async {
    try {
      emit(AuthChangeLoading());
      String successEmail = await AuthRemoteChangeDataSource().updateEmail(
          newEmail);
      await AuthRemoteChangeDataSource().updateChangedEmail(newEmail);
      emit(AuthChangeEmailRequestSuccess(successEmail));
    } on FirebaseAuthException catch (e) {
      print("cubit Error");
      String errorMessage = CustomExceptions().HandleFirebaseAuthException(e);
      emit(AuthChangeEmailFailed(errorMessage));
    }
  }

    Future<void> updatePassword({
      required String newPassword,
    }) async {
      try {
        emit(AuthChangeLoading());
        String successPassword = await AuthRemoteChangeDataSource()
            .updatePassword(newPassword);
        emit(AuthChangePasswordSuccess(successPassword));
      } on FirebaseAuthException catch (e) {
        String errorMessage = CustomExceptions().HandleFirebaseAuthException(e);
        emit(AuthChangePasswordFailed(errorMessage));
      }
    }

  // Future<bool> listenForEmailVerification() async {
  //   final completer = Completer<bool>();
  //   _subscription = AuthRemoteChangeDataSource().checkEmailVerifiedStream().listen((isVerified) {
  //     if (isVerified) {
  //       completer.complete(true);
  //       _subscription?.cancel();
  //     }
  //   });
  //   return completer.future;
  // }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
