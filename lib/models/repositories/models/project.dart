import 'package:flutter/material.dart';

class ProjectModel {
  final String title;
  int totalTask;
  final id;
  final Color color;
  final userId;

  ProjectModel({
    required this.title,
    this.totalTask = 0,
    required this.id,
    this.color = Colors.white,
    required this.userId,
  });

  @override
  String toString() {
    return 'projectid: $id & projectitle: $title';
  }
}
