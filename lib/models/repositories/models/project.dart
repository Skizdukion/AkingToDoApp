import 'package:flutter/material.dart';

class ProjectModel {
  final String title;
  final int totalTask;
  final String id;
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
