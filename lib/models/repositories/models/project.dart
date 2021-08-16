import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class ProjectModel {
  final String title;
  final int totalTask;
  final id;
  final Color color;

  ProjectModel({
    required this.title,
    this.totalTask = 0, 
    required this.id, 
    this.color = Colors.white,
  });

  @override
  String toString() {
    return 'projectid: $id & projectitle: $title';
  }
}
