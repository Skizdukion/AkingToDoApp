import 'package:flutter/material.dart';
import 'package:todo_app/models/repositories/models/project.dart';
import 'package:todo_app/widgets/const_decoration.dart';

class ProjectSuggestPanel extends StatefulWidget {
  const ProjectSuggestPanel({ Key? key, required this.projectList, required this.onSelectProject }) : super(key: key);
  final List<ProjectModel> projectList;
  final ValueSetter<String> onSelectProject;

  @override
  _ProjectSuggestPanelState createState() => _ProjectSuggestPanelState();
}

class _ProjectSuggestPanelState extends State<ProjectSuggestPanel> {
  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Container(
        decoration: BoxDecoration(
          color: Color.fromRGBO(244, 244, 244, 1),
          borderRadius: BorderRadius.circular(5),
        ),
        child: ListView.builder(
          itemCount: widget.projectList.length,
          itemBuilder: (context, index){
            return ProjectSuggestion(item: widget.projectList[index], onSelectedProject: widget.onSelectProject,);
          },
        ),
      )
    );
  }
}

class ProjectSuggestion extends StatefulWidget {
  const ProjectSuggestion({ Key? key, required this.item, required this.onSelectedProject}) : super(key: key);
  final ProjectModel item;
  final ValueSetter<String> onSelectedProject;
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
        onTap: () => widget.onSelectedProject(widget.item.id),
        // onTap: (){
        //   print(widget.item.totalTask);
        // },
      )
    );
  }
}