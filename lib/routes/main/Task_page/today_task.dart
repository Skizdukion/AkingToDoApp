import 'package:flutter/material.dart';
import 'package:todo_app/models/repositories/models/task.dart';
import 'package:todo_app/models/repositories/task_repository.dart';
import 'package:todo_app/routes/main/Task_page/slidable_task_item.dart';
import 'package:todo_app/widgets/const_decoration.dart';
import 'package:intl/intl.dart';

class TodayPage extends StatefulWidget {
  const TodayPage({ Key? key }) : super(key: key);

  @override
  _TodayPageState createState() => _TodayPageState();
}

class _TodayPageState extends State<TodayPage> {

  TaskRepository _taskRepository = FakeTaskRepository();

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    DateTime tommorrow = now.add(Duration(days: 1));
    List<TaskModel> todayTask = _taskRepository.getTaskListForDay('userID', now);
    List<TaskModel> tommorrowTask = _taskRepository.getTaskListForDay('userID', tommorrow);
    String nowText =('TODAY, ' + DateFormat('MMM d/yyyy').format(now)).toUpperCase();
    String tommorrowText =('TOMMORROW, ' + DateFormat('MMM d/yyyy').format(tommorrow)).toUpperCase();
    return Padding(
      padding: EdgeInsets.fromLTRB(20, 24, 20, 0),
      child: ListView(
        children: [
          (todayTask.length != 0) ? Text(nowText, style: textDateStyle) : Text("THERE IS NOTHING TODAY", style: textDateStyle),
          SizedBox(height: 10,),
          ListView.builder(
            itemCount: todayTask.length,
            itemBuilder: (context, index){
              return TaskItem(task: todayTask[index], deleteTask: deleteTask,);
            },
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
          ),
          SizedBox(height: 10,),
          (tommorrowTask.length != 0) ? Text(tommorrowText, style: textDateStyle) : Text("THERE IS NOTHING TOMMORROW", style: textDateStyle),
          SizedBox(height: 10,),
          ListView.builder(
            itemCount: tommorrowTask.length,
            itemBuilder: (context, index){
              return TaskItem(task: tommorrowTask[index], deleteTask: deleteTask,);
            },
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
          ),
        ],
      )
    );
  }

  void deleteTask(String id){
    setState(() {
      _taskRepository.deleteTask(id);
    });
  }
}


