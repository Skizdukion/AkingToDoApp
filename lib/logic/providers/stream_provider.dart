import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_app/logic/models/project.dart';
import 'package:todo_app/logic/models/quick_note.dart';
import 'package:todo_app/logic/models/task.dart';
import 'package:todo_app/logic/models/user.dart';
import 'package:todo_app/logic/repositories/project_repository.dart';
import 'package:todo_app/logic/repositories/quick_note_repository.dart';
import 'package:todo_app/logic/repositories/task_repository.dart';
import 'package:todo_app/logic/repositories/user_repository.dart';

import 'firebase_data.dart';

class StreamFromFirebase {
  StreamFromFirebase() {
    // init repository
    firebaseProjectRepository = FirebaseProjectRepository();
    firebaseQuickNoteRepository = FirebaseQuickNoteRepository();
    firebaseUserRepository = FirebaseUserRepository();
    firebaseTaskRepository = FirebaseTaskRepository();
    try {
      // profile page
      userLogged = firebaseUserRepository.getUserData(FirebaseDataProvider.uid);
      totalEventCount = firebaseTaskRepository.requestTotalEventCount();
      totalEventDoneCount = firebaseTaskRepository.requestTotalDoneEventCount();
      totalNoDueDateTaskCount =
          firebaseTaskRepository.requestTotalNoDueDateTaskCount();
      totalNoDueDateTaskDoneCount =
          firebaseTaskRepository.requestTotalNoDueDateTaskDoneCount();
      totalTaskCount = firebaseTaskRepository.requestTotalTaskCount();
      totalTaskDoneCount = firebaseTaskRepository.requestTotalDoneTaskCount();
      totalQuickNoteCount =
          firebaseQuickNoteRepository.requestTotalQuickNoteCount();
      // task page
      todayTaskList =
          firebaseTaskRepository.getStreamTaskListForDay(DateTime.now());
      tommorowTaskList = firebaseTaskRepository
          .getStreamTaskListForDay(DateTime.now().add(Duration(days: 1)));
      allTaskList = firebaseTaskRepository.getStreamAllTask();
      // project page
      allProjectList = firebaseProjectRepository.getStreamProjectList();
      // quick note page
      allQuickNoteList = firebaseQuickNoteRepository.getStreamQuickNoteList();

      allUserList = firebaseUserRepository.getStreamUserList();
    } catch (e) {
      print('failed to create stream with error: $e');
    }
  }
  // use in profile page
  late FirebaseProjectRepository firebaseProjectRepository;
  late FirebaseQuickNoteRepository firebaseQuickNoteRepository;
  late FirebaseUserRepository firebaseUserRepository;
  late FirebaseTaskRepository firebaseTaskRepository;
  late Stream<QuerySnapshot> totalEventCount;
  late Stream<QuerySnapshot> totalEventDoneCount;
  late Stream<QuerySnapshot> totalNoDueDateTaskCount;
  late Stream<QuerySnapshot> totalNoDueDateTaskDoneCount;
  late Stream<QuerySnapshot> totalTaskCount;
  late Stream<QuerySnapshot> totalTaskDoneCount;
  late Stream<QuerySnapshot> totalQuickNoteCount;
  late Stream<UserModel> userLogged;
  // use in task page
  late Stream<List<TaskModel>> tommorowTaskList;
  late Stream<List<TaskModel>> todayTaskList;
  late Stream<List<TaskModel>> allTaskList;
  // use in project page
  late Stream<List<ProjectModel>> allProjectList;
  // use in quick note page
  late Stream<List<QuickNoteModel>> allQuickNoteList;

  late Stream<List<UserModel>> allUserList;
}
