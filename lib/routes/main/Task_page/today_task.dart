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
  late DateTime now;
  late DateTime tommorrow;
  late List<TaskModel> todayTask;
  late List<TaskModel> tommorrowTask;
  late String nowText;
  late String tommorrowText;


  @override
  void initState() {
    now = DateTime.now();
    tommorrow = now.add(Duration(days: 1));
    todayTask = _taskRepository.getTaskListForDay('userID', now);
    tommorrowTask = _taskRepository.getTaskListForDay('userID', tommorrow);
    nowText =('TODAY, ' + DateFormat('MMM d/yyyy').format(now)).toUpperCase();
    tommorrowText =('TOMMORROW, ' + DateFormat('MMM d/yyyy').format(tommorrow)).toUpperCase();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(20, 24, 20, 0),
      child: ListView(
        children: [
          (todayTask.length != 0) ? Text(nowText, style: textLight154StyleW400S14) : Text("THERE IS NOTHING TODAY", style: textLight154StyleW400S14),
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
          (tommorrowTask.length != 0) ? Text(tommorrowText, style: textLight154StyleW400S14) : Text("THERE IS NOTHING TOMMORROW", style: textLight154StyleW400S14),
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
    _taskRepository.deleteTask(id);
    todayTask = _taskRepository.getTaskListForDay('userID', now);
    tommorrowTask = _taskRepository.getTaskListForDay('userID', tommorrow);
    setState(() {
     
    });
  }
}
