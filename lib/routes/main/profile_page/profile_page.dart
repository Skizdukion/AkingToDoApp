import 'package:flutter/material.dart';
import 'package:todo_app/models/repositories/models/statictis.dart';
import 'package:todo_app/widgets/const_decoration.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({ Key? key }) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Colors.white10,
          elevation: 0, 
          title: Text('Profiles', style: TextStyle(fontSize: 20, color: Colors.black)),
          centerTitle: true,
        ),
        body: ProfileBody(),
      ),
    );
  }
}

class ProfileBody extends StatefulWidget {
  const ProfileBody({ Key? key }) : super(key: key);

  @override
  _ProfileBodyState createState() => _ProfileBodyState();
}

class _ProfileBodyState extends State<ProfileBody> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 10),
      child: Column(
        children: [
          UserInfoBox(),
          SizedBox(height: 25,),
          TasksInCategory(),
        ],
      ),
    );
  }
}

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

class UserInfoBox extends StatefulWidget {
  const UserInfoBox({ Key? key }) : super(key: key);

  @override
  _UserInfoBoxState createState() => _UserInfoBoxState();
}

class _UserInfoBoxState extends State<UserInfoBox> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        child: Material(
          elevation: 2.0,
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
          child: Padding(
            padding: const EdgeInsets.only(left: 25),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 25),
                      child: CircleAvatar(
                        radius: 32, 
                        backgroundImage: NetworkImage('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTv7Qrvj5xHRuCCDSoqi9U-IqESntWh4bMG5w&usqp=CAU'),                     
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 40, left: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Long Pham", style: textDarkStyleS18.copyWith(fontWeight: FontWeight.bold),),
                            Text('rider993sinus@gmail.com', style: textLight154StyleW400S14.copyWith(fontSize: 16),),
                          ],
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.settings),
                      onPressed: (){},
                      iconSize: 15,
                    ),
                  ],
                ),
                const SizedBox(height: 30,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('120', style: textDarkStyleS18.copyWith(fontWeight: FontWeight.bold)),
                        Text('Created Tasks', style: textLight154StyleW400S14.copyWith(fontSize: 16)),
                      ],
                    ),
                    SizedBox(width: 50,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('80', style: textDarkStyleS18.copyWith(fontWeight: FontWeight.bold)),
                        Text('Completed Tasks', style: textLight154StyleW400S14.copyWith(fontSize: 16)),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 30,),
              ]
            ),
          ),
        ),
      ),
    );
  }
}



