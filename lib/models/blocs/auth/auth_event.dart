import 'package:equatable/equatable.dart';
import 'package:todo_app/models/repositories/models/user.dart';

abstract class AuthEvent extends Equatable{
  const AuthEvent();

  @override
  List<Object?> get props => [];

  @override
  bool get stringify => true;
}

class Login extends AuthEvent{
  const Login({required this.email, required this.password});
  final email;
  final password;

  @override
  List<Object> get props => [email,password];
}

class Register extends AuthEvent{
  const Register({required this.email, required this.password});
  final email;
  final password;

  @override
  List<Object> get props => [email,password];
}

class Loading extends AuthEvent{
  const Loading();
}

class Logout extends AuthEvent{
  const Logout();
}

