import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/global/decoration/text_decoration.dart';
import 'package:todo_app/logic/blocs/auth/auth_bloc.dart';
import 'package:todo_app/logic/blocs/auth/auth_state.dart';
import 'package:todo_app/logic/blocs/task/task_bloc.dart';
import 'package:todo_app/logic/blocs/task/task_state.dart';
import 'package:todo_app/logic/models/task.dart';
import 'package:todo_app/logic/repositories/task_repository.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/views/routes/main/task_page/component/slidable_task_item.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TodayPage extends StatefulWidget {
  const TodayPage({Key? key}) : super(key: key);

  @override
  _TodayPageState createState() => _TodayPageState();
}

class _TodayPageState extends State<TodayPage> {
  late DateTime now;
  late DateTime tommorrow;
  late String nowText;
  late String tommorrowText;
  late Stream<List<TaskModel>> tommorowTaskList;
  late Stream<List<TaskModel>> todayTaskList;
  late AuthState authState;

  @override
  void initState() {
    authState = BlocProvider.of<AuthBloc>(context).state;
    now = DateTime.now();
    tommorrow = now.add(Duration(days: 1));
    nowText = ('TODAY, ' + DateFormat('MMM d/yyyy').format(now)).toUpperCase();
    tommorrowText = ('TOMMORROW, ' + DateFormat('MMM d/yyyy').format(tommorrow))
        .toUpperCase();
    if (authState is LoggeddUser) {
      todayTaskList =
          (authState as LoggeddUser).firebaseDataProvider.streamFromFirebase.todayTaskList;
      tommorowTaskList = (authState as LoggeddUser)
          .firebaseDataProvider
          .streamFromFirebase
          .tommorowTaskList;
    } else {
      throw ("access denied ${authState.toString()}");
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<TaskBloc, TaskState>(
      listener: (BuildContext context, state) {
        (authState as LoggeddUser).firebaseDataProvider.streamFromFirebase.todayTaskList =
            FirebaseTaskRepository().getStreamTaskListForDay(now);
        (authState as LoggeddUser).firebaseDataProvider.streamFromFirebase.tommorowTaskList =
            FirebaseTaskRepository().getStreamTaskListForDay(tommorrow);
        todayTaskList =
            (authState as LoggeddUser).firebaseDataProvider.streamFromFirebase.todayTaskList;
        tommorowTaskList = (authState as LoggeddUser)
            .firebaseDataProvider
            .streamFromFirebase
            .tommorowTaskList;
      },
      child: Padding(
          padding: EdgeInsets.fromLTRB(20.w, 24.h, 20.w, 0),
          child: ListView(
            children: [
              StreamBuilder<List<TaskModel>>(
                  stream: todayTaskList,
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
                    return Column(
                      children: [
                        SizedBox(
                          height: 20.h,
                        ),
                        (data.length != 0)
                            ? Text(nowText,
                                style: AppTextDecoration.light154W400S14)
                            : Text("THERE IS NOTHING TODAY",
                                style: AppTextDecoration.light154W400S14),
                        ListView.builder(
                          itemCount: data.length,
                          itemBuilder: (context, index) {
                            return TaskItem(
                              task: data[index],
                              key: Key(data[index].taskId),
                            );
                          },
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                        ),
                      ],
                    );
                  }),
              SizedBox(
                height: 20.h,
              ),
              StreamBuilder<List<TaskModel>>(
                  stream: tommorowTaskList,
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
                    return Column(
                      children: [
                        (data.length != 0)
                            ? Text(tommorrowText,
                                style: AppTextDecoration.light154W400S14)
                            : Text("THERE IS NOTHING TOMMORROW",
                                style: AppTextDecoration.light154W400S14),
                        SizedBox(
                          height: 20.h,
                        ),
                        ListView.builder(
                          itemCount: data.length,
                          itemBuilder: (context, index) {
                            return TaskItem(
                              task: data[index],
                              key: Key(data[index].taskId),
                            );
                          },
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                        ),
                      ],
                    );
                  }),
            ],
          )),
    );
  }
}
