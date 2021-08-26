import 'package:flutter/material.dart';
import 'package:todo_app/models/repositories/models/project.dart';
import 'package:todo_app/utils/frequent_use_fuction.dart';
import 'package:todo_app/widgets/const_decoration.dart';

class ProjectItem extends StatelessWidget {
  const ProjectItem({ Key? key, required this.item }) : super(key: key);
  final ProjectModel item;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 165,
      height: 180,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.only(top: 24, left: 24),
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
            SizedBox(height: 50,),
            Text(limitString(item.title, 15), style: TextStyle(fontSize: 18, color: Colors.black),),
            SizedBox(height: 20,),
            Text('${item.totalTask} Tasks', style: textLight154StyleW400S14.copyWith(fontSize: 16),)
          ],
        ),
      ),
    );
  }
}
