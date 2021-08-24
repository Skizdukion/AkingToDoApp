import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_app/models/providers/firebase_data.dart';
import 'package:todo_app/models/providers/local_data.dart';
import 'package:uuid/uuid.dart';

import 'models/task.dart';


abstract class TaskRepository{
  List<TaskModel> getTaskListForRange(String userID, DateTime startTime, DateTime endTime);
  List<TaskModel> getTaskListForDay(String userID, DateTime date);
  bool changeTaskDoneState(String taskId);
  void deleteTask(String taskId);
  const TaskRepository();
}

class FirebaseTaskRepository{
  const FirebaseTaskRepository();

  static int getTaskType = 2;
  static FirebaseDataProvider fireBaseDataProvider =  FirebaseDataProvider();

  Stream<List<TaskModel>> getStreamTaskListForRange(DateTime startTime, DateTime endTime){
    Timestamp startTimestamp = Timestamp.fromDate(startTime);
    Timestamp endTimestamp = Timestamp.fromDate(endTime);
    return fireBaseDataProvider.userTaskRef.where('dueDate', isGreaterThanOrEqualTo: startTimestamp, isLessThanOrEqualTo: endTimestamp).snapshots().map(_taskListDataFromSnapShot);
  }
  
  Stream<List<TaskModel>> getStreamTaskListForDay(DateTime dateTime){
    DateTime startOfDate = DateTime(dateTime.year, dateTime.month, dateTime.day, 0, 0);
    DateTime endOfDate = DateTime(dateTime.year, dateTime.month, dateTime.day, 23, 59);
    return getStreamTaskListForRange(startOfDate, endOfDate);
  }

  Stream<List<TaskModel>> getStreamAllTask(){
    return fireBaseDataProvider.userTaskRef.snapshots().map(_taskListDataFromSnapShot);
  }

  Future<List<TaskModel>> getTaskList(Stream<List<TaskModel>> streamList) async{
    return streamList.first;
  }

  List<TaskModel> _taskListDataFromSnapShot(QuerySnapshot snapshot){
    return snapshot.docs.map((doc){
      return _taskDataFromSnapShot(doc);
    }).toList();
  }

  TaskModel _taskDataFromSnapShot(DocumentSnapshot snapshot){
    return TaskModel(
      taskId: snapshot.reference.id, 
      time: (snapshot['createdDate'] as Timestamp).toDate(),
      title: snapshot['title'],
      userId: snapshot['userId'],
      dueDate: (snapshot['dueDate'] != null) ? (snapshot['dueDate'] as Timestamp).toDate() : null,
      memberList: List.from(snapshot['memberList']),
      projectList: List.from(snapshot['projectList']),
      isDone: snapshot['isDone'],
      description: snapshot['description'],
    );
  }

  void addNewTask(TaskModel task){
    var uuid = Uuid();
    String randomId = uuid.v4();
    FirebaseFirestore.instance.collection('task').doc(randomId).set({
      'createdDate': Timestamp.fromDate(DateTime.now()),
      'description': task.description,
      'dueDate': (task.dueDate == null) ? null : Timestamp.fromDate(task.dueDate!),
      'isDone': task.isDone,
      'title': task.title,
      'userId': task.userId,
      'memberList': task.memberList,
      'projectList': task.projectList,
    });
  }

  void changeDoneState(TaskModel task){
    FirebaseFirestore.instance.collection('task').doc(task.taskId).update({
      'createdDate': Timestamp.fromDate(task.time),
      'description': task.description,
      'dueDate': (task.dueDate == null) ? null : Timestamp.fromDate(task.dueDate!),
      'isDone': !task.isDone,
      'title': task.title,
      'userId': task.userId,
      'memberList': task.memberList,
      'projectList': task.projectList,
    });
  }

  void deleteTask(String id){
    FirebaseFirestore.instance.collection('task').doc(id).delete();
  }
}

class FakeTaskRepository extends TaskRepository{
  const FakeTaskRepository();
  static var localData = LocalDataProvider();
  static int getTaskType = 2;

  @override
  List<TaskModel> getTaskListForRange(String userID, DateTime startTime, DateTime endTime) {
    List<TaskModel> returnList = [];
    localData.taskList.forEach((val) {
      if(val.time.isAfter(startTime)&&val.time.isBefore(endTime)) {
        if (getTaskType == 2) returnList.add(val);
        if ((getTaskType == 1)&&(val.isDone == true)) returnList.add(val);
        if ((getTaskType == 0)&&(val.isDone == false)) returnList.add(val);
      }
    });
    return returnList;
  }

  @override
  List<TaskModel> getTaskListForDay(String userID, DateTime date) {
    List<TaskModel> returnList = [];
    localData.taskList.forEach((val) {
      if((val.time.day == date.day)&&(val.time.month == date.month)&&(val.time.year == date.year)) {
        if (getTaskType == 2) returnList.add(val);
        if ((getTaskType == 1)&&(val.isDone == true)) returnList.add(val);
        if ((getTaskType == 0)&&(val.isDone == false)) returnList.add(val);
      }
    });
    return returnList;
  }

  @override
  bool changeTaskDoneState(String taskId){
    bool result = false;
    localData.taskList.forEach((val) {
      if(val.taskId == taskId){
        val.isDone = !val.isDone;
        result = true;
      }
    });
    return result;
  }

  @override
  void deleteTask(String taskId) {
    localData.taskList.remove(getTask(taskId));
  }

  TaskModel? getTask(String taskId){
    TaskModel? result;
    localData.taskList.forEach((val) {
      if(val.taskId == taskId){
        result = val;
      }
    });
    return result;
  }

  void addTask(TaskModel item){
    localData.taskList.add(item);
  }

  int getLength(){
    return localData.taskList.length;
  }

  void changeGetTaskType(int val){
    getTaskType = val;
  }
}