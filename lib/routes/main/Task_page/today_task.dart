import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/models/blocs/auth/auth_bloc.dart';
import 'package:todo_app/models/blocs/auth/auth_state.dart';
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

  late DateTime now;
  late DateTime tommorrow;
  late String nowText;
  late String tommorrowText;
  late Stream<List<TaskModel>> tommorowTaskList;
  late Stream<List<TaskModel>> todayTaskList;
  late FirebaseTaskRepository _fireBaseTaskRepository = FirebaseTaskRepository();

  @override
  void initState() {
    now = DateTime.now();
    tommorrow = now.add(Duration(days: 1));
    nowText =('TODAY, ' + DateFormat('MMM d/yyyy').format(now)).toUpperCase();
    tommorrowText =('TOMMORROW, ' + DateFormat('MMM d/yyyy').format(tommorrow)).toUpperCase();
    todayTaskList = _fireBaseTaskRepository.getStreamTaskListForDay(now);
    tommorowTaskList = _fireBaseTaskRepository.getStreamTaskListForDay(tommorrow);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    
    return Padding(
      padding: EdgeInsets.fromLTRB(20, 24, 20, 0),
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
                  SizedBox(height: 20,),
                  (data.length != 0) ? Text(nowText, style: textLight154StyleW400S14) : Text("THERE IS NOTHING TODAY", style: textLight154StyleW400S14),
                  ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (context, index){
                      return TaskItem(task: data[index], key: Key(data[index].taskId),);
                    },
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                  ),
                ],
              );
            }
          ),
          SizedBox(height: 20,),
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
                  (data.length != 0) ? Text(tommorrowText, style: textLight154StyleW400S14) : Text("THERE IS NOTHING TOMMORROW", style: textLight154StyleW400S14),
                  SizedBox(height: 20,),
                  ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (context, index){
                      return TaskItem(task: data[index], key: Key(data[index].taskId),);
                    },
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                  ),
                ],
              );
            }
          ),
        ],
      )
    );
  }
}


  // @override
  // Widget build(BuildContext context) {
  //   return BlocListener<MainPageBloc, MainPageState>(
  //     listener: (context, state){
  //       if(state is Loading){
  //         data = _taskRepository.getTaskListForDay('userID', now);
  //         tommorrowTask.value = _taskRepository.getTaskListForDay('userID', tommorrow);
  //         context.read<MainPageBloc>().add(SwitchPage(pageIndex: 0));
  //       }
  //     },
  //     child: Padding(
  //       padding: EdgeInsets.fromLTRB(20, 24, 20, 0),
  //       child: ListView(
  //         children: [
  //           (data.length != 0) ? Text(nowText, style: textLight154StyleW400S14) : Text("THERE IS NOTHING TODAY", style: textLight154StyleW400S14),
  //           SizedBox(height: 10,),
  //           ListView.builder(
  //             itemCount: data.length,
  //             itemBuilder: (context, index){
  //               return TaskItem(task: data[index], deleteTask: deleteTask,);
  //             },
  //             shrinkWrap: true,
  //             physics: const NeverScrollableScrollPhysics(),
  //           ),
  //           SizedBox(height: 10,),
  //           (tommorrowTask.value.length != 0) ? Text(tommorrowText, style: textLight154StyleW400S14) : Text("THERE IS NOTHING TOMMORROW", style: textLight154StyleW400S14),
  //           SizedBox(height: 10,),
  //           ListView.builder(
  //             itemCount: tommorrowTask.value.length,
  //             itemBuilder: (context, index){
  //               return TaskItem(task: tommorrowTask.value[index], deleteTask: deleteTask,);
  //             },
  //             shrinkWrap: true,
  //             physics: const NeverScrollableScrollPhysics(),
  //           ),
  //         ],
  //       )
  //     )
  //   );
  // }

  // void deleteTask(String id){
  //   _taskRepository.deleteTask(id);
  //   data = _taskRepository.getTaskListForDay('userID', now);
  //   tommorrowTask.value = _taskRepository.getTaskListForDay('userID', tommorrow);
  //   setState(() {
      
  //   });
  // }
