import 'dart:ui';

import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/global/decoration/text_decoration.dart';
import 'package:todo_app/logic/models/task.dart';
import 'package:todo_app/logic/repositories/task_repository.dart';
import 'package:todo_app/views/routes/main/popup_page/view_task_page/view_task_page.dart';

class TaskItem extends StatefulWidget {
  const TaskItem({Key? key, required this.task}) : super(key: key);
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
              !widget.task.isDone
                  ? Icons.circle_outlined
                  : Icons.check_circle_rounded,
              color: !widget.task.isDone
                  ? Color.fromRGBO(96, 116, 249, 1)
                  : Color.fromRGBO(249, 96, 96, 1),
            ),
            onPressed: () => changDoneState(),
          ),
          title: Text(widget.task.title,
              style: !widget.task.isDone
                  ? AppTextDecoration.darkW400S16
                  : AppTextDecoration.lineThrough),
          subtitle: Text(
            DateFormat('hh:mm a').format(widget.task.dueDate!),
            style: !widget.task.isDone
                ? AppTextDecoration.light154W400S14
                : AppTextDecoration.lineThrough.copyWith(fontSize: 14),
          ),
          shape: Border(
            right: BorderSide(
                width: 4.0,
                color: widget.task.isDone
                    ? Colors.red
                    : Color.fromRGBO(96, 116, 249, 1),
                style: BorderStyle.solid),
          ),
        ),
      ),
      actions: <Widget>[
        IconSlideAction(
          color: Colors.white10,
          iconWidget:
              Icon(Icons.edit_outlined, color: Color.fromRGBO(249, 96, 96, 1)),
          onTap: _showTaskDetail,
        ),
        Container(
          child: IconSlideAction(
            color: Colors.white10,
            iconWidget: Icon(Icons.delete_outline,
                color: Color.fromRGBO(249, 96, 96, 1)),
            onTap: deleteTask,
          ),
          decoration: BoxDecoration(
            color: Colors.white10,
            border: Border(
              left: BorderSide(
                  width: 0.5, color: Colors.black, style: BorderStyle.solid),
            ),
          ),
        ),
      ],
      secondaryActions: <Widget>[
        Container(
          child: IconSlideAction(
            color: Colors.white10,
            iconWidget: Icon(Icons.edit_outlined,
                color: Color.fromRGBO(249, 96, 96, 1)),
            onTap: _showTaskDetail,
          ),
          decoration: BoxDecoration(
            color: Colors.white10,
            border: Border(
              right: BorderSide(
                  width: 0.5, color: Colors.black, style: BorderStyle.solid),
            ),
          ),
        ),
        IconSlideAction(
          color: Colors.white10,
          iconWidget:
              Icon(Icons.delete_outline, color: Color.fromRGBO(249, 96, 96, 1)),
          onTap: deleteTask,
        ),
      ],
    );
  }

  void changDoneState() {
    FirebaseTaskRepository().updateDoneState(widget.task);
  }

  void deleteTask() async {
    var result = await showOkCancelAlertDialog(
        context: context, title: 'Are you wish to delete this?');
    if (result == OkCancelResult.ok) {
      FirebaseTaskRepository().deleteTask(widget.task.taskId);
    }
  }

  _showTaskDetail() async {
    bool? isClickChangeDoneState = await showDialog(
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
                  child: TaskViewPage(
                    task: widget.task,
                  ),
                ),
                insetPadding: EdgeInsets.symmetric(horizontal: 20),
              ));
        });
    if (isClickChangeDoneState != null) {
      if (isClickChangeDoneState) changDoneState();
    }
  }
}
