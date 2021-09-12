import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_app/logic/models/user.dart';
import 'package:todo_app/logic/providers/firebase_data.dart';

abstract class UserRepository {
  UserModel login();
  void register(UserModel item);
  const UserRepository();
}

class FirebaseUserRepository {
  FirebaseUserRepository();

  CollectionReference userData =
      FirebaseFirestore.instance.collection('user_data');
  Stream<UserModel> getStreamUserWithId(String id) {
    return FirebaseFirestore.instance
        .collection('user_data')
        .doc(id)
        .snapshots()
        .map(_userDataFromSnapShot);
  }

  Future<List<UserModel>> convertListStringToListUserModel(
      List<String> listStringId) async {
    List<UserModel> returnList = [];
    for (var item in listStringId) {
      await FirebaseFirestore.instance
          .collection('user_data')
          .doc(item)
          .get()
          .then((doc) => {returnList.add(_userDataFromSnapShot(doc))});
    }
    return returnList;
  }

  Future<List<UserModel>> getUserList() async {
    List<UserModel> returnList = [];
    await userData.where('email', isNotEqualTo: '').get().then((doc) => {
          returnList = _userListDataFromSnapShot(doc),
        });
    return returnList;
  }

  Stream<List<UserModel>> getStreamUserList() {
    return userData
        .where('email', isNotEqualTo: FirebaseDataProvider.email)
        .snapshots()
        .map(_userListDataFromSnapShot);
  }

  List<UserModel> _userListDataFromSnapShot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return _userDataFromSnapShot(doc);
    }).toList();
  }

  Future updateUserData(String name, String imgUrl, String uid) async {
    return await userData.doc(uid).set({
      'name': name,
      'imgUrl': imgUrl,
    });
  }

  Stream<UserModel> getUserData(String uid) {
    return userData.doc(uid).snapshots().map(_userDataFromSnapShot);
  }

  UserModel _userDataFromSnapShot(DocumentSnapshot snapshot) {
    try {
      return UserModel(
        name: snapshot['name'],
        id: snapshot.reference.id,
        email: snapshot['email'],
        imgUrl: snapshot['imgUrl'],
      );
    } catch (e) {
      print(e);
      print(snapshot.id);
      return UserModel(
        name: 'faield',
        id: 'failed',
        email: 'failed',
        imgUrl: 'failed',
      );
    }
  }

  List<UserModel> getUserListContainString(
      String searchString, List<UserModel> searchList) {
    List<UserModel>? returnList = [];
    if (searchString != '') {
      for (var item in searchList) {
        if ((item.name.toLowerCase().contains(searchString.toLowerCase())) ||
            (item.email.toLowerCase().contains(searchString.toLowerCase()))) {
          returnList.add(item);
        }
      }
    } else {
      returnList = []..addAll(searchList);
    }
    return returnList;
  }

  Future<String> getCurrentUserEmail() {
    return FirebaseFirestore.instance
        .collection('user_data')
        .doc(FirebaseDataProvider.uid)
        .get()
        .then(_emailFromSnapshot);
  }

  String _emailFromSnapshot(DocumentSnapshot doc) {
    return doc['email'];
  }

  Future changeCurrentUserName(String name) {
    return userData.doc(FirebaseDataProvider.uid).update({
      'name': name,
    });
  }

  Future changeCurrentUserImgUrl(String url) {
    return userData.doc(FirebaseDataProvider.uid).update({
      'imgUrl': url,
    });
  }
}
