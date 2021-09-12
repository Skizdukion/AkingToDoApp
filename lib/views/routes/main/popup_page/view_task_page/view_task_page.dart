import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:todo_app/global/decoration/button_decoration.dart';
import 'package:todo_app/global/decoration/text_decoration.dart';
import 'package:todo_app/logic/models/project.dart';
import 'package:todo_app/logic/models/task.dart';
import 'package:todo_app/logic/models/user.dart';
import 'package:todo_app/logic/repositories/project_repository.dart';
import 'package:todo_app/logic/repositories/task_repository.dart';
import 'package:todo_app/logic/repositories/user_repository.dart';
import 'package:todo_app/views/widgets/member_list_picker.dart';
import 'package:todo_app/views/widgets/project_list_pickder.dart';
import 'package:todo_app/views/widgets/stretch_button.dart';
import 'component/asignee_row.dart';
import 'component/desc_row.dart';
import 'component/due_date_row.dart';
import 'component/member_list_row.dart';
import 'component/tag_row.dart';

class TaskViewPage extends StatefulWidget {
  const TaskViewPage({Key? key, required this.task}) : super(key: key);
  final TaskModel task;

  @override
  _TaskViewPageState createState() => _TaskViewPageState();
}

class _TaskViewPageState extends State<TaskViewPage> {
  late Stream<UserModel> userOwnerStream;
  late Stream<TaskModel> task;

  @override
  void initState() {
    task = FirebaseTaskRepository().getStreamTaskWithId(widget.task.taskId);
    userOwnerStream =
        FirebaseUserRepository().getStreamUserWithId(widget.task.userId);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<TaskModel>(
        stream: task,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          }
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          TaskModel dataTask = snapshot.data!;
          return Container(
            height: 650,
            child: Column(
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context, false);
                      },
                      icon: Icon(
                        Icons.close,
                        size: 16,
                      ),
                    ),
                    Spacer(),
                    PopupMenuButton(
                      itemBuilder: (context) => [
                        PopupMenuItem<int>(
                          child: Text('Change Project List'),
                          value: 0,
                        ),
                        PopupMenuItem(
                          child: Text('Change Member List'),
                          value: 1,
                        ),
                        PopupMenuItem(
                          child: Text('Delete Task'),
                          value: 2,
                        ),
                      ],
                      icon: const Icon(
                        Icons.settings,
                        color: Colors.black,
                      ),
                      iconSize: 30,
                      onSelected: (int value) {
                        if (value == 2) {
                          FirebaseTaskRepository().deleteTask(dataTask.taskId);
                          Navigator.pop(context, false);
                        }
                        if (value == 1) {
                          _showMemberListPopupPage(MemberListPicker(
                            memberList: dataTask.memberList,
                          ));
                        }
                        if (value == 0) {
                          _showProjectListPopupPage(
                              ProjectListPicker(
                                  projectList: dataTask.projectList),
                              dataTask.projectList);
                        }
                      },
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5.0))),
                      offset: Offset(-10, 40),
                    )
                  ],
                ),
                Flexible(
                  child: Text(
                    dataTask.title,
                    style: AppTextDecoration.darkS18
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                StreamBuilder<UserModel>(
                    stream: userOwnerStream,
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Center(
                          child: Text('Failed'),
                        );
                      }
                      if (!snapshot.hasData) {
                        return const AsigneeRow(
                          urlImg:
                              'https://i.pinimg.com/originals/10/b2/f6/10b2f6d95195994fca386842dae53bb2.png',
                          userName: '...',
                        );
                      }
                      UserModel userOwner = snapshot.data!;
                      return AsigneeRow(
                        urlImg: userOwner.imgUrl,
                        userName: userOwner.name,
                      );
                    }),
                SizedBox(
                  height: 20,
                ),
                DueDateRow(
                  dueDate: dataTask.dueDate,
                  isEvent: dataTask.isEvent,
                ),
                SizedBox(
                  height: 20,
                ),
                DescRow(
                  description: dataTask.description,
                ),
                SizedBox(
                  height: 20,
                ),
                MemberListRow(
                  memberList: dataTask.memberList,
                ),
                SizedBox(
                  height: 20,
                ),
                TagRow(
                  projectList: dataTask.projectList,
                ),
                SizedBox(
                  height: 20,
                ),
                StrechButton(
                  text: !dataTask.isDone ? 'Complete Task' : 'Uncomplete Task',
                  onPressed: () {
                    Navigator.pop(context, true);
                  },
                  buttonStyle: AppButtonDecoration.authenticate2.copyWith(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        !dataTask.isDone
                            ? Color.fromRGBO(96, 116, 249, 1)
                            : Color.fromRGBO(249, 96, 96, 1)),
                  ),
                  horizontalPadding: 25,
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          );
        });
  }

  _showMemberListPopupPage(MemberListPicker memberListPicker) async {
    List<UserModel>? returnList = await showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Dialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0)),
                backgroundColor: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: memberListPicker,
                ),
                insetPadding: EdgeInsets.symmetric(horizontal: 20),
              ));
        });
    if (returnList != null) {
      List<String> updateList = [];
      for (var item in returnList) {
        updateList.add(item.id);
      }
      FirebaseTaskRepository()
          .updateMemberListInTaskId(widget.task.taskId, updateList);
    }
  }

  _showProjectListPopupPage(
      ProjectListPicker projectListPicker, List<String> originalList) async {
    List<ProjectModel>? returnList = await showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Dialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0)),
                backgroundColor: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: projectListPicker,
                ),
                insetPadding: EdgeInsets.symmetric(horizontal: 20),
              ));
        });
    if (returnList != null) {
      List<String> updateList = [];
      for (var item in originalList) {
        await FirebaseProjectRepository().updateTotalTask(item, -1);
      }
      for (var item in returnList) {
        updateList.add(item.id);
        await FirebaseProjectRepository().updateTotalTask(item.id, 1);
      }
      FirebaseTaskRepository()
          .updateProjectListInTaskId(widget.task.taskId, updateList);
    }
  }
}
