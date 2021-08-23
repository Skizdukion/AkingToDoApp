import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/models/blocs/auth/auth_event.dart';
import 'package:todo_app/models/blocs/auth/auth_state.dart';
import 'package:todo_app/models/providers/firebase_data.dart';
import 'package:todo_app/models/repositories/auth_repository.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState>{
  AuthBloc() : super(AnonymousUser());
  final FireBaseAuthRepository _fireBaseAuthRepository = FireBaseAuthRepository();

  @override
  void onTransition(Transition<AuthEvent, AuthState> transition) {
    super.onTransition(transition);
  }

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async*{
    if (event is Login){
      yield AuthLoading();
      var user = await _fireBaseAuthRepository.signInWithEmail(event.email, event.password);
      print(user);
      if (user != null){
        FireBaseDataProvider.uid = user;
        yield LoginedUser(user: FireBaseDataProvider());
      }
      else yield AnonymousUser();
    }
    if (event is Register){
      yield AuthLoading();
      var user = await _fireBaseAuthRepository.registerWithEmail(event.email, event.password);
      print(user);
      if (user != null){
        yield LoginedUser(user: user);
      }
      else yield AnonymousUser();
    }
  }
}