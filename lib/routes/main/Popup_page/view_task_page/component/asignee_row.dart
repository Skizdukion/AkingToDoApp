import 'package:flutter/material.dart';
import 'package:todo_app/routes/main/popup_page/view_task_page/component/component_template.dart';
import 'package:todo_app/widgets/const_decoration.dart';


class AsigneeRow extends StatelessWidget {
  const AsigneeRow({ Key? key, required this.urlImg, required this.userName }) : super(key: key);
  final String urlImg;
  final String userName;

  @override
  Widget build(BuildContext context) {
    return ComponentTemplate(
      child: [
        CircleAvatar(
          radius: 20, 
          backgroundImage: NetworkImage(urlImg),                     
        ),
        SizedBox(width: 10,),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Assigned to",  style: textLight154StyleW400S14.copyWith(fontWeight: FontWeight.bold, fontSize: 16)),
            SizedBox(height: 5,),
            Text(userName, style: textDarkStyleS18.copyWith(fontSize: 16),),
          ],
        ),
      ],
    );
  }
}
