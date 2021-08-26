import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_app/models/providers/firebase_data.dart';
import 'package:todo_app/models/providers/local_data.dart';
import 'models/user.dart';


abstract class UserRepository {
  UserModel login();
  void register(UserModel item);
  const UserRepository();
}

class FirebaseUserRepository{
  
  FirebaseUserRepository(){
    userData = FirebaseFirestore.instance.collection('user_data');
  }

  late CollectionReference userData;
  Stream<UserModel> getUserWithId(String id) {
    return FirebaseFirestore.instance.collection('user_data').doc(id).snapshots().map(_userDataFromSnapShot);
  }

  Future<List<UserModel>> getUserList() async{
    List<UserModel> returnList = [];
    await userData.get().then((doc) => {
      returnList = _userListDataFromSnapShot(doc),
    });
    return returnList;
  }

  Stream<List<UserModel>> getStreamUserList(){
    return userData.snapshots().map(_userListDataFromSnapShot);
  }

  List<UserModel> _userListDataFromSnapShot(QuerySnapshot snapshot){
    return snapshot.docs.map((doc){
      return _userDataFromSnapShot(doc);
    }).toList();
  }

  Future updateUserData(String name, String imgUrl, String uid) async{
    return await userData.doc(uid).set({
      'name': name,
      'imgUrl': imgUrl,
    });
  }

  Stream<UserModel> getUserData(String uid){
    return userData.doc(uid).snapshots().map(_userDataFromSnapShot);
  }

  UserModel _userDataFromSnapShot(DocumentSnapshot snapshot){
    try{
      return UserModel(
        name: snapshot['name'],
        id: snapshot.reference.id, 
        email: snapshot['email'], 
        imgUrl: snapshot['imgUrl'],
      );
    }
    catch (e) {
      print(e);
      print(snapshot.id);
      return  UserModel(
        name: 'faield',
        id: 'failed', 
        email: 'failed', 
      );
    }
  }

  List<UserModel> getUserListContainString(String searchString, List<UserModel> searchList){
    List<UserModel>? returnList = []; 
    if(searchString != ''){
      for (var item in searchList) {
        if ((item.name.toLowerCase().contains(searchString.toLowerCase()))||(item.email.toLowerCase().contains(searchString.toLowerCase()))){
          returnList.add(item);
        }
      }
    }
    else{ 
      returnList = []..addAll(searchList);
    }
    return returnList;
  }
}

class FakeUserRepository extends UserRepository{
  const FakeUserRepository();
  static var localData = LocalDataProvider();


  @override
  UserModel login() {
    // do stuff here
    throw UnimplementedError();
  }

  @override
  void register(item) {
    // do it later
  }

  List<UserModel> getUserList(){
    return localData.userList;
  }

  List<UserModel> getUserListContainString(String searchString){
    List<UserModel>? tempList = []; 
    if(searchString != ''){
      for (var item in FakeUserRepository.localData.userList) {
        if (item.name.toLowerCase().contains(searchString.toLowerCase())){
          tempList.add(item);
        }
      }
    }
    else{ 
      tempList = []..addAll(localData.userList);
    }
    return tempList;
  }

  UserModel? getUserWithId(String id){
    UserModel? result;
    localData.userList.forEach((val) {
      if(val.id == id){
        result = val;
      }
    });
    if (result == null) print('wrong with data');
    return result;
  }


}