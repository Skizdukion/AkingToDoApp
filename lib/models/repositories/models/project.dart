import 'package:flutter/material.dart';

class ProjectModel {
  final String title;
  final int totalTask;
  final String projectId;
  final Color color;

  ProjectModel({
    required this.title,
    this.totalTask = 0, 
    required this.projectId, 
    this.color = Colors.white,
  });
}
