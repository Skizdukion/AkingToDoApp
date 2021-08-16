import 'package:flutter/material.dart';

class TaskModel {
  final String title;
  final DateTime time;
  final taskId;
  bool isDone;
  final Color barColor;

  TaskModel({
    required this.title,
    required this.time, 
    required this.taskId, 
    this.isDone = false, 
    this.barColor = Colors.white10
  });
}
