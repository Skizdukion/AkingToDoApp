import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/models/blocs/new_task_bloc/new_task_bloc.dart';
import 'package:todo_app/models/blocs/new_task_bloc/new_task_state.dart';
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
        body: BlocProvider(
          create: (_) => NewTaskBloc(),
          child: Container(
            child: NewTaskForm(),
            decoration: BoxDecoration(
              image: DecorationImage(
              image: AssetImage('assets/background_1.png'),
              fit: BoxFit.cover,
            ),
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

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewTaskBloc, NewTaskState>(
      builder: (context, state){
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
              ForInRow(),
              if (state.status == NewTaskStatus.normal) TaskFormBody(),
              if (state.status == NewTaskStatus.asigneeSelecting) AsigneeSuggestPanel(),
              if (state.status == NewTaskStatus.projectSelecting) ProjectSuggestPanel(),
            ],
          ),
          )
        );
      }
    );
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
