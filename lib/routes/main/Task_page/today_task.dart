import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/models/blocs/main_page/main_page_bloc.dart';
import 'package:todo_app/models/blocs/main_page/main_page_event.dart';
import 'package:todo_app/models/blocs/main_page/main_page_state.dart';
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
  late ValueNotifier<List<TaskModel>> todayTask;
  late ValueNotifier<List<TaskModel>> tommorrowTask;
  late String nowText;
  late String tommorrowText;


  @override
  void initState() {
    now = DateTime.now();
    tommorrow = now.add(Duration(days: 1));
    todayTask = ValueNotifier(_taskRepository.getTaskListForDay('userID', now));
    tommorrowTask = ValueNotifier(_taskRepository.getTaskListForDay('userID', tommorrow));
    nowText =('TODAY, ' + DateFormat('MMM d/yyyy').format(now)).toUpperCase();
    tommorrowText =('TOMMORROW, ' + DateFormat('MMM d/yyyy').format(tommorrow)).toUpperCase();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<MainPageBloc, MainPageState>(
      listener: (context, state){
        if(state is Loading){
          todayTask.value = _taskRepository.getTaskListForDay('userID', now);
          tommorrowTask.value = _taskRepository.getTaskListForDay('userID', tommorrow);
          context.read<MainPageBloc>().add(SwitchPage(pageIndex: 0));
        }
      },
      child: Padding(
        padding: EdgeInsets.fromLTRB(20, 24, 20, 0),
        child: ListView(
          children: [
            (todayTask.value.length != 0) ? Text(nowText, style: textLight154StyleW400S14) : Text("THERE IS NOTHING TODAY", style: textLight154StyleW400S14),
            SizedBox(height: 10,),
            ListView.builder(
              itemCount: todayTask.value.length,
              itemBuilder: (context, index){
                return TaskItem(task: todayTask.value[index], deleteTask: deleteTask,);
              },
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
            ),
            SizedBox(height: 10,),
            (tommorrowTask.value.length != 0) ? Text(tommorrowText, style: textLight154StyleW400S14) : Text("THERE IS NOTHING TOMMORROW", style: textLight154StyleW400S14),
            SizedBox(height: 10,),
            ListView.builder(
              itemCount: tommorrowTask.value.length,
              itemBuilder: (context, index){
                return TaskItem(task: tommorrowTask.value[index], deleteTask: deleteTask,);
              },
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
            ),
          ],
        )
      )
    );
  }

  void deleteTask(String id){
    _taskRepository.deleteTask(id);
    todayTask.value = _taskRepository.getTaskListForDay('userID', now);
    tommorrowTask.value = _taskRepository.getTaskListForDay('userID', tommorrow);
    setState(() {
      
    });
  }
}
