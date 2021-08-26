import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/models/repositories/models/task.dart';
import 'package:todo_app/models/repositories/task_repository.dart';
import 'package:todo_app/routes/main/popup_page/view_task_page/view_task_page.dart';
import 'package:todo_app/widgets/const_decoration.dart';

class TaskItem extends StatefulWidget {
  const TaskItem({ Key? key, required this.task}) : super(key: key);
  final TaskModel task;

  @override
  _TaskItemState createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {
  @override
  Widget build(BuildContext context) {
    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      showAllActionsThreshold: 0.1,
      actionExtentRatio: 0.25,
      child: Card(
        margin: EdgeInsets.symmetric(vertical: 8),
        color: Colors.white,
        elevation: 3.0,
        child: ListTile(
          leading: IconButton(
            icon: Icon(
              !widget.task.isDone ? Icons.circle_outlined : Icons.check_circle_rounded,
              color: !widget.task.isDone ? Color.fromRGBO(96, 116, 249, 1) : Color.fromRGBO(249, 96, 96, 1),
            ),
            onPressed:() => changDoneState(),
          ),
          title: Text(widget.task.title, style: !widget.task.isDone ? textDarkStyleW400S16 : textLineThroughStyle),
          subtitle: Text(DateFormat('hh:mm a').format(widget.task.dueDate!), style: !widget.task.isDone ? textLight154StyleW400S14 : textLineThroughStyle.copyWith(fontSize: 14),),
          shape: Border(
            right: BorderSide(width: 4.0, color: widget.task.isDone ? Colors.red : Color.fromRGBO(96, 116, 249, 1), style: BorderStyle.solid),
          ),
        ),
      ),
      actions: <Widget>[
        IconSlideAction(
          color: Colors.white10,
          iconWidget: Icon(Icons.edit_outlined, color: Color.fromRGBO(249, 96, 96, 1)),
          onTap: _showTaskDetail,
        ),
        Container(
          child: IconSlideAction(
            color: Colors.white10,
            iconWidget: Icon(Icons.delete_outline, color: Color.fromRGBO(249, 96, 96, 1)),
            onTap: deleteTask,
          ),
          decoration: BoxDecoration(
            color: Colors.white10,
            border: Border(
              left: BorderSide(width: 0.5, color: Colors.black, style: BorderStyle.solid),
            ),
          ),
        ),
      ],
      secondaryActions: <Widget>[
        Container(
          child: IconSlideAction(
            color: Colors.white10,
            iconWidget: Icon(Icons.edit_outlined, color: Color.fromRGBO(249, 96, 96, 1)),
            onTap: _showTaskDetail,
          ),
          decoration: BoxDecoration(
            color: Colors.white10,
            border: Border(
              right: BorderSide(width: 0.5, color: Colors.black, style: BorderStyle.solid),
            ),
          ),
        ),
        IconSlideAction(
          color: Colors.white10,
          iconWidget: Icon(Icons.delete_outline, color: Color.fromRGBO(249, 96, 96, 1)),
          onTap: deleteTask,
        ),
      ],
    );
  }

  void changDoneState(){
    FirebaseTaskRepository().changeDoneState(widget.task);
  }

  void deleteTask(){
    FirebaseTaskRepository().deleteTask(widget.task.taskId);
  }

  _showTaskDetail() async{
    bool isClickChangeDoneState = await showDialog(
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
              child: TaskViewPage(item: widget.task,),
            ),
            insetPadding: EdgeInsets.symmetric(horizontal: 20),
          )
        );
      }
    );
    if (isClickChangeDoneState){
      changDoneState();
    }
  }

}