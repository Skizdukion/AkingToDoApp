import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/logic/blocs/auth/auth_bloc.dart';
import 'package:todo_app/logic/blocs/auth/auth_state.dart';
import 'package:todo_app/logic/blocs/task/task_bloc.dart';
import 'package:todo_app/logic/blocs/task/task_state.dart';
import 'package:todo_app/logic/models/task.dart';

import 'calendar.dart';

class MonthPage extends StatefulWidget {
  const MonthPage({Key? key}) : super(key: key);

  @override
  _MonthPageState createState() => _MonthPageState();
}

class _MonthPageState extends State<MonthPage> {
  late Stream<List<TaskModel>> allTaskList;
  late TaskBloc taskBloc;
  late AuthState authState;

  @override
  void initState() {
    taskBloc = BlocProvider.of<TaskBloc>(context);
    authState = BlocProvider.of<AuthBloc>(context).state;
    if (authState is LoggeddUser) {
      allTaskList =
          (authState as LoggeddUser).firebaseDataProvider.cache.allTaskList;
    } else {
      throw ("access denied ${authState.toString()}");
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<TaskBloc, TaskState>(
      listener: (BuildContext context, state) {
        (authState as LoggeddUser).firebaseDataProvider.cache.allTaskList =
            taskBloc.state.firebaseTaskRepository.getStreamAllTask();
        allTaskList =
            (authState as LoggeddUser).firebaseDataProvider.cache.allTaskList;
      },
      child: StreamBuilder<List<TaskModel>>(
          stream: allTaskList,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error.toString()),
              );
            }
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }
            final data = snapshot.requireData;
            return Padding(
              padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: TaskCalendar(data: data),
            );
          }),
    );
  }
}
