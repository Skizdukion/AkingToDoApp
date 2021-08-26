import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/models/blocs/auth/auth_bloc.dart';
import 'package:todo_app/models/blocs/auth/auth_state.dart';
import 'package:todo_app/models/providers/firebase_data.dart';
import 'package:todo_app/models/repositories/models/statictis.dart';
import 'package:todo_app/models/repositories/models/task.dart';
import 'package:todo_app/models/repositories/models/user.dart';
import 'package:todo_app/models/repositories/quick_note_repository.dart';
import 'package:todo_app/models/repositories/task_repository.dart';
import 'package:todo_app/models/repositories/user_repository.dart';
import 'package:todo_app/routes/main/profile_page/statistic_panel.dart';
import 'package:todo_app/routes/main/profile_page/user_info_panel.dart';
import 'task_in_category.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({ Key? key }) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> { 

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Colors.white10,
          elevation: 0, 
          title: Text('Profiles', style: TextStyle(fontSize: 20, color: Colors.black)),
          centerTitle: true,
        ),
        body: ProfileBody(),
      ),
    );
  }
}

class ProfileBody extends StatefulWidget {
  ProfileBody({ Key? key }) : super(key: key);

  @override
  _ProfileBodyState createState() => _ProfileBodyState();
}

class _ProfileBodyState extends State<ProfileBody> {

  FirebaseTaskRepository firebaseTaskRepository = FirebaseTaskRepository();
  late Stream<QuerySnapshot> totalEventCount;
  late Stream<QuerySnapshot> totalEventDoneCount;
  late Stream<QuerySnapshot> totalNoDueDateTaskCount;
  late Stream<QuerySnapshot> totalNoDueDateTaskDoneCount;
  late Stream<QuerySnapshot> totalTaskCount;
  late Stream<QuerySnapshot> totalTaskDoneCount;
  Stream<QuerySnapshot> totalQuickNoteCount = FirebaseQuickNoteRepository().requestTotalQuickNoteCount();
  late Stream<UserModel> user;

  @override
  void initState() {
    user = FirebaseUserRepository().getUserData(FirebaseDataProvider.uid);
    totalEventCount = firebaseTaskRepository.requestTotalEventCount();
    totalEventDoneCount = firebaseTaskRepository.requestTotalDoneEventCount();
    totalNoDueDateTaskCount = firebaseTaskRepository.requestTotalNoDueDateTaskCount();
    totalNoDueDateTaskDoneCount = firebaseTaskRepository.requestTotalNoDueDateTaskDoneCount();
    totalTaskCount = firebaseTaskRepository.requestTotalTaskCount();
    totalTaskDoneCount = firebaseTaskRepository.requestTotalDoneTaskCount();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 10),
      child: Column(
        children: [
          SizedBox(height: 25,),
          StreamBuilder<UserModel>(
            stream: user,
            builder: (context, userSnapshot) {
              return StreamBuilder<QuerySnapshot>(
                stream: totalTaskCount,
                builder: (context, totalTaskSnapshot) {
                  return StreamBuilder<QuerySnapshot>(
                    stream: totalTaskDoneCount,
                    builder: (context, totalTaskDoneSnapshot) {
                      if ((userSnapshot.hasError)||(totalTaskSnapshot.hasError)||(totalTaskDoneSnapshot.hasError)) {
                        return Center(
                          child: Text('you should seperate them'),
                        );
                      }
                      if ((!userSnapshot.hasData)||(!totalTaskSnapshot.hasData)||(!totalTaskDoneSnapshot.hasData)) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      UserModel user = userSnapshot.data!;
                      return UserInfoPanel(
                        userEmail: user.email, 
                        userName: user.name, 
                        userUrlImg: user.imgUrl,
                        userTotalDoneTask: totalTaskDoneSnapshot.data!.size.toString(),
                        userTotalTask: totalTaskSnapshot.data!.size.toString(),
                      );
                    }
                  );
                }
              );
            }
          ),
          SizedBox(height: 40,),
          //Nesting stream builder is absolute fucking terrible
          StreamBuilder<QuerySnapshot>(
            stream: totalEventCount,
            builder: (context, eventSnapshot) {
              return StreamBuilder<QuerySnapshot>(
                stream: totalEventDoneCount,
                builder: (context, eventDoneSnapshot) {
                  return StreamBuilder<QuerySnapshot>(
                    stream: totalNoDueDateTaskCount,
                    builder: (context, taskSnapshot) {
                      return StreamBuilder<QuerySnapshot>(
                        stream: totalNoDueDateTaskDoneCount,
                        builder: (context, taskDoneSnapshot) {
                          return StreamBuilder<QuerySnapshot>(
                            stream: totalQuickNoteCount,
                            builder: (context, quickNoteSnapshot) {
                              return StreamBuilder<QuerySnapshot>(
                                stream: null,
                                builder: (context, quickNoteDoneSnapshot) {
                                  if ((eventSnapshot.hasError)||(eventDoneSnapshot.hasError)||(taskSnapshot.hasError)||(taskDoneSnapshot.hasError)||(quickNoteSnapshot.hasError)) {
                                    return Center(
                                      child: Text('you should seperate them'),
                                    );
                                  }
                                  if ((!eventSnapshot.hasData)||(!eventDoneSnapshot.hasData)||(!taskSnapshot.hasData)||(!taskDoneSnapshot.hasData)||(!quickNoteSnapshot.hasData)) {
                                    return const Center(child: CircularProgressIndicator());
                                  }

                                  List<TasksStatictis> _taskStatictis = [
                                    TasksStatictis(totalTask: eventSnapshot.data!.size, doneTask: eventDoneSnapshot.data!.size, color: Color.fromRGBO(249, 96, 96, 1), type: 'Events'),
                                    TasksStatictis(totalTask: taskSnapshot.data!.size, doneTask: taskDoneSnapshot.data!.size, color: Color.fromRGBO(96, 116, 249, 1), type: 'To do Tasks'),
                                    TasksStatictis(totalTask: quickNoteSnapshot.data!.size, doneTask: 0, color: Color.fromRGBO(133, 96, 249, 1), type: 'Quick Notes'),
                                  ];
                                  return Column(
                                    children: [
                                      TasksInCategory(taskStatictis: _taskStatictis,),
                                      StatictisPanel(taskStatictis: _taskStatictis,),
                                    ],
                                  );
                                }
                              );
                            }
                          );
                        }
                      );
                    }
                  );
                }
              );
            }
          ),
        ],
      ),
    );
  }
}
