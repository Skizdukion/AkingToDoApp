import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthRepository{

}

class FireBaseAuthRepository extends AuthRepository{
  final FirebaseAuth  _firebaseAuth = FirebaseAuth.instance;

  Future signInWithEmail(String email, String password) async {
    try{
      UserCredential result = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      User? user = result.user;
      return _userIdFromFirebase(user);
    }
    catch(e) {
      print(e);
    }
  }

  Future registerWithEmail(String email, String password) async{
    try{
      UserCredential result = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
      User? user = result.user;
      return _userIdFromFirebase(user);
    }
    catch (e){
      print(e);
      return null;
    }
  }

  String? _userIdFromFirebase(User? user){
    if (user != null) {
      return user.uid;
    } else {
      return 'Failed';
    }
  }

}
