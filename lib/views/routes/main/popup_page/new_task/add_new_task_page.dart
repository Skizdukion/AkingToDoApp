import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/global/decoration/button_decoration.dart';
import 'package:todo_app/global/decoration/text_decoration.dart';
import 'package:todo_app/global/error/create_string_error.dart';
import 'package:todo_app/logic/blocs/new_task/new_task_bloc.dart';
import 'package:todo_app/logic/blocs/new_task/new_task_state.dart';
import 'package:todo_app/logic/models/task.dart';
import 'package:todo_app/logic/providers/firebase_data.dart';
import 'package:todo_app/logic/repositories/task_repository.dart';
import 'package:todo_app/views/utils/extension/snack_bar.dart';
import 'package:todo_app/views/widgets/stretch_button.dart';
import 'new_task_page_component/add_member_col.dart';
import 'new_task_page_component/asignee_suggest_panel.dart';
import 'new_task_page_component/desc_panel.dart';
import 'new_task_page_component/due_date_picker.dart';
import 'new_task_page_component/for_in_row.dart';
import 'new_task_page_component/project_suggest_panel.dart';

class NewTaskPage extends StatefulWidget {
  const NewTaskPage({Key? key}) : super(key: key);

  @override
  _NewTaskPageState createState() => _NewTaskPageState();
}

class _NewTaskPageState extends State<NewTaskPage>
    with SingleTickerProviderStateMixin {
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
  const NewTaskForm({Key? key}) : super(key: key);

  @override
  _NewTaskFormState createState() => _NewTaskFormState();
}

class _NewTaskFormState extends State<NewTaskForm> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewTaskBloc, NewTaskState>(builder: (context, state) {
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
                SizedBox(
                  height: 20,
                ),
                ForInRow(),
                if (state.status == NewTaskStatus.asigneeSelecting)
                  AsigneeSuggestPanel(),
                if (state.status == NewTaskStatus.projectSelecting)
                  ProjectSuggestPanel(),
                if (state.status == NewTaskStatus.normal)
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          child: Center(
                            child: TextFormField(
                              style: AppTextDecoration.darkS18,
                              decoration: new InputDecoration.collapsed(
                                hintText: 'Title',
                                hintStyle: AppTextDecoration.darkS18,
                              ),
                              autofocus: true,
                              controller: _titleController,
                            ),
                          ),
                          color: Color.fromRGBO(244, 244, 244, 1),
                          padding:
                              EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                          height: 60,
                        ),
                        DescriptionPanel(
                          descriptionController: _descriptionController,
                        ),
                        DueDatePicker(),
                        AddMemberCol(),
                        StrechButton(
                          text: 'Done',
                          onPressed: () async {
                            if (_titleController.text == '') {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  ExpandedSnackBar.failureSnackBar(
                                      context, ErrorInCreate.emptyTitleTask));
                            } else if (state.user == null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  ExpandedSnackBar.failureSnackBar(
                                      context, ErrorInCreate.emptyAsigneeTask));
                            } else if (state.project == null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  ExpandedSnackBar.failureSnackBar(
                                      context, ErrorInCreate.emptyProjectTask));
                            } else if (state.user!.id !=
                                FirebaseDataProvider.uid) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  ExpandedSnackBar.failureSnackBar(
                                      context, ErrorInCreate.permissionDenied));
                            } else {
                              FirebaseTaskRepository fireBaseTaskRepository =
                                  FirebaseTaskRepository();
                              await fireBaseTaskRepository.addNewTask(TaskModel(
                                title: _titleController.text,
                                taskId: 'this field is unneccessary',
                                time: DateTime.now(),
                                userId: state.user!.id,
                                dueDate: state.dueDate ?? DateTime.now(),
                                description: _descriptionController.text,
                                memberList: [
                                  for (var item in state.memberList) item.id
                                ],
                                projectList: [
                                  state.project!.id,
                                ],
                                isEvent: (state.dueDate != null),
                              ));
                              Navigator.pop(context, true);
                            }
                          },
                          buttonStyle: AppButtonDecoration.authenticate2,
                          horizontalPadding: 25,
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ));
    });
  }
}
