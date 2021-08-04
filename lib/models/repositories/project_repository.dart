import 'models/project.dart';
import 'package:flutter/material.dart';

List<ProjectModel> fakeDataProject = [
  ProjectModel(title: 'Personal', totalTask: 10, color: Color.fromRGBO(96, 116, 249, 1), projectId: '1'),
  ProjectModel(title: 'Teamworks', totalTask: 10, color: Color.fromRGBO(228, 43, 106, 1), projectId: '2'),
  ProjectModel(title: 'Home', totalTask: 10, color: Color.fromRGBO(90, 187, 86, 1), projectId: '3'),
  ProjectModel(title: 'Meet', totalTask: 10, color: Color.fromRGBO(188, 121, 195, 1), projectId: '4'),
];


abstract class ProjectRepository{
  List<ProjectModel> getPorjectList();
  void deleteProject(String projectId);
  void addProject(ProjectModel item);
  const ProjectRepository();
}

class FakeProjectRepository extends ProjectRepository{
  const FakeProjectRepository();
  static var projectList = fakeDataProject;

  @override
  void addProject(ProjectModel item) {
    projectList.add(item);
  }

  @override
  void deleteProject(String projectId) {
    projectList.remove(getTask(projectId));
  }

  ProjectModel? getTask(String projectId){
    ProjectModel? result;
    fakeDataProject.forEach((val) {
      if(val.projectId == projectId){
        result = val;
      }
    });
    return result;
  }

  @override
  List<ProjectModel> getPorjectList() {
    return projectList;
  }
}