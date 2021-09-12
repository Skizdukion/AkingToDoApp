import 'package:equatable/equatable.dart';
import 'package:todo_app/logic/providers/firebase_data.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

class AnonymousUser extends AuthState {
  const AnonymousUser();
}

class AuthLoading extends AuthState {
  const AuthLoading();
}

class LoggeddUser extends AuthState {
  const LoggeddUser({required this.firebaseDataProvider});

  final FirebaseDataProvider firebaseDataProvider;

  @override
  List<Object?> get props => [firebaseDataProvider];
}

class VerifyFailed extends AuthState {
  const VerifyFailed({required this.errorString});

  final String errorString;

  @override
  List<Object?> get props => [errorString];
}
