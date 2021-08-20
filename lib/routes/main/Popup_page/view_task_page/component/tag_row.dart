import 'package:flutter/material.dart';
import 'package:todo_app/models/repositories/models/project.dart';
import 'package:todo_app/models/repositories/project_repository.dart';
import 'package:todo_app/routes/main/popup_page/view_task_page/component/component_template.dart';
import 'package:todo_app/widgets/const_decoration.dart';

class TagRow extends StatelessWidget {
  const TagRow({ Key? key, required this.projectList }) : super(key: key);
  final List<String> projectList;

  @override
  Widget build(BuildContext context) {
    return ComponentTemplate(child: [
      SizedBox(height: 10,),
      Icon(
        Icons.tag,
        size: 15,
      ),
      SizedBox(width: 25,),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Tag", style: textLight154StyleW400S14.copyWith(fontWeight: FontWeight.bold, fontSize: 16),),
            SizedBox(height: 5,),
            Container(
              height: 38,
              child: ListView(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                children: [               
                  for (var item in projectList) ProjectTag(projectId: item,),
                ],
              ),
            )          
          ],
        ),
      ),
    ]);
  }
}

class ProjectTag extends StatelessWidget {
  const ProjectTag({ Key? key, required this.projectId }) : super(key: key);
  final String projectId;
  
  @override
  Widget build(BuildContext context) {
    ProjectModel project = FakeProjectRepository().getProjectWithId(projectId)!;
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: Colors.blue),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            project.title, 
            style: TextStyle(
              color: Color.fromRGBO(96, 116, 249, 1),
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}

