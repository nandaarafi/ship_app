import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_database/ui/utils/stream_subscriber_mixin.dart';
import 'package:ship_apps/features/authentication/data/auth_remote_change_data_source.dart';

part 'auth_change_state.dart';

class AuthChangeCubit extends Cubit<AuthChangeState> {
  StreamSubscription<bool>? _subscription;

  AuthChangeCubit() : super(AuthChangeInitial());

  Future<void> updateEmail({
    required String newEmail,
}) async {
    // String newEmail = _emailController.text.trim();
    try {
      emit(AuthChangeLoading());
      await AuthRemoteChangeDataSource().updateEmail(newEmail);
      emit(AuthChangeEmailRequestSuccess());
      // Start listening to the verification status
      bool isVerified = await listenForEmailVerification();
      emit(AuthChangeEmailSuccess(isVerified));
    } catch (e) {
      emit(AuthChangeEmailFailed(e.toString()));
    }
  }

  Future<bool> listenForEmailVerification() async {
    final completer = Completer<bool>();
    _subscription = AuthRemoteChangeDataSource().checkEmailVerifiedStream().listen((isVerified) {
      if (isVerified) {
        completer.complete(true);
        _subscription?.cancel();
      }
    });
    return completer.future;
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
