part of 'auth_change_cubit.dart';

abstract class AuthChangeState extends Equatable {
  const AuthChangeState();
  @override
  List<Object> get props => [];
}

class AuthChangeInitial extends AuthChangeState {}

class AuthChangeLoading extends AuthChangeState {}

class AuthChangeEmailRequestSuccess extends AuthChangeState {
  final String newEmail;
  AuthChangeEmailRequestSuccess(this.newEmail);

  @override
  List<Object> get props => [newEmail];
}

class AuthChangePasswordSuccess extends AuthChangeState {
  final String newPassword;
  AuthChangePasswordSuccess(this.newPassword);

  @override
  List<Object> get props => [newPassword];
}

class AuthChangeEmailSuccess extends AuthChangeState {
  final bool isVerified;

  AuthChangeEmailSuccess(this.isVerified);
  @override
  List<Object> get props => [isVerified];
}

class AuthChangeEmailFailed extends AuthChangeState {
  final String error;
  AuthChangeEmailFailed(this.error);

  @override
  List<Object> get props => [error];
}

class AuthChangePasswordFailed extends AuthChangeState {
  final String error;
  AuthChangePasswordFailed(this.error);

  @override
  List<Object> get props => [error];
}

class AuthUpdateEmailFirestore extends AuthChangeState{}
