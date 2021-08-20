import 'package:todo_app/models/providers/local_data.dart';
import 'package:todo_app/models/repositories/task_repository.dart';

import 'models/user.dart';
import 'package:flutter/material.dart';


abstract class UserRepository {
  UserModel login();
  void register(UserModel item);
  const UserRepository();
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