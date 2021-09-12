import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_app/logic/models/task.dart';
import 'package:todo_app/logic/providers/firebase_data.dart';
import 'package:todo_app/logic/repositories/project_repository.dart';
import 'package:uuid/uuid.dart';

abstract class TaskRepository {
  List<TaskModel> getTaskListForRange(
      String userID, DateTime startTime, DateTime endTime);
  List<TaskModel> getTaskListForDay(String userID, DateTime date);
  bool changeTaskDoneState(String taskId);
  void deleteTask(String taskId);
  const TaskRepository();
}

class FirebaseTaskRepository {
  FirebaseTaskRepository() {
    if (getTaskType == 0)
      userTaskRef = FirebaseFirestore.instance
          .collection('task')
          .where('userId', isEqualTo: FirebaseDataProvider.uid)
          .where('isDone', isEqualTo: false);
    if (getTaskType == 1)
      userTaskRef = FirebaseFirestore.instance
          .collection('task')
          .where('userId', isEqualTo: FirebaseDataProvider.uid)
          .where('isDone', isEqualTo: true);
    if (getTaskType == 2)
      userTaskRef = FirebaseFirestore.instance
          .collection('task')
          .where('userId', isEqualTo: FirebaseDataProvider.uid);
  }

  late Query userTaskRef;

  static int getTaskType = 2;
  static FirebaseDataProvider fireBaseDataProvider = FirebaseDataProvider();

  Stream<TaskModel> getStreamTaskWithId(String id) {
    return FirebaseFirestore.instance
        .collection('task')
        .doc(id)
        .snapshots()
        .map((event) => _taskDataFromSnapShot(event));
  }

  Stream<QuerySnapshot> requestTotalTaskCount() {
    return userTaskRef.snapshots();
  }

  Stream<QuerySnapshot> requestTotalDoneTaskCount() {
    return userTaskRef.where('isDone', isEqualTo: true).snapshots();
  }

  Stream<QuerySnapshot> requestTotalUnDoneTaskCount() {
    return userTaskRef.where('isDone', isEqualTo: false).snapshots();
  }

  Stream<QuerySnapshot> requestTotalEventCount() {
    return userTaskRef.where('isEvent', isEqualTo: true).snapshots();
  }

  Stream<QuerySnapshot> requestTotalDoneEventCount() {
    return userTaskRef
        .where('isDone', isEqualTo: true)
        .where('isEvent', isEqualTo: true)
        .snapshots();
  }

  Stream<QuerySnapshot> requestTotalNoDueDateTaskCount() {
    return userTaskRef.where('isEvent', isEqualTo: false).snapshots();
  }

  Stream<QuerySnapshot> requestTotalNoDueDateTaskDoneCount() {
    return userTaskRef
        .where('isDone', isEqualTo: true)
        .where('isEvent', isEqualTo: false)
        .snapshots();
  }

  Stream<List<TaskModel>> getStreamTaskListForRange(
      DateTime startTime, DateTime endTime) {
    Timestamp startTimestamp = Timestamp.fromDate(startTime);
    Timestamp endTimestamp = Timestamp.fromDate(endTime);
    return userTaskRef
        .where('dueDate',
            isGreaterThanOrEqualTo: startTimestamp,
            isLessThanOrEqualTo: endTimestamp)
        .snapshots()
        .map(_taskListDataFromSnapShot);
  }

  Stream<List<TaskModel>> getStreamTaskListForDay(DateTime dateTime) {
    DateTime startOfDate =
        DateTime(dateTime.year, dateTime.month, dateTime.day, 0, 0);
    DateTime endOfDate =
        DateTime(dateTime.year, dateTime.month, dateTime.day, 23, 59);
    return getStreamTaskListForRange(startOfDate, endOfDate);
  }

  Stream<List<TaskModel>> getStreamAllTask() {
    return requestTotalTaskCount().map(_taskListDataFromSnapShot);
  }

  List<TaskModel> _taskListDataFromSnapShot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return _taskDataFromSnapShot(doc);
    }).toList();
  }

  TaskModel _taskDataFromSnapShot(DocumentSnapshot snapshot) {
    return TaskModel(
      taskId: snapshot.reference.id,
      time: (snapshot['createdDate'] as Timestamp).toDate(),
      title: snapshot['title'],
      userId: snapshot['userId'],
      dueDate: (snapshot['dueDate'] != null)
          ? (snapshot['dueDate'] as Timestamp).toDate()
          : null,
      memberList: List.from(snapshot['memberList']),
      projectList: List.from(snapshot['projectList']),
      isDone: snapshot['isDone'],
      description: snapshot['description'],
      isEvent: snapshot['isEvent'],
    );
  }

  Future addNewTask(TaskModel task) async {
    var uuid = Uuid();
    String randomId = uuid.v4();
    for (var item in task.projectList) {
      FirebaseProjectRepository().updateTotalTask(item, 1);
    }
    await FirebaseFirestore.instance.collection('task').doc(randomId).set({
      'createdDate': Timestamp.fromDate(DateTime.now()),
      'description': task.description,
      'dueDate':
          (task.dueDate == null) ? null : Timestamp.fromDate(task.dueDate!),
      'isDone': task.isDone,
      'title': task.title,
      'userId': task.userId,
      'memberList': task.memberList,
      'projectList': task.projectList,
      'isEvent': task.isEvent,
    });
  }

  Future updateDoneState(TaskModel task) async {
    await FirebaseFirestore.instance
        .collection('task')
        .doc(task.taskId)
        .update({
      'isDone': !task.isDone,
    });
  }

  Future deleteTask(String id) async {
    await FirebaseFirestore.instance
        .collection('task')
        .doc(id)
        .get()
        .then((value) => _changeTotalTaskInProject(value));
    FirebaseFirestore.instance.collection('task').doc(id).delete();
  }

  Future updateMemberListInTaskId(String id, List<String> memberList) async {
    await FirebaseFirestore.instance.collection('task').doc(id).update({
      'memberList': memberList,
    });
  }

  Future updateProjectListInTaskId(String id, List<String> projectList) async {
    await FirebaseFirestore.instance.collection('task').doc(id).update({
      'projectList': projectList,
    });
  }

  void _changeTotalTaskInProject(DocumentSnapshot doc) {
    List projectList = doc['projectList'];
    for (var item in projectList) {
      FirebaseProjectRepository().updateTotalTask(item, -1);
    }
  }
}
