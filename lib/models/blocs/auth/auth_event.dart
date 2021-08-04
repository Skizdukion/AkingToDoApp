import 'package:equatable/equatable.dart';
import 'package:todo_app/models/repositories/models/user.dart';

abstract class AuthEvent extends Equatable{
  const AuthEvent();

  @override
  List<Object?> get props => [];

  @override
  bool get stringify => true;
}

class AuthVerifyLogin extends AuthEvent{
  const AuthVerifyLogin({required this.email, required this.password});

  final email;
  final password;

  @override
  List<Object> get props => [email,password];
}

class AuthLoginSuccess extends AuthEvent{
  const AuthLoginSuccess({required this.user});

  final UserModel user;

  @override
  List<Object> get props => [user];
}

class AuthLogout extends AuthEvent{
  const AuthLogout();
}