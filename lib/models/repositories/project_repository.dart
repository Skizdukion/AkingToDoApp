import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
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
  FirebaseProjectRepository(){
    userProjectRef = FirebaseFirestore.instance.collection('project').where('userId', isEqualTo: FirebaseDataProvider.uid);
  }

  late Query userProjectRef;

  Future<List<ProjectModel>> getProjectList() async{
    List<ProjectModel> returnList = [];
    await userProjectRef.get().then((doc) => {
      returnList = _projectListDataFromSnapShot(doc),
    });
    return returnList;
  }

  Stream<ProjectModel> getProjectWithId(String id) {
    return FirebaseFirestore.instance.collection('project').doc(id).snapshots().map(_projectDataFromSnapShot);
  }

  Stream<List<ProjectModel>> getStreamProjectList(){
    return userProjectRef.orderBy('createdDate', descending: false).snapshots().map(_projectListDataFromSnapShot);
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
      totalTask: snapshot['totalTask'],
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

  void updateTotalTask(String id, int num) async{
    FirebaseFirestore.instance.collection('project').doc(id).get().then((value) => {
      _updateTotalTaskWithSnapshot(value, num),
    });
  }

  void _updateTotalTaskWithSnapshot(DocumentSnapshot doc, int num){
    ProjectModel project = _projectDataFromSnapShot(doc);
    project.totalTask += num;
    updateProjectDocument(project);
  }

  void updateProjectDocument(ProjectModel project){
    FirebaseFirestore.instance.collection('project').doc(project.id).update({
      'userId': project.userId,
      'title': project.title,
      'totalTask': project.totalTask,
      'color': converColorToMap(project.color),
    });
  }

  List<ProjectModel> getProjectListContainString(String searchString, List<ProjectModel> searchList){
    List<ProjectModel>? returnList = []; 
    if(searchString != ''){
      for (var item in searchList) {
        if (item.title.toLowerCase().contains(searchString.toLowerCase())){
          returnList.add(item);
        }
      }
    }
    else{ 
      returnList = []..addAll(searchList);
    }
    return returnList;
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