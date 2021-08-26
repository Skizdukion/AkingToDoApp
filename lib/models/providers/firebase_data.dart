import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseDataProvider{

  FirebaseDataProvider(){
    if (uid != ''){
      print('initalize firebase proivder with $uid');
      userData = FirebaseFirestore.instance.collection('user_data');
      userTaskRef = FirebaseFirestore.instance.collection('task').where('userId', isEqualTo: uid);
      userProjectRef = FirebaseFirestore.instance.collection('project').where('userId', isEqualTo: uid);
      userQuickNoteRef = FirebaseFirestore.instance.collection('quick_note').where('userId', isEqualTo: uid);
    }
  }
  static String uid = '';
  late CollectionReference userData;
  late Query userTaskRef;
  late Query userProjectRef;
  late Query userQuickNoteRef;
}
