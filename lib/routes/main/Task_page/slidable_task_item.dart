import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/models/repositories/models/task.dart';
import 'package:todo_app/models/repositories/task_repository.dart';
import 'package:todo_app/widgets/const_decoration.dart';

class TaskItem extends StatefulWidget {
  const TaskItem({ Key? key, required this.task, required this.deleteTask}) : super(key: key);
  final TaskModel task;
  final Function(String) deleteTask;

  @override
  _TaskItemState createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {
  TaskRepository _taskRepository = FakeTaskRepository();
  @override
  Widget build(BuildContext context) {
    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      showAllActionsThreshold: 0.1,
      actionExtentRatio: 0.25,
      child: (!widget.task.isDone) ? Card(
        margin: EdgeInsets.symmetric(vertical: 8),
        color: Colors.white,
        elevation: 3.0,
        child: ListTile(
          leading: IconButton(
            icon: Icon(
              Icons.circle_outlined,
              color: Color.fromRGBO(96, 116, 249, 1),
            ),
            onPressed:() => changDoneState(),
          ),
          title: Text(widget.task.title, style: textTaskTile),
          subtitle: Text(DateFormat('hh:mm a').format(widget.task.time), style: textTaskDateTimeNotDone,),
          shape: Border(
            right: BorderSide(width: 4.0, color: widget.task.barColor, style: BorderStyle.solid),
          ),
        ),
      ) : Card(
        margin: EdgeInsets.symmetric(vertical: 8),
        color: Colors.white,
        elevation: 3.0,
        child: ListTile(
          leading: IconButton(
            icon: Icon(
              Icons.check_circle_rounded,
              color: Color.fromRGBO(249, 96, 96, 1),
            ),
            onPressed:() => changDoneState(),
          ),
          title: Text(widget.task.title, style: textTaskDateTimeDone),
          subtitle: Text(DateFormat('hh:mm a').format(widget.task.time), style: textTaskDateTimeDone,),
          shape: Border(
            right: BorderSide(width: 4.0, color: widget.task.barColor, style: BorderStyle.solid),
          ),
        ),
      ),
      actions: <Widget>[
        IconSlideAction(
          color: Colors.white10,
          iconWidget: Icon(Icons.edit_outlined, color: Color.fromRGBO(249, 96, 96, 1)),
          onTap: () => (){},
        ),
        Container(
          child: IconSlideAction(
            color: Colors.white10,
            iconWidget: Icon(Icons.delete_outline, color: Color.fromRGBO(249, 96, 96, 1)),
            onTap:() => widget.deleteTask(widget.task.taskId),
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
            onTap: () => (){},
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
          onTap:() => widget.deleteTask(widget.task.taskId),
        ),
      ],
    );
  }

  void changDoneState(){
    setState(() {
      _taskRepository.changeTaskDoneState(widget.task.taskId);
    });
  }

}