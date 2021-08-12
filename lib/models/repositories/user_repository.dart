import 'package:todo_app/models/repositories/task_repository.dart';

import 'models/user.dart';
import 'package:flutter/material.dart';

List<UserModel> fakeUserData = [
  UserModel(email: 'sample1@gmail.com', password: '1234', name: 'Hieu Vo', id: '1'),
  UserModel(email: 'sample2@gmail.com', password: '1234', name: 'Khang Le', id: '2'),
  UserModel(email: 'sample3@gmail.com', password: '1234', name: 'Long Pham', id: '3'),
  UserModel(email: 'sample4@gmail.com', password: '1234', name: 'Truong Vo', id: '4'),
  UserModel(email: 'sample5@gmail.com', password: '1234', name: 'Trong Lam', id: '5'),
  UserModel(email: 'sample6@gmail.com', password: '1234', name: 'Nhan Phan', id: '6'),
  UserModel(email: 'sample7@gmail.com', password: '1234', name: 'Khuong Dao', id: '7'),
  UserModel(email: 'sample8@gmail.com', password: '1234', name: 'Phuong Ha', id: '8'),
  UserModel(email: 'sample9@gmail.com', password: '1234', name: 'Trieu Duong', id: '9'),
];

abstract class UserRepository {
  UserModel login();
  void register(UserModel item);
  const UserRepository();
}

class FakeUserRepository extends UserRepository{
  const FakeUserRepository();

  static List<UserModel> userList = fakeUserData;
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
    return userList;
  }

  UserModel? getUserWithId(String id){
    UserModel? result;
    userList.forEach((val) {
      if(val.id == id){
        result = val;
      }
    });
    return result;
  }
}