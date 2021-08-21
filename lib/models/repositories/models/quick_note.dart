import 'package:flutter/material.dart';

class QuickNoteCheckListItemModel {
  final desc;
  bool isDone;
  final id;
  QuickNoteCheckListItemModel({required this.desc, this.isDone = false, required this.id});
}

class QuickNoteModel{
  final title;
  final color;
  final id;
  List<QuickNoteCheckListItemModel> checkList;
  QuickNoteModel({required this.title, required this.id, required this.checkList, this.color = Colors.black});
}