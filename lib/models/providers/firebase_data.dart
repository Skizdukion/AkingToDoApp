import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_app/models/repositories/models/task.dart';
import 'package:todo_app/models/repositories/models/user.dart';

class FireBaseDataProvider{

  FireBaseDataProvider(){
    if (uid != ''){
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

  Future updateUserData(String name, String imgUrl,) async{
    return await userData.doc(uid).set({
      'name': name,
      'imgUrl': imgUrl,
    });
  }

  Stream<UserModel> getUserData(){
    return userData.doc(uid).snapshots().map(_userDataFromSnapShot);
    
  }

  UserModel _userDataFromSnapShot(DocumentSnapshot snapshot){
    return UserModel(
      name: snapshot['name'],
      id: 'id', 
      email: 'email', 
      password: 'password', 
      imgUrl: snapshot['imgUrl'],
    );
  }

  Stream<List<TaskModel>> getTaskList(){
    return userTaskRef.snapshots().map(_taskListDataFromSnapShot);
  }

  List<TaskModel> _taskListDataFromSnapShot(QuerySnapshot snapshot){
    return snapshot.docs.map((doc){
      return _taskDataFromSnapShot(doc);
    }).toList();
  }

  TaskModel _taskDataFromSnapShot(DocumentSnapshot snapshot){
    return TaskModel(
      taskId: snapshot.reference.id, 
      time: DateTime.now(),
      title: snapshot['title'],
      userId: snapshot['userId'],
      dueDate: (snapshot['dueDate'] != null) ? (snapshot['dueDate'] as Timestamp).toDate() : null,
      memberList: List.from(snapshot['memberList']),
      isDone: snapshot['isDone'],
      description: snapshot['description'],
    );
  }
}