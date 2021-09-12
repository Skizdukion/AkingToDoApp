import 'package:flutter/material.dart';
import 'package:todo_app/global/decoration/text_decoration.dart';
import 'package:todo_app/logic/models/project.dart';
import 'package:todo_app/logic/repositories/project_repository.dart';
import 'package:todo_app/utils/frequent_use_fuction.dart';
import 'component_template.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TagRow extends StatelessWidget {
  const TagRow({Key? key, required this.projectList}) : super(key: key);
  final List<String> projectList;

  @override
  Widget build(BuildContext context) {
    return ComponentTemplate(child: [
      SizedBox(
        height: 10.h,
      ),
      Icon(
        Icons.tag,
        size: 15,
      ),
      SizedBox(
        width: 25.w,
      ),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Tag",
              style: AppTextDecoration.light154W400S14
                  .copyWith(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            SizedBox(
              height: 5.h,
            ),
            Container(
              height: 38.h,
              child: ListView(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                children: [
                  for (var item in projectList)
                    ProjectTag(
                      projectId: item,
                    ),
                ],
              ),
            )
          ],
        ),
      ),
    ]);
  }
}

class ProjectTag extends StatefulWidget {
  const ProjectTag({Key? key, required this.projectId}) : super(key: key);
  final String projectId;

  @override
  _ProjectTagState createState() => _ProjectTagState();
}

class _ProjectTagState extends State<ProjectTag> {
  late Stream<ProjectModel> project;
  @override
  void initState() {
    project = FirebaseProjectRepository().getProjectWithId(widget.projectId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 10.w),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: Colors.blue),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: StreamBuilder<ProjectModel>(
              stream: project,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text('Failed'),
                  );
                }
                if (!snapshot.hasData) {
                  return const Text('...');
                }
                return Text(
                  limitString(snapshot.data!.title, 15),
                  style: TextStyle(
                    color: Color.fromRGBO(96, 116, 249, 1),
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                );
              }),
        ),
      ),
    );
  }
}
