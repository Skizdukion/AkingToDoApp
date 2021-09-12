import 'package:flutter/material.dart';

class QuickNoteCheckListItemModel {
  String listTitle;
  bool isDone;
  final id;
  QuickNoteCheckListItemModel(
      {required this.listTitle, this.isDone = false, required this.id});
}

class QuickNoteModel {
  final title;
  final color;
  final id;
  final userId;
  List<QuickNoteCheckListItemModel> checkList;
  QuickNoteModel(
      {required this.title,
      required this.id,
      required this.checkList,
      this.color = Colors.black,
      required this.userId});
}
