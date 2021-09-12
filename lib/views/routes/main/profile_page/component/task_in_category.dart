import 'package:flutter/material.dart';
import 'package:todo_app/logic/models/statictis.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TasksInCategory extends StatefulWidget {
  const TasksInCategory({Key? key, required this.taskStatictis})
      : super(key: key);
  final List<TasksStatictis> taskStatictis;

  @override
  _TasksInCategoryState createState() => _TasksInCategoryState();
}

class _TasksInCategoryState extends State<TasksInCategory> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.0.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: widget.taskStatictis.length,
        itemBuilder: (context, index) {
          return TaskCountBox(
            taskStatic: widget.taskStatictis[index],
          );
        },
      ),
    );
  }
}

class TaskCountBox extends StatefulWidget {
  const TaskCountBox({Key? key, required this.taskStatic}) : super(key: key);
  final TasksStatictis taskStatic;

  @override
  _TaskCountBoxState createState() => _TaskCountBoxState();
}

class _TaskCountBoxState extends State<TaskCountBox> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 20.w),
      child: Container(
        width: 160.w,
        decoration: BoxDecoration(
          color: widget.taskStatic.color,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Padding(
          padding: EdgeInsets.only(top: 27.h, left: 24.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${widget.taskStatic.type}',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
              SizedBox(
                height: 10.h,
              ),
              Text(
                '${widget.taskStatic.totalTask} Tasks',
                style: TextStyle(fontSize: 14, color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
