import 'package:flutter/material.dart';
import 'package:todo_app/models/repositories/models/project.dart';
import 'package:todo_app/models/repositories/models/user.dart';
import 'package:todo_app/models/repositories/project_repository.dart';
import 'package:todo_app/models/repositories/user_repository.dart';
import 'package:todo_app/routes/main/Popup_page/new_task/add_member_col.dart';
import 'package:todo_app/routes/main/popup_page/new_task/asignee_suggest_panel.dart';
import 'package:todo_app/routes/main/popup_page/new_task/project_suggest_panel.dart';
import 'package:todo_app/widgets/const_decoration.dart';

import 'desc_panel.dart';
import 'due_date_picker.dart';
import 'for_in_row.dart';

class NewTaskPage extends StatefulWidget {
  const NewTaskPage({ Key? key }) : super(key: key);

  @override
  _NewTaskPageState createState() => _NewTaskPageState();
}

class _NewTaskPageState extends State<NewTaskPage> with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(249, 96, 96, 1),
          elevation: 0, 
          title: Text('New Task', style: TextStyle(fontSize: 20)),
          centerTitle: true,
        ),
        body: Container(
          child: NewTaskForm(),
          decoration: BoxDecoration(
            image: DecorationImage(
            image: AssetImage('assets/background_1.png'),
            fit: BoxFit.cover,
          ),
          ),
        ),
      ),
    );
  }
}

class NewTaskForm extends StatefulWidget {
  const NewTaskForm({ Key? key }) : super(key: key);

  @override
  _NewTaskFormState createState() => _NewTaskFormState();
}

class _NewTaskFormState extends State<NewTaskForm> {
  FakeUserRepository _userRepository = FakeUserRepository();
  FakeProjectRepository _projectRepository = FakeProjectRepository();
  late List<UserModel> userList;
  late List<ProjectModel> projectList;
  late String asignText;
  late String projectText;
  bool isSelectedAsgin = false;
  bool isSelectedProject = false;
  bool isSelectingAsign = false;
  bool isSelectingProject = false;
  UserModel? userSelect;
  ProjectModel? projectSelect;

  @override
  void initState() {
    asignText = '';
    projectText = '';
    userList = []..addAll(_userRepository.getUserList());
    projectList = []..addAll(_projectRepository.getPorjectList());
    for (var item in projectList) {
      print('${item.id} init');
    }
    print('i was here');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 10, left: 16, right: 16, bottom: 30),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              offset: Offset(0.0, 1.0), //(x,y)
              blurRadius: 1.0,
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20,),
            ForInRow(
              projectFieldOnChange: projectOnChange, 
              projectFieldOntap: projectOnTap, 
              asigneeFieldOnChange: asigneeOnChange, 
              asigneeFieldOntap: asigneeOnTap,
              asigneeFieldReset: asigneeReset,
              projectFieldReset: projectReset,
              userSelect: userSelect,
              projectSelect: projectSelect,
            ),
            if ((isSelectingAsign == true)||(isSelectingProject == true)) SizedBox(height: 20,),
            if (isSelectingAsign == true) AsigneeSuggestPanel(userList: userList, onSelectUser: onSelectAsignee,),
            if (isSelectingProject == true) ProjectSuggestPanel(projectList: projectList, onSelectProject: onSelectProject,),
            if ((isSelectingProject == false)&&(isSelectingAsign == false)) TaskFormBody(),
          ],
        ),
      ),
    );
  }

  void asigneeOnTap(){
    print('asign on tap');

    setState(() {
      isSelectingAsign = true;
      isSelectingProject = false;
    });
  }

  void asigneeOnChange(String val){
    asignText = val;
    userList.clear();
    for (var item in FakeUserRepository.userList) {
      String name = item.name;
      String email = item.email;
      if (name.toLowerCase().contains(val.toLowerCase())||email.toLowerCase().contains(val.toLowerCase())){
        userList.add(item);
      }
    }
    setState(() {
      
    });
  }

  void projectOnTap(){
    print('project on tap');
    setState(() {
      isSelectingProject = true;
      isSelectingAsign = false;
    });
  }

  void projectOnChange(String val){
    projectText = val;
    projectList.clear();
    for (var item in FakeProjectRepository.projectList) {
      String title = item.title;
      if (title.toLowerCase().contains(val.toLowerCase())){
        projectList.add(item);
      }
    }
    setState(() {
      
    });
  }

  void onSelectAsignee(String id){
    userSelect = _userRepository.getUserWithId(id);
    setState(() {
      isSelectingAsign = false;
    });
  }

  void onSelectProject(String id){
    projectSelect = _projectRepository.getProjectWithId(id);
    setState(() {
      isSelectingProject = false;
    });
  }

  void asigneeReset(){
    userSelect = null;
    isSelectedAsgin = true;
    isSelectedProject = false;
    setState(() {
      
    });
  }

  void projectReset(){
    projectSelect = null;
    isSelectedAsgin = false;
    isSelectedProject = true;
    setState(() {
      
    });
  }

}

class TaskFormBody extends StatefulWidget {
  const TaskFormBody({ Key? key }) : super(key: key);

  @override
  _TaskFormBodyState createState() => _TaskFormBodyState();
}

class _TaskFormBodyState extends State<TaskFormBody> {
  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            child: Center(
              child: TextField(
                style: textDarkStyleS18,
                decoration: new InputDecoration.collapsed(
                  hintText: 'Title',
                  hintStyle: textDarkStyleS18,
                ),
                autofocus: true,
              ),
            ),
            color: Color.fromRGBO(244, 244, 244, 1),
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            height: 60,
          ),
          DescriptionPanel(),
          DueDatePicker(),
          AddMemberCol(),
          Padding(
            padding: const EdgeInsets.only(left: 25, right: 25),
            child: SizedBox(
              width: double.maxFinite,
              child: ElevatedButton(
                onPressed: (){},
                style: buttonStyleAuthPages,
                child: Text(
                  "Add Task",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
