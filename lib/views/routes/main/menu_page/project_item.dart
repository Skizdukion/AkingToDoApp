import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/global/decoration/text_decoration.dart';
import 'package:todo_app/logic/models/project.dart';
import 'package:todo_app/logic/repositories/project_repository.dart';
import 'package:todo_app/utils/frequent_use_fuction.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProjectItem extends StatelessWidget {
  const ProjectItem({Key? key, required this.item}) : super(key: key);
  final ProjectModel item;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () => _showChangeTitleDialog(context),
      child: Container(
        width: 165.w,
        height: 180,
        color: Colors.white,
        child: Padding(
          padding: EdgeInsets.only(top: 24.w, left: 24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                backgroundColor: Color.fromRGBO(219, 221, 239, 1),
                radius: 13,
                child: Icon(
                  Icons.circle,
                  color: item.color,
                  size: 17,
                ),
              ),
              SizedBox(
                height: 50.h,
              ),
              Text(
                limitString(item.title, 15),
                style: TextStyle(fontSize: 18, color: Colors.black),
              ),
              SizedBox(
                height: 20.h,
              ),
              Text(
                '${item.totalTask} Tasks',
                style: AppTextDecoration.light154W400S14.copyWith(fontSize: 16),
              )
            ],
          ),
        ),
      ),
    );
  }

  _showChangeTitleDialog(context) async{
    final text = await showTextInputDialog(
        context: context,
        title: 'Change project title',
        textFields: [
          DialogTextField(hintText: 'Project ame', initialText: item.title),
        ]);
    if (text != null) {
      if ((text.first != item.title) && (text.first.isNotEmpty))
        await FirebaseProjectRepository().changeProjectTitle(text.first, item.id);
    }
  }

  void deleteProject(){

  }
}
