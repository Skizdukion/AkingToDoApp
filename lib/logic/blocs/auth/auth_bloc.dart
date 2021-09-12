import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/global/error/auth_string_error.dart';
import 'package:todo_app/logic/providers/firebase_data.dart';
import 'package:todo_app/logic/repositories/auth_repository.dart';
import 'package:todo_app/logic/repositories/user_repository.dart';
import 'package:todo_app/logic/utils/extension/string_extension.dart';

import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AnonymousUser());
  final FireBaseAuthRepository _fireBaseAuthRepository =
      FireBaseAuthRepository();

  @override
  void onTransition(Transition<AuthEvent, AuthState> transition) {
    super.onTransition(transition);
    print(transition);
  }

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    if (event is Login) {
      yield AuthLoading();
      if (event.email.isEmpty) {
        yield VerifyFailed(errorString: ErrorAuthString.emptyEmailAddress);
        yield AnonymousUser();
      } else if (!event.email.isValidEmail()) {
        yield VerifyFailed(errorString: ErrorAuthString.unvalidEmailAddress);
        yield AnonymousUser();
      } else if (event.password.isEmpty) {
        yield VerifyFailed(errorString: ErrorAuthString.emptyPassword);
        yield AnonymousUser();
      } else if (event.password.length < 6) {
        yield VerifyFailed(
            errorString: ErrorAuthString.notEnoughPasswordLength);
        yield AnonymousUser();
      } else {
        try {
          UserCredential userCredential =
              await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: event.email,
            password: event.password,
          );
          if (userCredential.user != null) {
            FirebaseDataProvider.uid = userCredential.user!.uid;
            FirebaseDataProvider.email =
                await FirebaseUserRepository().getCurrentUserEmail();
            yield LoggeddUser(firebaseDataProvider: new FirebaseDataProvider());
          }
        } on FirebaseAuthException catch (e) {
          yield VerifyFailed(errorString: e.code);
          yield AnonymousUser();
        } on Exception catch (e) {
          yield VerifyFailed(errorString: e.toString());
          yield AnonymousUser();
        }
      }
    }
    // if (event is Register) {
    //   yield AuthLoading();
    //   var user = await _fireBaseAuthRepository.registerWithEmail(
    //       event.email, event.password);
    //   if (user != null) {
    //     yield LoggeddUser(user: user);
    //   } else
    //     yield AnonymousUser();
    // }
    if (event is Logout) {
      _fireBaseAuthRepository.signOut();
      FirebaseDataProvider.uid = '';
      FirebaseDataProvider.email = '';
      yield AnonymousUser();
    }
  }
}
