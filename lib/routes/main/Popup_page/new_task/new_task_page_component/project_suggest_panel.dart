import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/models/blocs/new_task/new_task_bloc.dart';
import 'package:todo_app/models/blocs/new_task/new_task_event.dart';
import 'package:todo_app/models/blocs/new_task/new_task_state.dart';
import 'package:todo_app/models/repositories/models/project.dart';
import 'package:todo_app/widgets/const_decoration.dart';

class ProjectSuggestPanel extends StatefulWidget {
  const ProjectSuggestPanel({ Key? key,}) : super(key: key);

  @override
  _ProjectSuggestPanelState createState() => _ProjectSuggestPanelState();
}

class _ProjectSuggestPanelState extends State<ProjectSuggestPanel> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewTaskBloc, NewTaskState>(
      builder: (context, state){
        return Flexible(
          child: Container(
            decoration: BoxDecoration(
              color: Color.fromRGBO(244, 244, 244, 1),
              borderRadius: BorderRadius.circular(5),
            ),
            child: ListView.builder(
              itemCount: state.projectList.length,
              itemBuilder: (context, index){
                return ProjectSuggestion(item: state.projectList[index],);
              },
            ),
          )
        );
      }
    );
  }
}

class ProjectSuggestion extends StatefulWidget {
  const ProjectSuggestion({ Key? key, required this.item}) : super(key: key);
  final ProjectModel item;
  @override
  _ProjectSuggestionState createState() => _ProjectSuggestionState();
}

class _ProjectSuggestionState extends State<ProjectSuggestion> {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16, left: 16, bottom:10),
      child: InkWell(
        child: Container(
          child: Row(
            children: [
              CircleAvatar(
                radius: 20, 
                backgroundColor: widget.item.color,                  
              ),
              SizedBox(width: 10,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("${widget.item.title}", style: textDarkStyleS18.copyWith(fontWeight: FontWeight.bold, fontSize: 16),),
                  Text('${widget.item.totalTask}', style: textLight154StyleW400S14,),
                ],
              )
            ],
          ),
        ),
        onTap: (){
          context.read<NewTaskBloc>().add(ProjectOnSelected(projectSelected: widget.item));
        },
      )
    );
  }
}