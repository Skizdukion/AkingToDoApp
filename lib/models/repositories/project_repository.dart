import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/models/providers/firebase_data.dart';
import 'package:todo_app/models/providers/local_data.dart';
import 'package:uuid/uuid.dart';
import 'models/project.dart';


abstract class ProjectRepository{
  List<ProjectModel> getPorjectList();
  void deleteProject(String projectId);
  void addProject(ProjectModel item);
  const ProjectRepository();
}

class FirebaseProjectRepository{
  const FirebaseProjectRepository();
  static FirebaseDataProvider fireBaseDataProvider =  FirebaseDataProvider();

  Stream<List<ProjectModel>> getStreamProjectList(){
    return fireBaseDataProvider.userProjectRef.orderBy('createdDate', descending: false).snapshots().map(_projectListDataFromSnapShot);
  }

  List<ProjectModel> _projectListDataFromSnapShot(QuerySnapshot snapshot){
    return snapshot.docs.map((doc){
      return _projectDataFromSnapShot(doc);
    }).toList();
  }

  ProjectModel _projectDataFromSnapShot(DocumentSnapshot snapshot){
    return ProjectModel(
      id: snapshot.reference.id, 
      title: snapshot['title'],
      color: _convertMapToColor(snapshot),
      userId: snapshot['userId'],
    );
  }

  Color _convertMapToColor(DocumentSnapshot snapshot){
    Map<String, dynamic> rgbColor = snapshot['color'];
    return Color.fromRGBO(rgbColor['red'], rgbColor['green'], rgbColor['blue'], (rgbColor['opacity'] as num).toDouble());
  }

  Map converColorToMap(Color color){
    Map<String, num> mapColor = {
      'red': color.red,
      'blue': color.blue,
      'green': color.green,
      'opacity': color.opacity,
    };
    return mapColor;
  }

  void addProject(ProjectModel project){
    var uuid = Uuid();
    String randomId = uuid.v4();
    FirebaseFirestore.instance.collection('project').doc(randomId).set({
      'userId': project.userId,
      'title': project.title,
      'totalTask': 0,
      'color': converColorToMap(project.color),
      'createdDate': Timestamp.fromDate(DateTime.now()),
    });
  }
}

class FakeProjectRepository extends ProjectRepository{
  const FakeProjectRepository();
  static var localData = LocalDataProvider();

  @override
  void addProject(ProjectModel item) {
    localData.projectList.add(item);
  }

  @override
  void deleteProject(String projectId) {
    localData.projectList.remove(getProjectWithId(projectId));
  }

  ProjectModel? getProjectWithId(String projectId){
    ProjectModel? result;
    localData.projectList.forEach((val) {
      if(val.id == projectId){
        result = val;
      }
    });
    return result;
  }

  @override
  List<ProjectModel> getPorjectList() {
    return localData.projectList;
  }

  List<ProjectModel> getProjectListContainString(String searchString){
    List<ProjectModel>? tempList = []; 
    if(searchString != ''){
      for (var item in localData.projectList) {
        if (item.title.toLowerCase().contains(searchString.toLowerCase())){
          tempList.add(item);
        }
      }
    }
    else{ 
      tempList = []..addAll(localData.projectList);
    }
    return tempList;
  }
}