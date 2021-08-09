import 'package:flutter/material.dart';
import 'package:todo_app/models/repositories/models/statictis.dart';

class TasksInCategory extends StatefulWidget {
  const TasksInCategory({ Key? key }) : super(key: key);

  @override
  _TasksInCategoryState createState() => _TasksInCategoryState();
}

class _TasksInCategoryState extends State<TasksInCategory> {
  late List<TasksStatictis> _taskStatictis;

  @override
  void initState() {
    _taskStatictis = [
      TasksStatictis(totalTask: 12, doneTask: 6, color: Color.fromRGBO(249, 96, 96, 1), type: 'Events'),
      TasksStatictis(totalTask: 20, doneTask: 5, color: Color.fromRGBO(96, 116, 249, 1), type: 'To do Tasks'),
      TasksStatictis(totalTask: 12, doneTask: 6, color: Color.fromRGBO(133, 96, 249, 1), type: 'Quick Notes'),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.0,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _taskStatictis.length,
        itemBuilder: (context, index){
          return TaskCountBox(taskStatic: _taskStatictis[index],);
        },
      ),
    );
  }
}

class TaskCountBox extends StatefulWidget {
  const TaskCountBox({ Key? key, required this.taskStatic }) : super(key: key);
  final TasksStatictis taskStatic;

  @override
  _TaskCountBoxState createState() => _TaskCountBoxState();
}

class _TaskCountBoxState extends State<TaskCountBox> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20),
      child: Container(
        width: 160,
        decoration: BoxDecoration(
          color: widget.taskStatic.color,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Padding(
          padding: EdgeInsets.only(top: 27, left: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('${widget.taskStatic.type}', style: TextStyle(fontSize: 18, color: Colors.white),),
              SizedBox(height: 10,),
              Text('${widget.taskStatic.totalTask} Tasks', style: TextStyle(fontSize: 14, color: Colors.white),),
            ],
          ),
        ),
      ),
    );
  }
}