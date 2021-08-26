import 'package:equatable/equatable.dart';
import 'package:todo_app/models/providers/firebase_data.dart';

abstract class AuthState extends Equatable{
  const AuthState();

  @override
  List<Object?> get props => [];
}

class AnonymousUser extends AuthState{
  const AnonymousUser();
}

class AuthLoading extends AuthState{
  const AuthLoading();
}

class LoggeddUser extends AuthState{
  const LoggeddUser({required this.user});

  final FirebaseDataProvider user;

  @override
  List<Object?> get props => [user];
}