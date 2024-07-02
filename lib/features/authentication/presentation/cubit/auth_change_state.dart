part of 'auth_change_cubit.dart';

abstract class AuthChangeState extends Equatable {
  const AuthChangeState();
  @override
  List<Object> get props => [];
}

class AuthChangeInitial extends AuthChangeState {}

class AuthChangeLoading extends AuthChangeState {}

class AuthChangeEmailRequestSuccess extends AuthChangeState {}

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
