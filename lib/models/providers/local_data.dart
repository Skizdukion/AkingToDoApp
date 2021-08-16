import 'package:todo_app/models/repositories/models/project.dart';
import 'package:todo_app/models/repositories/models/quick_note.dart';
import 'package:todo_app/models/repositories/models/task.dart';
import 'package:todo_app/models/repositories/models/user.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class LocalDataProvider {
  static final LocalDataProvider _singleton = LocalDataProvider._internal();

  List<UserModel> userList = [
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

  var taskList = [
    TaskModel(taskId: '1', time: DateTime(2021, 8, 1, 9, 30), title: 'Random title No 1', isDone: true),
    TaskModel(taskId: '2', time: DateTime(2021, 8, 1, 11, 30), title: 'Random title No 2'),
    TaskModel(taskId: '3', time: DateTime(2021, 8, 3, 15, 30), title: 'Random title No 3'),
    TaskModel(taskId: '4', time: DateTime(2021, 8, 3, 21, 30), title: 'Random title No 4', isDone: true),
    TaskModel(taskId: '5', time: DateTime(2021, 8, 4, 6, 30), title: 'Random title No 5'),
    TaskModel(taskId: '6', time: DateTime(2021, 8, 5, 7, 30), title: 'Random title No 6', isDone: true),
    TaskModel(taskId: '7', time: DateTime(2021, 8, 6, 15, 30), title: 'Random title No 7'),
    TaskModel(taskId: '8', time: DateTime(2021, 8, 7, 11, 30), title: 'Random title No '),
    TaskModel(taskId: '9', time: DateTime(2021, 8, 10, 20, 30), title: 'Random title No 9'),
    TaskModel(taskId: '10', time: DateTime(2021, 8, 12, 21, 30), title: 'Random title No 10'),
    TaskModel(taskId: '11', time: DateTime(2021, 8, 13, 7, 30), title: 'Random title No 11'),
    TaskModel(taskId: '12', time: DateTime(2021, 8, 14, 9, 30), title: 'Random title No 12', isDone: true),
    TaskModel(taskId: '13', time: DateTime(2021, 8, 14, 10, 30), title: 'Random title No 13'),
    TaskModel(taskId: '14', time: DateTime(2021, 8, 14, 11, 30), title: 'Random title No 14'),
    TaskModel(taskId: '15', time: DateTime(2021, 8, 15, 12, 30), title: 'Random title No 15', isDone: true),
    TaskModel(taskId: '16', time: DateTime(2021, 8, 15, 13, 30), title: 'Random title No 16'),
    TaskModel(taskId: '17', time: DateTime(2021, 8, 16, 19, 30), title: 'Random title No 17'),
    TaskModel(taskId: '1', time: DateTime(2021, 8, 17, 14, 30), title: 'Random title No 1', isDone: true),
    TaskModel(taskId: '19', time: DateTime(2021, 8, 20, 4, 30), title: 'Random title No 19'),
    TaskModel(taskId: '20', time: DateTime(2021, 8, 22, 13, 30), title: 'Random title No 20', isDone: true),
    TaskModel(taskId: '21', time: DateTime(2021, 8, 25, 13, 30), title: 'Random title No 21'),
    TaskModel(taskId: '22', time: DateTime(2021, 8, 27, 13, 30), title: 'Random title No 22'),
    TaskModel(taskId: '23', time: DateTime(2021, 8, 29, 13, 30), title: 'Random title No 23', isDone: true),
    TaskModel(taskId: '24', time: DateTime(2021, 8, 15, 14, 30), title: 'Random title No 24', isDone: true),
    TaskModel(taskId: '25', time: DateTime(2021, 8, 15, 15, 30), title: 'Random title No 25'),
    TaskModel(taskId: '26', time: DateTime(2021, 8, 15, 16, 30), title: 'Random title No 26', isDone: true),
  ];
    
    
  List<QuickNoteModel> quickNoteList = [
    QuickNoteModel(id: '1', color: Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0), title: 'Meeting with Jessica in Central Park at 10:30PM', itemList: [
      QuickNoteCheckListItemModel(desc: 'Math fasfjqw hgafhq gahfhq gashfgqh ghashf', id: '0'),
      QuickNoteCheckListItemModel(desc: 'Chemistry', id: '1'),
      QuickNoteCheckListItemModel(desc: 'Literature', id: '2'),
      QuickNoteCheckListItemModel(desc: 'Physic', id: '3'),
    ]),
    QuickNoteModel(id: '2', color: Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0), title: 'Clean house', itemList: [
      QuickNoteCheckListItemModel(desc: 'Kitchen', id: '1'),
      QuickNoteCheckListItemModel(desc: 'Bath room', id: '2'),
      QuickNoteCheckListItemModel(desc: 'Bed room', id: '3'),
    ]),
    QuickNoteModel(id: '3', color: Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0), title: 'Make dinner', itemList: [
      QuickNoteCheckListItemModel(desc: 'Buy fish', id: '1'),
      QuickNoteCheckListItemModel(desc: 'Make sweetdish meatball', id: '2'),
    ]),
    QuickNoteModel(id: '4', color: Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0), title: 'Random stuff', itemList: [
      QuickNoteCheckListItemModel(desc: 'Random stuff 1', id: '1'),
      QuickNoteCheckListItemModel(desc: 'Random stuff 2', id: '2'),
      QuickNoteCheckListItemModel(desc: 'Random stuff 3', id: '3'),
      QuickNoteCheckListItemModel(desc: 'Random stuff 4', id: '4'),
    ]),
    QuickNoteModel(id: '5', color: Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0), title: 'Random stuff 1', itemList: [
      QuickNoteCheckListItemModel(desc: 'Random stuff 1', id: '1'),
      QuickNoteCheckListItemModel(desc: 'Random stuff 2', id: '2'),
      QuickNoteCheckListItemModel(desc: 'Random stuff 3', id: '3'),
      QuickNoteCheckListItemModel(desc: 'Random stuff 4', id: '4'),
    ]),
    QuickNoteModel(id: '6', color: Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0), title: 'Random stuff 2', itemList: [
      QuickNoteCheckListItemModel(desc: 'Random stuff 1', id: '1'),
      QuickNoteCheckListItemModel(desc: 'Random stuff 2', id: '2'),
      QuickNoteCheckListItemModel(desc: 'Random stuff 3', id: '3'),
      QuickNoteCheckListItemModel(desc: 'Random stuff 4', id: '4'),
    ]),
    QuickNoteModel(id: '7', color: Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0), title: 'Random stuff 3', itemList: [
      QuickNoteCheckListItemModel(desc: 'Random stuff 1', id: '1'),
      QuickNoteCheckListItemModel(desc: 'Random stuff 2', id: '2'),
      QuickNoteCheckListItemModel(desc: 'Random stuff 3', id: '3'),
      QuickNoteCheckListItemModel(desc: 'Random stuff 4', id: '4'),
      QuickNoteCheckListItemModel(desc: 'Random stuff 5', id: '5'),
      QuickNoteCheckListItemModel(desc: 'Random stuff 6', id: '6'),
    ]),
  ];

  List<ProjectModel> projectList = [
    ProjectModel(title: 'Personal', totalTask: 10, color: Color.fromRGBO(96, 116, 249, 1), id: '1'),
    ProjectModel(title: 'Teamworks', totalTask: 10, color: Color.fromRGBO(228, 43, 106, 1), id: '2'),
    ProjectModel(title: 'Home', totalTask: 10, color: Color.fromRGBO(90, 187, 86, 1), id: '3'),
    ProjectModel(title: 'Meet', totalTask: 10, color: Color.fromRGBO(188, 121, 195, 1), id: '4'),
  ];

  factory LocalDataProvider() {
    return _singleton;
  }

  LocalDataProvider._internal();
}