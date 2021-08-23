import 'package:flutter/material.dart';
import 'package:todo_app/models/repositories/models/task.dart';
import 'package:todo_app/models/repositories/task_repository.dart';

import 'calendar.dart';

class MonthPage extends StatefulWidget {
  const MonthPage({ Key? key }) : super(key: key);

  @override
  _MonthPageState createState() => _MonthPageState();
}

class _MonthPageState extends State<MonthPage> {

  late Stream<List<TaskModel>> taskList;

  @override
  void initState() {
    taskList = FireBaseTaskRepository().getStreamAllTask();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<TaskModel>>(
      stream: taskList,
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
      }
    );
  }
}