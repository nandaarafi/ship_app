import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final String id;
  final String? email;
  final String username;
  final String? avatarUrl;


  UserModel({
    required this.id,
    this.email,
    required this.username,
    this.avatarUrl,
  });

  @override
  List<Object?> get props => [id, email, username, avatarUrl];
}