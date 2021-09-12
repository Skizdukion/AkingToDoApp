import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/logic/blocs/auth/auth_bloc.dart';
import 'package:todo_app/logic/blocs/auth/auth_state.dart';
import 'package:todo_app/logic/models/statictis.dart';
import 'package:todo_app/logic/models/user.dart';
import 'package:todo_app/logic/repositories/task_repository.dart';
import 'package:todo_app/views/routes/main/profile_page/component/statistic_panel.dart';
import 'package:todo_app/views/routes/main/profile_page/component/user_info_panel.dart';
import 'component/task_in_category.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

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
          title: Text('Profiles',
              style: TextStyle(fontSize: 20, color: Colors.black)),
          centerTitle: true,
        ),
        body: ProfileBody(),
      ),
    );
  }
}

class ProfileBody extends StatefulWidget {
  ProfileBody({Key? key}) : super(key: key);

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
  late Stream<QuerySnapshot> totalQuickNoteCount;
  late Stream<UserModel> user;
  late AuthState authState;

  @override
  void initState() {
    authState = BlocProvider.of<AuthBloc>(context).state;
    if (authState is LoggeddUser) {
      user = (authState as LoggeddUser).firebaseDataProvider.cache.userLogged;
      totalEventCount =
          (authState as LoggeddUser).firebaseDataProvider.cache.totalEventCount;
      totalEventDoneCount = (authState as LoggeddUser)
          .firebaseDataProvider
          .cache
          .totalEventDoneCount;
      totalNoDueDateTaskCount = (authState as LoggeddUser)
          .firebaseDataProvider
          .cache
          .totalNoDueDateTaskCount;
      totalNoDueDateTaskDoneCount = (authState as LoggeddUser)
          .firebaseDataProvider
          .cache
          .totalNoDueDateTaskDoneCount;
      totalTaskCount =
          (authState as LoggeddUser).firebaseDataProvider.cache.totalTaskCount;
      totalTaskDoneCount = (authState as LoggeddUser)
          .firebaseDataProvider
          .cache
          .totalTaskDoneCount;
      totalQuickNoteCount = (authState as LoggeddUser)
          .firebaseDataProvider
          .cache
          .totalQuickNoteCount;
    } else {
      throw ("access denied ${authState.toString()}");
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 10),
      child: Column(
        children: [
          SizedBox(
            height: 25,
          ),
          StreamBuilder<UserModel>(
              stream: user,
              builder: (context, userSnapshot) {
                return StreamBuilder<QuerySnapshot>(
                    stream: totalTaskCount,
                    builder: (context, totalTaskSnapshot) {
                      return StreamBuilder<QuerySnapshot>(
                          stream: totalTaskDoneCount,
                          builder: (context, totalTaskDoneSnapshot) {
                            if ((userSnapshot.hasError) ||
                                (totalTaskSnapshot.hasError) ||
                                (totalTaskDoneSnapshot.hasError)) {
                              return Center(
                                child: Text('you should seperate them'),
                              );
                            }
                            if ((!userSnapshot.hasData) ||
                                (!totalTaskSnapshot.hasData) ||
                                (!totalTaskDoneSnapshot.hasData)) {
                              return const Center(
                                  child: CircularProgressIndicator());
                            }
                            UserModel user = userSnapshot.data!;
                            return UserInfoPanel(
                              userEmail: user.email,
                              userName: user.name,
                              userUrlImg: user.imgUrl,
                              userTotalDoneTask:
                                  totalTaskDoneSnapshot.data!.size.toString(),
                              userTotalTask:
                                  totalTaskSnapshot.data!.size.toString(),
                            );
                          });
                    });
              }),
          SizedBox(
            height: 40,
          ),
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
                                            builder: (context,
                                                quickNoteDoneSnapshot) {
                                              if ((eventSnapshot.hasError) ||
                                                  (eventDoneSnapshot
                                                      .hasError) ||
                                                  (taskSnapshot.hasError) ||
                                                  (taskDoneSnapshot.hasError) ||
                                                  (quickNoteSnapshot
                                                      .hasError)) {
                                                return Center(
                                                  child: Text(
                                                      'you should seperate them'),
                                                );
                                              }
                                              if ((!eventSnapshot.hasData) ||
                                                  (!eventDoneSnapshot
                                                      .hasData) ||
                                                  (!taskSnapshot.hasData) ||
                                                  (!taskDoneSnapshot.hasData) ||
                                                  (!quickNoteSnapshot
                                                      .hasData)) {
                                                return const Center(
                                                    child:
                                                        CircularProgressIndicator());
                                              }

                                              List<TasksStatictis>
                                                  _taskStatictis = [
                                                TasksStatictis(
                                                    totalTask: eventSnapshot
                                                        .data!.size,
                                                    doneTask: eventDoneSnapshot
                                                        .data!.size,
                                                    color: Color.fromRGBO(
                                                        249, 96, 96, 1),
                                                    type: 'Events'),
                                                TasksStatictis(
                                                    totalTask:
                                                        taskSnapshot.data!.size,
                                                    doneTask: taskDoneSnapshot
                                                        .data!.size,
                                                    color: Color.fromRGBO(
                                                        96, 116, 249, 1),
                                                    type: 'To do Tasks'),
                                                TasksStatictis(
                                                    totalTask: quickNoteSnapshot
                                                        .data!.size,
                                                    doneTask: 0,
                                                    color: Color.fromRGBO(
                                                        133, 96, 249, 1),
                                                    type: 'Quick Notes'),
                                              ];
                                              return Column(
                                                children: [
                                                  TasksInCategory(
                                                    taskStatictis:
                                                        _taskStatictis,
                                                  ),
                                                  StatictisPanel(
                                                    taskStatictis:
                                                        _taskStatictis,
                                                  ),
                                                ],
                                              );
                                            });
                                      });
                                });
                          });
                    });
              }),
        ],
      ),
    );
  }
}
